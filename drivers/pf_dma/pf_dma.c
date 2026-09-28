#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/platform_device.h>
#include <linux/of.h>
#include <linux/io.h>
#include <linux/cdev.h>
#include <linux/device.h>
#include <linux/mm.h>
#include <linux/delay.h>
#include <linux/uaccess.h>
#include <linux/bitops.h>

#define DRIVER_NAME "pf_dma"
#define CLASS_NAME "telemetry"

/* DDR reserved for DMA operations */
#define RESERVED_DDR_BASE 0xA0000000UL
#define RESERVED_DDR_SIZE 0x02000000UL /* 32 MB */
#define STREAM_DESC_PHYS_ADDR RESERVED_DDR_BASE
#define STREAM_DEST_OFFSET 0x0100UL
#define DDR_DEST_PHYS_ADDR (RESERVED_DDR_BASE + STREAM_DEST_OFFSET)

/* DMA registers */
#define DMA_VERSION_REG_OFFSET 0x000
#define INTR0_STAT_REG_OFFSET 0x010
#define INTR0_CLEAR_REG_OFFSET 0x018
#define INTR0_EXT_ADDR_OFFSET 0x01C
#define STR0ADDR_REG_OFFSET 0x460

#define STREAM_DEST_OPERAND BIT(0)
#define STREAM_DEST_DATA_READY BIT(2)
#define STREAM_DESCRIPTOR_VALID BIT(3)

#define DMA_STAT_COMPLETE BIT(0)
#define DMA_STAT_WRITE_ERROR BIT(1)
#define DMA_STAT_READ_ERROR BIT(2)
#define DMA_STAT_INVALID_DESC BIT(3)

#define AXI4_STREAM_DATA_WIDTH_BYTES sizeof(u64)
#define ROUND_TO_DATA_WIDTH(x) ((x) - ((x) % AXI4_STREAM_DATA_WIDTH_BYTES))
#define TEST_TRANSFER_SIZE 1024

/* GPIO regs */
#define GPIO_OUT_REG_OFFSET 0xA0
#define GENERATOR_START_BIT BIT(0)

/* IOCTL MAGIC */
#define TELEMETRY_IOC_MAGIC 'T'
#define TELEMETRY_IOC_ENABLE_GEN _IOW(TELEMETRY_IOC_MAGIC, 1, u32)

/* DMA descriptor for axi4streaming operation */
struct axi4dma_stream_desc {
    u32 config;
    u32 xfr_count;
    u32 dest_addr;
} __attribute__((packed, aligned(4)));

/* Device struct */
struct pf_dma_dev {
    void __iomem *regs;
    void __iomem *gpio_regs;
    resource_size_t phys_addr;
    resource_size_t phys_size;
    dev_t dev_num;
    struct cdev cdev;
    struct class *cl;
    struct device *device;
};

static struct pf_dma_dev *g_dev;

static int generator_set_start(struct pf_dma_dev *dev, bool enable) {
    u32 value, readback;
    value = ioread32(dev->gpio_regs + GPIO_OUT_REG_OFFSET);
    if (enable) value |= GENERATOR_START_BIT;
    else value &= ~GENERATOR_START_BIT;
    iowrite32(value, dev->gpio_regs + GPIO_OUT_REG_OFFSET);
    readback = ioread32(dev->gpio_regs + GPIO_OUT_REG_OFFSET);
    pr_info("%s: generator START = %u, GPIO_OUT = 0x%08x\n", DRIVER_NAME, enable ? 1 : 0, readback);
    if (enable) {
        if (!(readback & GENERATOR_START_BIT)) {
            pr_err("%s: failed to assert generator START\n", DRIVER_NAME);
            return -EIO;
        }
    } else {
        if (readback & GENERATOR_START_BIT) {
            pr_err("%s: failed to deassert generator START\n", DRIVER_NAME);
            return -EIO;
        }
    }
    return 0;
}

static void dump_descriptor(void) {
    struct axi4dma_stream_desc __iomem *desc = ioremap(STREAM_DESC_PHYS_ADDR, sizeof(*desc));
    if (!desc) {
        pr_err("%s: descriptor ioremap failed\n", DRIVER_NAME);
        return;
    }
    pr_info("%s: descriptor @ 0x%08lx\n", DRIVER_NAME, STREAM_DESC_PHYS_ADDR);
    pr_info("%s:    config    = 0x%08x\n", DRIVER_NAME, ioread32(&desc->config));
    pr_info("%s:    xfr_count = 0x%08x\n", DRIVER_NAME, ioread32(&desc->xfr_count));
    pr_info("%s:    dest_addr = 0x%08x\n", DRIVER_NAME, ioread32(&desc->dest_addr));
    iounmap(desc);
}

static void dump_payload_words(void) {
    void __iomem *payload = ioremap(DDR_DEST_PHYS_ADDR, 64);
    int i;
    if (!payload) {
        pr_err("%s: payload ioremap failed\n", DRIVER_NAME);
        return;
    }
    pr_info("%s: first payload words @ 0x%08lx\n", DRIVER_NAME, DDR_DEST_PHYS_ADDR);
    for (i = 0; i < 16; i++)
        pr_info("%s: payload[%02d] = 0x%08x\n", DRIVER_NAME, i, ioread32(payload + i * sizeof(u32)));
    iounmap(payload);
}

static u32 check_dma_status(struct pf_dma_dev *dev) {
    u32 status = ioread32(dev->regs + INTR0_STAT_REG_OFFSET);
    u32 ext_addr = ioread32(dev->regs + INTR0_EXT_ADDR_OFFSET);
    u32 stream_addr = ioread32(dev->regs + STR0ADDR_REG_OFFSET);
    u32 desc_num = (status >> 4) & 0x3F;

    pr_info("%s: -------- DMA STATUS --------\n", DRIVER_NAME);
    pr_info("%s: STATUS       = 0x%08x\n", DRIVER_NAME, status);
    pr_info("%s: descriptor   = %u\n", DRIVER_NAME, desc_num);
    pr_info("%s: EXT_ADDR     = 0x%08x\n", DRIVER_NAME, ext_addr);
    pr_info("%s: STREAM0_ADDR = 0x%08x\n", DRIVER_NAME, stream_addr);

    if (status & DMA_STAT_COMPLETE) pr_info("%s: DMA COMPLETE\n", DRIVER_NAME);
    if (status & DMA_STAT_WRITE_ERROR) pr_err("%s: DMA AXI WRITE ERROR\n", DRIVER_NAME);
    if (status & DMA_STAT_READ_ERROR) pr_err("%s: DMA AXI READ ERROR\n", DRIVER_NAME);
    if (status & DMA_STAT_INVALID_DESC) pr_err("%s: DMA INVALID DESCRIPTOR\n", DRIVER_NAME);
    if (status == 0) pr_info("%s: no DMA status event\n", DRIVER_NAME);
    pr_info("%s: ----------------------------\n", DRIVER_NAME);

    return status;
}

static int start_dma_transfer(struct pf_dma_dev *dev, size_t xfr_size) {
    struct axi4dma_stream_desc __iomem *desc;
    u32 rounded_size = ROUND_TO_DATA_WIDTH(xfr_size);
    u32 readback;

    if (!rounded_size) return -EINVAL;

    pr_info("%s: preparing DMA transfer\n", DRIVER_NAME);
    pr_info("%s: descriptor phys = 0x%08lx\n", DRIVER_NAME, STREAM_DESC_PHYS_ADDR);
    pr_info("%s: destination phys = 0x%08lx\n", DRIVER_NAME, DDR_DEST_PHYS_ADDR);
    pr_info("%s: transfer size = %u bytes\n", DRIVER_NAME, rounded_size);

    desc = ioremap(STREAM_DESC_PHYS_ADDR, sizeof(*desc));
    if (!desc) {
        pr_err("%s: descriptor ioremap failed\n", DRIVER_NAME);
        return -ENOMEM;
    }

    iowrite32(0, &desc->config);
    iowrite32(rounded_size, &desc->xfr_count);
    iowrite32((u32)DDR_DEST_PHYS_ADDR, &desc->dest_addr);
    wmb();

    iowrite32(STREAM_DESCRIPTOR_VALID | STREAM_DEST_DATA_READY | STREAM_DEST_OPERAND, &desc->config);
    wmb();

    pr_info("%s: descriptor written\n", DRIVER_NAME);
    pr_info("%s:    config    = 0x%08x\n", DRIVER_NAME, ioread32(&desc->config));
    pr_info("%s:    xfr_count = 0x%08x\n", DRIVER_NAME, ioread32(&desc->xfr_count));
    pr_info("%s:    dest_addr = 0x%08x\n", DRIVER_NAME, ioread32(&desc->dest_addr));
    iounmap(desc);

    iowrite32(0xF, dev->regs + INTR0_CLEAR_REG_OFFSET);
    ioread32(dev->regs + INTR0_STAT_REG_OFFSET);

    iowrite32((u32)STREAM_DESC_PHYS_ADDR, dev->regs + STR0ADDR_REG_OFFSET);
    readback = ioread32(dev->regs + STR0ADDR_REG_OFFSET);

    pr_info("%s: VERSION      = 0x%08x\n", DRIVER_NAME, ioread32(dev->regs + DMA_VERSION_REG_OFFSET));
    pr_info("%s: STREAM0_ADDR = 0x%08x\n", DRIVER_NAME, readback);
    pr_info("%s: STATUS start = 0x%08x\n", DRIVER_NAME, ioread32(dev->regs + INTR0_STAT_REG_OFFSET));

    if (readback != (u32)STREAM_DESC_PHYS_ADDR) {
        pr_err("%s: STREAM0_ADDR readback mismatch\n", DRIVER_NAME);
        return -EIO;
    }

    pr_info("%s: DMA armed\n", DRIVER_NAME);
    return 0;
}

/* file_operations 1: open */
static int telemetry_open(struct inode *inode, struct file *file) {
    file->private_data = g_dev;
    return 0;
}

/* file_operations 2: release */
static int telemetry_release(struct inode *inode, struct file *file) {
    return 0;
}

/* file_operations 3: mmap */
static int telemetry_mmap(struct file *file, struct vm_area_struct *vma) {
    unsigned long size = vma->vm_end - vma->vm_start;
    unsigned long pfn = RESERVED_DDR_BASE >> PAGE_SHIFT;

    if (size > RESERVED_DDR_SIZE || vma->vm_pgoff != 0) return -EINVAL;

    vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
    if (remap_pfn_range(vma, vma->vm_start, pfn, size, vma->vm_page_prot))
        return -EAGAIN;

    return 0;
}

/* file_operations 4: ioctl */
static long telemetry_ioctl(struct file *file, unsigned int cmd, unsigned long arg) {
    struct pf_dma_dev *dev = file->private_data;
    u32 enable, status = 0;
    int ret, i;

    if (cmd != TELEMETRY_IOC_ENABLE_GEN) return -ENOTTY;
    if (copy_from_user(&enable, (void __user *)arg, sizeof(enable))) return -EFAULT;

    if (!enable) {
        generator_set_start(dev, false);
        check_dma_status(dev);
        dump_descriptor();
        dump_payload_words();
        return 0;
    }

    /* step 1: axis generator off */
    ret = generator_set_start(dev, false);
    if (ret) return ret;
    udelay(10);

    /* step 2: arm DMA while generator is stopped */
    ret = start_dma_transfer(dev, TEST_TRANSFER_SIZE);
    if (ret) return ret;

    /* step 3: start AXI4-stream generator */
    pr_info("%s: starting AXI4-Stream generator\n", DRIVER_NAME);
    ret = generator_set_start(dev, true);
    if (ret) return ret;

    /* step 4: poll DMA for completion/error (~100 ms max) TODO: replace with irq*/
    for (i = 0; i < 100; i++) {
        status = ioread32(dev->regs + INTR0_STAT_REG_OFFSET);
        if (status & (DMA_STAT_COMPLETE | DMA_STAT_WRITE_ERROR | DMA_STAT_READ_ERROR | DMA_STAT_INVALID_DESC))
            break;
        usleep_range(1000, 1500);
    }

    /* step 5: stop generator */
    generator_set_start(dev, false);

    /* step 6: dump debug info */
    check_dma_status(dev);
    dump_descriptor();
    dump_payload_words();

    if (status & (DMA_STAT_WRITE_ERROR | DMA_STAT_READ_ERROR | DMA_STAT_INVALID_DESC))
        return -EIO;

    if (!(status & DMA_STAT_COMPLETE)) {
        pr_err("%s: DMA transfer timed out\n", DRIVER_NAME);
        return -ETIMEDOUT;
    }

    return 0;
}

/* file_operations struct */
static const struct file_operations telemetry_fops = {
    .owner = THIS_MODULE,
    .open = telemetry_open,
    .release = telemetry_release,
    .mmap = telemetry_mmap,
    .unlocked_ioctl = telemetry_ioctl,
};

/* platform_driver operations 1: probe */
static int telemetry_probe(struct platform_device *pdev) {
    struct resource *res_dma, *res_gpio;
    int ret;

    pr_info("%s: probing\n", DRIVER_NAME);
    g_dev = devm_kzalloc(&pdev->dev, sizeof(*g_dev), GFP_KERNEL);
    if (!g_dev) return -ENOMEM;

    /* DMA resource */
    res_dma = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma_regs");
    if (!res_dma) {
        dev_err(&pdev->dev, "missing dma_regs resource\n");
        return -ENODEV;
    }
    g_dev->phys_addr = res_dma->start;
    g_dev->phys_size = resource_size(res_dma);
    dev_info(&pdev->dev, "DMA physical base = 0x%llx\n", (unsigned long long)g_dev->phys_addr);
    dev_info(&pdev->dev, "DMA register size = 0x%llx\n", (unsigned long long)g_dev->phys_size);

    g_dev->regs = devm_ioremap_resource(&pdev->dev, res_dma);
    if (IS_ERR(g_dev->regs)) return PTR_ERR(g_dev->regs);
    dev_info(&pdev->dev, "DMA VERSION = 0x%08x\n", ioread32(g_dev->regs + DMA_VERSION_REG_OFFSET));

    /* coreGPIO resource */
    res_gpio = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gpio_regs");
    if (!res_gpio) {
        dev_err(&pdev->dev, "missing gpio_regs resource\n");
        return -ENODEV;
    }
    g_dev->gpio_regs = devm_ioremap_resource(&pdev->dev, res_gpio);
    if (IS_ERR(g_dev->gpio_regs)) return PTR_ERR(g_dev->gpio_regs);

    dev_info(&pdev->dev, "GPIO physical base = 0x%llx\n", (unsigned long long)res_gpio->start);
    dev_info(&pdev->dev, "GPIO register size = 0x%llx\n", (unsigned long long)resource_size(res_gpio));

    ret = generator_set_start(g_dev, false);
    if (ret) return ret;

    /* Character device */
    ret = alloc_chrdev_region(&g_dev->dev_num, 0, 1, DRIVER_NAME);
    if (ret < 0) return ret;

    cdev_init(&g_dev->cdev, &telemetry_fops);
    g_dev->cdev.owner = THIS_MODULE;

    ret = cdev_add(&g_dev->cdev, g_dev->dev_num, 1);
    if (ret < 0) goto err_chrdev;

    g_dev->cl = class_create(CLASS_NAME);
    if (IS_ERR(g_dev->cl)) {
        ret = PTR_ERR(g_dev->cl);
        goto err_cdev;
    }

    g_dev->device = device_create(g_dev->cl, NULL, g_dev->dev_num, NULL, DRIVER_NAME);
    if (IS_ERR(g_dev->device)) {
        ret = PTR_ERR(g_dev->device);
        goto err_class;
    }

    platform_set_drvdata(pdev, g_dev);
    pr_info("%s: /dev/%s created\n", DRIVER_NAME, DRIVER_NAME);
    return 0;

    err_class:
    class_destroy(g_dev->cl);
    err_cdev:
    cdev_del(&g_dev->cdev);
    err_chrdev:
    unregister_chrdev_region(g_dev->dev_num, 1);
    return ret;
}

/* platform_driver operations 2: remove */
static void telemetry_remove(struct platform_device *pdev) {
    struct pf_dma_dev *dev = platform_get_drvdata(pdev);
    if (dev->gpio_regs) generator_set_start(dev, false);
    device_destroy(dev->cl, dev->dev_num);
    class_destroy(dev->cl);
    cdev_del(&dev->cdev);
    unregister_chrdev_region(dev->dev_num, 1);
    pr_info("%s: removed\n", DRIVER_NAME);
}

/* platform_driver operations 3.2: of_match_table */
static const struct of_device_id telemetry_of_match[] = {
    { .compatible = "polarfire,telemetry-dma" },
    { /* sentinel */ }
};
MODULE_DEVICE_TABLE(of, telemetry_of_match);

/* platform_driver struct */
static struct platform_driver telemetry_driver = {
    .probe = telemetry_probe,
    .remove = telemetry_remove,
    .driver = {
        .name = DRIVER_NAME,
        .of_match_table = telemetry_of_match,
    },
};

module_platform_driver(telemetry_driver);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Lorenzo Castelvero");
MODULE_DESCRIPTION("PolarFire SoC CoreAXI4DMA telemetry test driver");
