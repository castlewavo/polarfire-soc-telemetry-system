#!/usr/bin/env python3
import os
import struct
import time
import sys

DEV_NODE = "/dev/pf_regs"

# Register offsets
REG_CONTROL8 = 0x18
REG_ID       = 0x1C

def main():
    if not os.path.exists(DEV_NODE):
        print(f"[ERROR] Device node {DEV_NODE} not found. Load driver with 'insmod pf_regs.ko'.")
        sys.exit(1)

    fd = os.open(DEV_NODE, os.O_RDWR)

    try:
        # Read Hardware ID
        raw_id = os.pread(fd, 4, REG_ID)
        hw_id = struct.unpack("<I", raw_id)[0]
        print(f"[SUCCESS] Connected to {DEV_NODE} (HW_ID: 0x{hw_id:08X})")

        print("\nSelect LED Mode:")
        print("1: Continuous blinking loop (Ctrl+C to stop)")
        print("2: Set LEDs ON permanently")
        print("3: Set LEDs OFF")
        print("4: Running chaser pattern")

        choice = input("\nEnter choice [1-4]: ").strip()

        if choice == "1":
            print("[INFO] Blinking LEDs... Press Ctrl+C to stop.")
            while True:
                # Turn all on (0xFF)
                os.pwrite(fd, struct.pack("<I", 0xFF), REG_CONTROL8)
                time.sleep(0.5)
                # Turn all off (0x00)
                os.pwrite(fd, struct.pack("<I", 0x00), REG_CONTROL8)
                time.sleep(0.5)

        elif choice == "2":
            os.pwrite(fd, struct.pack("<I", 0xFF), REG_CONTROL8)
            print("[INFO] LEDs set to 0xFF (ON).")

        elif choice == "3":
            os.pwrite(fd, struct.pack("<I", 0x00), REG_CONTROL8)
            print("[INFO] LEDs set to 0x00 (OFF).")

        elif choice == "4":
            print("[INFO] Running chaser pattern...Press Ctrl+C to stop.")
            pattern = [0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80]
            while True:
                for val in pattern:
                    os.pwrite(fd, struct.pack("<I", val), REG_CONTROL8)
                    time.sleep(0.1)

        else:
            print("[ERROR] Invalid choice. Exiting.")

    except KeyboardInterrupt:
        print("\n[INFO] Stopped by user.")
        # Turn off leds when exiting via Ctrl+C
        os.pwrite(fd, struct.pack("<I", 0x00), REG_CONTROL8)

    finally:
        os.close(fd)
        print("[INFO] Device handle closed.")

if __name__ == "__main__":
    main()
