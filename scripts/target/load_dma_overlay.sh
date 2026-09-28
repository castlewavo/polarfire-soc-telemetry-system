#!/bin/sh

set -euo pipefail

OVERLAY_NAME="telemetry"
DTBO_FILE="telemetry_dma.dtbo"
CONFIGFS_DIR="/sys/kernel/config"
OVERLAY_DIR="${CONFIGFS_DIR}/device-tree/overlays/${OVERLAY_NAME}"

# Check if dtbo file exists
if [ ! -f "$DTBO_FILE" ]; then
    echo "[-] Error: $DTBO_FILE not found in current directory."
    exit 1
fi

# Ensure configfs is mounted
if ! mountpoint -q "$CONFIGFS_DIR"; then
    echo "[+] Mounting configfs at $CONFIGFS_DIR..."
    mount -t configfs none "$CONFIGFS_DIR"
fi

# Remove existing overlay if present and clean reload
if [ -d "$OVERLAY_DIR" ]; then
    echo "[+] Removing existing overlay '$OVERLAY_NAME'..."
    rmdir "$OVERLAY_DIR"
    sleep 0.2
fi

# create overlay directory and write dtbo
echo "[+] Applying $DTBO_FILE..."
mkdir -p "$OVERLAY_DIR"
cat "$DTBO_FILE" > "${OVERLAY_DIR}/dtbo"

# Verify device node registration
echo "[+] Verifying hardware node registration..."
if [ -d "/sys/bus/platform/devices/60010000.telemetry-dma" ]; then
    echo "[+] Success: Platform device 60010000.telemetry-dma registered!"
else
    echo "[-] Warning: Platform device node not found under /sys/bus/platform/devices/"
fi
