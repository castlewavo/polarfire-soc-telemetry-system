#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/ioctl.h>

#define DEV_PATH "/dev/pf_dma"
#define OUT_FILE_PATH "/tmp/telemetry_dma_stream.bin"
#define RESERVED_DDR_SIZE 0x02000000UL
#define PAYLOAD_OFFSET 0x0100UL

/* 128 x 64-bit words = 1024 bytes */
#define TEST_TRANSFER_SIZE 1024
#define OUTPUT_SIZE (64 * 1024)
#define TELEMETRY_IOC_MAGIC 'T'
#define TELEMETRY_IOC_ENABLE_GEN _IOW(TELEMETRY_IOC_MAGIC, 1, uint32_t)

/* Descriptor dump */
static void dump_descriptor(void *dma_buf)
{
    volatile uint32_t *desc;
    desc = (volatile uint32_t *)dma_buf;

    printf("\nDescriptor:\n");
    printf("  config    = 0x%08X\n", desc[0]);
    printf("  xfr_count = 0x%08X\n", desc[1]);
    printf("  dest_addr = 0x%08X\n", desc[2]);
    printf("\n");
}

/* Payload dump */
static void dump_payload(void *dma_buf)
{
    volatile uint64_t *payload;
    int i;

    payload = (volatile uint64_t *) ((uint8_t *)dma_buf + PAYLOAD_OFFSET);

    printf("First 16 64-bit words at payload offset 0x%lX:\n", PAYLOAD_OFFSET);

    for (i = 0; i < 16; i++) {
        printf(" [%02d] 0x%016llX\n", i, (unsigned long long) payload[i]);}
    printf("\n");
}

/* Main */
int main(void)
{
    int dev_fd;
    int out_fd;
    void *dma_buf;
    uint32_t start;
    ssize_t bytes_written;

    dev_fd = -1;
    out_fd = -1;
    start = 1;

    /* Open driver */
    dev_fd = open(DEV_PATH, O_RDWR | O_SYNC);

    if (dev_fd < 0) {
        perror("open /dev/pf_dma");
        return EXIT_FAILURE;
    }

    /* Map reserved DDR */
    dma_buf = mmap(NULL, RESERVED_DDR_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, dev_fd, 0);

    if (dma_buf == MAP_FAILED) {
        perror("mmap");
        close(dev_fd);
        return EXIT_FAILURE;
    }

    printf("[+] Reserved DDR mapped\n");
    printf("[+] Descriptor offset = 0x0000\n");
    printf("[+] Payload offset    = 0x%04lX\n", PAYLOAD_OFFSET);

    /* Fill DMA destination with A5 */
    memset((uint8_t *)dma_buf + PAYLOAD_OFFSET, 0xA5, TEST_TRANSFER_SIZE);

    printf("[+] Filled DMA destination with 0xA5 before transfer\n");
    printf("\nBEFORE DMA:\n");
    dump_payload(dma_buf);

    /* Trigger complete DMA sequence in kernel */
    printf("[+] Starting DMA transfer...\n");

    if (ioctl(dev_fd, TELEMETRY_IOC_ENABLE_GEN, &start) < 0) {
        perror("DMA ioctl");
        munmap(dma_buf, RESERVED_DDR_SIZE);
        close(dev_fd);
        return EXIT_FAILURE;
    }

    printf("[+] DMA ioctl returned\n");

    /* Inspect descriptor */
    dump_descriptor(dma_buf);

    /* Inspect destination */
    printf("AFTER DMA:\n");
    dump_payload(dma_buf);

    /*CHeck received pattern */
    volatile uint64_t *payload = (volatile uint64_t *)((uint8_t *)dma_buf + PAYLOAD_OFFSET);

    size_t mismatches = 0;

    for (size_t i = 0; i < TEST_TRANSFER_SIZE / sizeof(uint64_t); i++) {
        uint64_t expected = (uint64_t)i + 1;
        uint64_t actual = payload[i];

        if (actual != expected) {
            if (mismatches < 8) {
                fprintf(stderr,"Word %zu: expected %llu, got %llu\n", i, (unsigned long long)expected, (unsigned long long)actual);
            }
            mismatches++;
        }
    }

    if (mismatches)
        fprintf(stderr, "FAIL: %zu incorrect words\n", mismatches);
    else
        printf("PASS: all DMA words match\n");

    /* Save 64 KB for hexdump */
    out_fd = open(OUT_FILE_PATH, O_WRONLY | O_CREAT | O_TRUNC, 0644);

    if (out_fd >= 0) {
        bytes_written = write(out_fd, dma_buf, OUTPUT_SIZE);

        if (bytes_written < 0) {
            perror("write");
        } else {
            printf("[+] Saved %zd bytes to %s\n", bytes_written, OUT_FILE_PATH);
        }
        close(out_fd);
    } else {
        perror("open output file");
    }

    /* Cleanup */
    munmap(dma_buf, RESERVED_DDR_SIZE);
    close(dev_fd);

    return mismatches ? EXIT_FAILURE : EXIT_SUCCESS;
}
