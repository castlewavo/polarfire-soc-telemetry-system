# PolarFire SoC Telemetry System
Simple telemetry system for the Microchip PolarFire SoC Discovery Kit.

* **`libero/`**: Libero SoC design created modifying the Discovery Kit reference design
* **`drivers/`**: Linux kernel drivers for accessing APB registers and controlling DMA
* **`daemon/`**: C++ daemon running on the RISC-V target, reads telemetry data and streams it over UDP
* **`client/`**: Python scripts for live telemetry display
* **`scripts/`**: Automation scripts for compilation and deployment
* **`tests/`**: Tools to test specific functionalities
* **`device-tree/`**: Device tree overlays

### Requisites:
* RISC-V CC toolchain, [Linux kernel for Polarfire](https://github.com/microchip-fpga-solutions/linux4polarfire), Microchip Libero SoC (v2025.2), a Discovery Kit running Linux (I used a [pre-built image](https://github.com/polarfire-soc/meta-polarfire-soc-yocto-bsp/releases))

### Usage:

0. Prepare a Linux SD card for the Discovery Kit as in the [Polarfire guide](https://github.com/polarfire-soc/polarfire-soc-documentation/blob/master/reference-designs-fpga-and-development-kits/updating-linux-in-mpfs-kit.md).

1. Execute the `libero/MPFS_DISCO_KIT_REF_DESIGN_TELEMETRY.tcl` script in Libero SoC to recreate the HW project. Generate the bitstream and program the FPGA

2. Set the `KDIR` environment variable to point to your local PolarFire Linux kernel sources:
   ```bash
   export KDIR=/path/to/linux4polarfire
   ``` 
3. Build with:
    ```bash
   ./scripts/host/build_all.sh
   ``` 
4. Connect the host to the Discovery Kit with a USB cable for serial communication. You may need to install the FTDI drivers for this. Deploy the compiled files to the target board via ZMODEM (you might need to change the `SERIAL_DEV` variable in the script first): 
    ```bash
    ./scripts/host/deploy.sh
    ```
5. Configure the target: 
    ```bash
    ./load_dma_overlay.sh
    insmod pf_regs.ko && insmod pf_dma.ko
    ```
6. Run client/tests:
    ```bash
    ./pf_soc_telemetry_daemon /dev/pf_regs > /dev/null &
    python3 pf_telemetry_client.py
    python3 pf_leds_demo.py
    
    ./pf_dma_test
    
    ```   
