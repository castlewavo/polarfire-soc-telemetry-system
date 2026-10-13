#include <errno.h>
#include <fcntl.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <unistd.h>

#define DEV_PATH "/dev/pf_dma"
#define OUT_FILE_PATH "/tmp/telemetry_fft_power.bin"
#define RESERVED_DDR_SIZE 0x02000000UL
#define PAYLOAD_OFFSET 0x0100UL
#define FFT_BIN_COUNT 1024
#define TEST_TRANSFER_SIZE (FFT_BIN_COUNT * sizeof(uint64_t))
#define TELEMETRY_IOC_MAGIC 'T'
#define TELEMETRY_IOC_ENABLE_GEN _IOW(TELEMETRY_IOC_MAGIC, 1, uint32_t)

static int save_powers(const uint64_t *powers)
{
    int fd = open(OUT_FILE_PATH, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    size_t offset = 0;
    if (fd < 0) {
        perror("open output");
        return -1;
    }
    while (offset < TEST_TRANSFER_SIZE) {
        ssize_t n = write(fd, (const uint8_t *)powers + offset,
                          TEST_TRANSFER_SIZE - offset);
        if (n < 0 && errno == EINTR)
            continue;
        if (n <= 0) {
            if (n == 0)
                errno = EIO;
            perror("write output");
            close(fd);
            return -1;
        }
        offset += (size_t)n;
    }
    if (close(fd) < 0) {
        perror("close output");
        return -1;
    }
    return 0;
}

int main(int argc, char **argv)
{
    int check_constant = 0;
    long amplitude = 0;
    int result = EXIT_FAILURE;
    uint32_t start = 1;
    uint64_t powers[FFT_BIN_COUNT];
    size_t mismatches = 0;

    if (argc == 3 && strcmp(argv[1], "--constant") == 0) {
        char *end;
        errno = 0;
        amplitude = strtol(argv[2], &end, 10);
        if (errno || end == argv[2] || *end || amplitude < -32768 || amplitude > 32767) {
            fprintf(stderr, "Constant must be an integer from -32768 to 32767.\n");
            return EXIT_FAILURE;
        }
        check_constant = 1;
    } else if (argc != 1) {
        fprintf(stderr, "Usage: %s [--constant signed_16_bit_value]\n", argv[0]);
        return EXIT_FAILURE;
    }

    int fd = open(DEV_PATH, O_RDWR | O_SYNC);
    if (fd < 0) {
        perror("open " DEV_PATH);
        return EXIT_FAILURE;
    }
    void *mapping = mmap(NULL, RESERVED_DDR_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (mapping == MAP_FAILED) {
        perror("mmap");
        close(fd);
        return EXIT_FAILURE;
    }
    volatile uint64_t *payload = (volatile uint64_t *)((uint8_t *)mapping + PAYLOAD_OFFSET);

    /* Run only when no previous acquisition is active. */
    for (size_t k = 0; k < FFT_BIN_COUNT; ++k)
        payload[k] = UINT64_C(0xA5A5A5A5A5A5A5A5);

    puts("Requesting 1024 FFT power bins (8192 bytes).");
    puts("The NUCLEO STM32 must supply one complete block of 1024 samples.");
    fflush(stdout);
    if (ioctl(fd, TELEMETRY_IOC_ENABLE_GEN, &start) < 0) {
        perror("DMA ioctl");
        fprintf(stderr, "No valid capture saved. After a timeout, reset the acquisition hardware before retrying.\n");
        goto cleanup;
    }

    for (size_t k = 0; k < FFT_BIN_COUNT; ++k)
        powers[k] = payload[k];

    puts("First 16 bins: |FFT[k]|^2");
    for (size_t k = 0; k < 16; ++k)
        printf("[%4zu] %" PRIu64 "\n", k, powers[k]);

    if (check_constant) {
        /* Unnormalized FFT: X[0] = 1024*A, all other bins are zero. */
        int64_t dc = (int64_t)FFT_BIN_COUNT * amplitude;
        uint64_t dc_power = (uint64_t)(dc * dc);
        for (size_t k = 0; k < FFT_BIN_COUNT; ++k) {
            uint64_t expected = k == 0 ? dc_power : 0;
            if (powers[k] != expected) {
                if (mismatches < 8)
                    fprintf(stderr, "Bin %zu: expected %" PRIu64 ", got %" PRIu64 "\n", k, expected, powers[k]);
                ++mismatches;
            }
        }
        if (mismatches)
            fprintf(stderr, "FAIL: %zu incorrect bins\n", mismatches);
        else
            puts("PASS: all 1024 bins match the constant-input FFT.");
    } else {
        puts("DMA completed; numerical FFT correctness was not checked.");
    }

    /* Save the payload: 1024 uint64_t powers */
    if (save_powers(powers) < 0)
        goto cleanup;
    printf("Saved %zu bytes to %s\n", TEST_TRANSFER_SIZE, OUT_FILE_PATH);
    result = mismatches ? EXIT_FAILURE : EXIT_SUCCESS;

cleanup:
    munmap(mapping, RESERVED_DDR_SIZE);
    close(fd);
    return result;
}
