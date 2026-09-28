#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/io.h>
#include <linux/uaccess.h>
#include <linux/device.h>

/* Driver ID */
#define DRIVER_NAME     "pf_regs"
#define CLASS_NAME      "pf_class"

/*physical MM (PolarFire APB region) */
#define BASE_PHYS_ADDR  0x40000500
#define REG_REGION_SIZE 0x20

/* HDL module offsets */
#define REG_CONTROL8    0x18
#define REG_HARDWARE_ID 0x1C

static int major_num;
static void __iomem *mmio_base;
static struct class*  pf_class  = NULL;
static struct device* pf_device = NULL;

static int device_open(struct inode *inode, struct file *file) {
    return 0;
}

static int device_release(struct inode *inode, struct file *file) {
    return 0;
}

// Reading from FPGA registers
static ssize_t device_read(struct file *file, char __user *buffer, size_t length, loff_t *offset) {
    uint32_t reg_val;

    // 32-bit alignment sanity check
    if (*offset < 0 || *offset + sizeof(uint32_t) > REG_REGION_SIZE) {
        return 0;
    }

    // mmio_base + requested offset
    reg_val = readl(mmio_base + *offset);

    if (copy_to_user(buffer, &reg_val, sizeof(reg_val))) {
        return -EFAULT;
    }

    *offset += sizeof(reg_val);
    return sizeof(reg_val);
}

// Writing to FPGA registers
static ssize_t device_write(struct file *file, const char __user *buffer, size_t length, loff_t *offset) {
    uint32_t val_to_write = 0;
    loff_t target_offset = *offset;

    if (length == 0) return 0;

    // If writing at offset 0 (e.g. `echo > /dev/pf_regs`) default to targeting REG_CONTROL8 (0x18) for LED control
    if (target_offset == 0) {
        target_offset = REG_CONTROL8;
    }

    // Boundary check register space
    if (target_offset < 0 || target_offset >= REG_REGION_SIZE) {
        return -EINVAL;
    }

    // Limit buffer copy size to 4 bytes max
    if (length > sizeof(val_to_write)) {
        length = sizeof(val_to_write);
    }

    if (copy_from_user(&val_to_write, buffer, length)) {
        return -EFAULT;
    }

    writel(val_to_write, mmio_base + target_offset);

    *offset += length;
    return length;
}

static struct file_operations fops = {
    .owner   = THIS_MODULE,
    .open    = device_open,
    .release = device_release,
    .read    = device_read,
    .write   = device_write,
};

static int __init pf_regs_init(void) {
    uint32_t hardware_id;

    // 1: register character device
    major_num = register_chrdev(0, DRIVER_NAME, &fops);
    if (major_num < 0) {
        printk(KERN_ALERT "pf_regs: Failed to register major number\n");
        return major_num;
    }

    // 2: register device class creates node in /dev/pf_regs
    pf_class = class_create(CLASS_NAME);    if (IS_ERR(pf_class)) {
        unregister_chrdev(major_num, DRIVER_NAME);
        printk(KERN_ALERT "pf_regs: Failed to register device class\n");
        return PTR_ERR(pf_class);
    }

    // 3: populate device file
    pf_device = device_create(pf_class, NULL, MKDEV(major_num, 0), NULL, DRIVER_NAME);
    if (IS_ERR(pf_device)) {
        class_destroy(pf_class);
        unregister_chrdev(major_num, DRIVER_NAME);
        printk(KERN_ALERT "pf_regs: Failed to create device node\n");
        return PTR_ERR(pf_device);
    }

    // 4:map physical address space to kernel space
    mmio_base = ioremap(BASE_PHYS_ADDR, REG_REGION_SIZE);
    if (!mmio_base) {
        device_destroy(pf_class, MKDEV(major_num, 0));
        class_destroy(pf_class);
        unregister_chrdev(major_num, DRIVER_NAME);
        printk(KERN_ALERT "pf_regs: Failed to ioremap memory region\n");
        return -ENOMEM;
    }

    // sanity check read of HW_ID of verilog module (0x1C)
    hardware_id = readl(mmio_base + REG_HARDWARE_ID);
    printk(KERN_INFO "pf_regs: Loaded. Node /dev/%s created. HW_ID: 0x%08X\n", DRIVER_NAME, hardware_id);

    return 0;
}

static void __exit pf_regs_exit(void) {
    iounmap(mmio_base);
    device_destroy(pf_class, MKDEV(major_num, 0));
    class_destroy(pf_class);
    unregister_chrdev(major_num, DRIVER_NAME);
    printk(KERN_INFO "pf_regs: Unloaded cleanly\n");
}

module_init(pf_regs_init);
module_exit(pf_regs_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Lorenzo Castelvero");
MODULE_DESCRIPTION("PolarFire SoC DiscoKIT custom register APB driver");
