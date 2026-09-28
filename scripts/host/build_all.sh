#!/usr/bin/env bash

set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.."

KDIR="${KDIR:-../linux4polarfire}"

# Clean generated files and exit
if [[ "${1:-}" == "clean" ]]; then
    for driver in pf_regs pf_dma; do
        make -C "$KDIR" M="$PWD/drivers/$driver" ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- clean
    done

    rm -rf daemon/pf_regs_daemon/build
    rm -f tests/pf_dma_test/pf_dma_test
    rm -f device-tree/overlays/telemetry_dma.dtbo

    echo "Clean complete"
    exit 0
fi

# Build kernel drivers
for driver in pf_regs pf_dma; do
    make -C "$KDIR" M="$PWD/drivers/$driver" ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- modules
done

# Build telemetry daemon
cmake -S daemon/pf_regs_daemon -B daemon/pf_regs_daemon/build -DCMAKE_SYSTEM_NAME=Linux -DCMAKE_SYSTEM_PROCESSOR=riscv64 -DCMAKE_CXX_COMPILER=riscv64-linux-gnu-g++
cmake --build daemon/pf_regs_daemon/build

# Build DMA demo
riscv64-linux-gnu-gcc -O2 -Wall tests/pf_dma_test/pf_dma_test.c -o tests/pf_dma_test/pf_dma_test

# Build  DT overlay
mkdir -p device-tree/overlays
dtc -@ -I dts -O dtb -o device-tree/overlays/telemetry_dma.dtbo device-tree/overlays/telemetry_dma.dts

echo "************** Build complete *****************"
