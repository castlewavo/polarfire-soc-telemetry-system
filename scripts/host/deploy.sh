#!/usr/bin/env bash

set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.."

SERIAL_DEV=/dev/ttyUSB0

FILES=(
    drivers/pf_regs/pf_regs.ko
    drivers/pf_dma/pf_dma.ko
    daemon/pf_regs_daemon/build/pf_soc_telemetry_daemon
    tests/pf_dma_test/pf_dma_test
    tests/pf_leds_demo.py
    client/pf_telemetry_client.py
    device-tree/overlays/telemetry_dma.dtbo
    scripts/target/load_dma_overlay.sh
)

# Check that everything exists before starting the transfer
for file in "${FILES[@]}"; do
    if [[ ! -f "$file" ]]; then
        echo "Missing file: $file — run build_all.sh first."
        exit 1
    fi
done

# Send all files through the serial port using ZMODEM
sz -byv "${FILES[@]}" > "$SERIAL_DEV" < "$SERIAL_DEV"

echo " *************** Transfer complete ****************"
