puts "TCL_BEGIN: [info script]"

#
# MPFS Discovery Kit telemetry base design only
#
# This script intentionally supports only the base MPFS_DISCOVERY design plus the telemetry modifications.
# No alternate configurations or command-line build modes are supported.
#

# Check path length to verify the project can be created.
if {[lindex $tcl_platform(os) 0] == "Windows"} {
    if {[string length [pwd]] < 90} {
        puts "Project path length ok."
    } else {
        error "Path to project is too long, please reduce the path and try again."
    }
}

# Required paths.
set install_loc [defvar_get -name ACTEL_SW_DIR]
set mss_config_loc "$install_loc/bin64/pfsoc_mss"
set local_dir [pwd]
set constraint_path ./script_support/constraints

# Base project only.
set project_name "MPFS_DISCOVERY"
set project_dir "$local_dir/MPFS_DISCOVERY"

# Open an existing project or create it if it does not exist.
if {[file exists "$project_dir/$project_name.prjx"]} {
    puts "Opening existing project"
    open_project -file "$project_dir/$project_name.prjx"
    open_smartdesign -sd_name {MPFS_DISCOVERY_KIT}
} else {
    puts "Creating new project"

    new_project \
        -location $project_dir \
        -name $project_name \
        -project_description {} \
        -block_mode 0 \
        -standalone_peripheral_initialization 0 \
        -instantiate_in_smartdesign 1 \
        -ondemand_build_dh 1 \
        -use_relative_path 0 \
        -linked_files_root_dir_env {} \
        -hdl {VERILOG} \
        -family {PolarFireSoC} \
        -die {MPFS095T} \
        -package {FCSG325} \
        -speed {-1} \
        -die_voltage {1.0} \
        -part_range {EXT} \
        -adv_options {IO_DEFT_STD:LVCMOS 1.8V} \
        -adv_options {RESTRICTPROBEPINS:1} \
        -adv_options {RESTRICTSPIPINS:0} \
        -adv_options {SYSTEM_CONTROLLER_SUSPEND_MODE:0} \
        -adv_options {TEMPR:EXT} \
        -adv_options {VCCI_1.2_VOLTR:EXT} \
        -adv_options {VCCI_1.5_VOLTR:EXT} \
        -adv_options {VCCI_1.8_VOLTR:EXT} \
        -adv_options {VCCI_2.5_VOLTR:EXT} \
        -adv_options {VCCI_3.3_VOLTR:EXT} \
        -adv_options {VOLTR:EXT}

    smartdesign \
        -memory_map_drc_change_error_to_warning 1 \
        -bus_interface_data_width_drc_change_error_to_warning 1 \
        -bus_interface_id_width_drc_change_error_to_warning 1

    # Download the cores used by the reference design.
    try {
        download_core -vlnv {Actel:SgCore:PF_OSC:*} -location {www.microchip-ip.com/repositories/SgCore}
        download_core -vlnv {Actel:SgCore:PF_CCC:*} -location {www.microchip-ip.com/repositories/SgCore}
        download_core -vlnv {Actel:DirectCore:CORERESET_PF:*} -location {www.microchip-ip.com/repositories/DirectCore}
        download_core -vlnv {Microsemi:SgCore:PFSOC_INIT_MONITOR:*} -location {www.microchip-ip.com/repositories/SgCore}
        download_core -vlnv {Actel:DirectCore:COREAXI4INTERCONNECT:2.9.100} -location {www.microchip-ip.com/repositories/DirectCore}
        download_core -vlnv {Actel:SgCore:PF_CLK_DIV:*} -location {www.microchip-ip.com/repositories/SgCore}
        download_core -vlnv {Actel:SgCore:PF_DRI:*} -location {www.microchip-ip.com/repositories/SgCore}
        download_core -vlnv {Actel:SgCore:PF_NGMUX:*} -location {www.microchip-ip.com/repositories/SgCore}
        download_core -vlnv {Actel:SgCore:PF_PCIE:*} -location {www.microchip-ip.com/repositories/SgCore}
        download_core -vlnv {Actel:SgCore:PF_TX_PLL:*} -location {www.microchip-ip.com/repositories/SgCore}
        download_core -vlnv {Actel:SgCore:PF_XCVR_REF_CLK:*} -location {www.microchip-ip.com/repositories/SgCore}
        download_core -vlnv {Actel:DirectCore:CoreAPB3:4.2.100} -location {www.microchip-ip.com/repositories/DirectCore}
        download_core -vlnv {Actel:DirectCore:COREAXI4DMACONTROLLER:2.2.107} -location {www.microchip-ip.com/repositories/DirectCore}
        download_core -vlnv {Actel:DirectCore:CoreGPIO:3.2.102} -location {www.microchip-ip.com/repositories/DirectCore}
        download_core -vlnv {Actel:SystemBuilder:PF_SRAM_AHBL_AXI:*} -location {www.microchip-ip.com/repositories/SgCore}
        download_core -vlnv {Actel:Simulation:CLK_GEN:*} -location {www.microchip-ip.com/repositories/SgCore}
        download_core -vlnv {Actel:Simulation:RESET_GEN:*} -location {www.microchip-ip.com/repositories/SgCore}
        download_core -vlnv {Actel:DirectCore:corepwm:4.5.100} -location {www.microchip-ip.com/repositories/DirectCore} 
        download_core -vlnv {Actel:DirectCore:COREI2C:7.2.101} -location {www.microchip-ip.com/repositories/DirectCore} 
        download_core -vlnv {Actel:DirectCore:CoreUARTapb:5.7.100} -location {www.microchip-ip.com/repositories/DirectCore} 
        download_core -vlnv {Actel:DirectCore:CoreTimer:2.0.103} -location {www.microchip-ip.com/repositories/DirectCore}
        download_core -vlnv {Actel:DirectCore:COREJTAGDEBUG:4.0.100} -location {www.microchip-ip.com/repositories/DirectCore}
        download_core -vlnv {Actel:DirectCore:COREAXITOAHBL:3.6.101} -location {www.microchip-ip.com/repositories/DirectCore}
        download_core -vlnv {Actel:DirectCore:COREAHBTOAPB3:3.2.101} -location {www.microchip-ip.com/repositories/DirectCore}
        download_core -vlnv {Actel:DirectCore:CoreAHBLite:6.1.101} -location {www.microchip-ip.com/repositories/DirectCore}
        download_core -vlnv {Microsemi:MiV:MIV_RV32:3.1.200} -location {www.microchip-ip.com/repositories/DirectCore} 
        download_core -vlnv {Actel:SystemBuilder:MIV_ESS:2.0.200} -location {www.microchip-ip.com/repositories/SgCore}  
        download_core -vlnv {Actel:SystemBuilder:PF_DDR3:2.4.124} -location {www.microchip-ip.com/repositories/SgCore}
        download_core -vlnv {Actel:DirectCore:CORESPI:5.2.104} -location {www.microchip-ip.com/repositories/SgCore} 
        download_core -vlnv {Actel:DirectCore:COREUART:5.7.100} -location {www.microchip-ip.com/repositories/DirectCore}
        download_core -vlnv {Actel:DirectCore:COREFFT:8.1.100} -location {www.microchip-ip.com/repositories/DirectCore}
        download_core -vlnv {Actel:DirectCore:COREFIR_PF:3.0.121} -location {www.microchip-ip.com/repositories/DirectCore}
        download_core -vlnv {Microchip:MiV:MIV_IHC:2.0.100} -location {www.microchip-ip.com/repositories/DirectCore}
    } on error err {
        puts "Downloading cores failed, the script will continue but will fail if all of the required cores aren't present in the vault."
    }
    

    # Generate and import the MSS component.
    if {[file isdirectory "$local_dir/script_support/components/MSS"]} {
        file delete -force "$local_dir/script_support/components/MSS"
    }
    file mkdir "$local_dir/script_support/components/MSS"

    exec $mss_config_loc \
        -GENERATE \
        -CONFIGURATION_FILE:$local_dir/script_support/MPFS_DISCOVERY_KIT_MSS.cfg \
        -OUTPUT_DIR:$local_dir/script_support/components/MSS

    import_mss_component \
        -file "$local_dir/script_support/components/MSS/MPFS_DISCOVERY_KIT_MSS.cxz"

    # Generate the base SmartDesign hierarchy.
    cd ./script_support/
    source MPFS_DISCOVERY_KIT_recursive.tcl
    cd ../
    set_root -module {MPFS_DISCOVERY_KIT::work}

    # Import I/O and floorplanning constraints.
    import_files \
        -convert_EDN_to_HDL 0 \
        -io_pdc "${constraint_path}/MPFS_DISCOVERY_KIT_BANK_SETTINGS.pdc" \
        -io_pdc "${constraint_path}/MPFS_DISCOVERY_KIT_BOARD_MISC.pdc" \
        -io_pdc "${constraint_path}/MPFS_DISCOVERY_MAC.pdc" \
        -io_pdc "${constraint_path}/MPFS_DISCOVERY_mikroBUS.pdc" \
        -io_pdc "${constraint_path}/MPFS_DISCOVERY_RPi.pdc" \
        -io_pdc "${constraint_path}/MPFS_DISCOVERY_UARTS.pdc" \
        -io_pdc "${constraint_path}/MPFS_DISCOVERY_7_SEG.pdc" \
        -fp_pdc "${constraint_path}/SW_PLL.pdc"

    organize_tool_files \
        -tool {PLACEROUTE} \
        -file "${project_dir}/constraint/io/MPFS_DISCOVERY_KIT_BANK_SETTINGS.pdc" \
        -file "${project_dir}/constraint/io/MPFS_DISCOVERY_KIT_BOARD_MISC.pdc" \
        -file "${project_dir}/constraint/io/MPFS_DISCOVERY_MAC.pdc" \
        -file "${project_dir}/constraint/io/MPFS_DISCOVERY_mikroBUS.pdc" \
        -file "${project_dir}/constraint/io/MPFS_DISCOVERY_RPi.pdc" \
        -file "${project_dir}/constraint/io/MPFS_DISCOVERY_UARTS.pdc" \
        -file "${project_dir}/constraint/io/MPFS_DISCOVERY_7_SEG.pdc" \
        -file "${project_dir}/constraint/fp/SW_PLL.pdc" \
        -module {MPFS_DISCOVERY_KIT::work} \
        -input_type {constraint}

    # Build hierarchy and derive timing constraints.
    build_design_hierarchy
    derive_constraints_sdc

    # Auto-layout the SmartDesign blocks.
    save_project
    sd_reset_layout -sd_name {CLOCKS_AND_RESETS}
    save_smartdesign -sd_name {CLOCKS_AND_RESETS}
    sd_reset_layout -sd_name {FIC_0_PERIPHERALS}
    save_smartdesign -sd_name {FIC_0_PERIPHERALS}
    sd_reset_layout -sd_name {CORE_I2C_C0_0_WRAPPER}
    save_smartdesign -sd_name {CORE_I2C_C0_0_WRAPPER}
    sd_reset_layout -sd_name {FIC_3_ADDRESS_GENERATION}
    save_smartdesign -sd_name {FIC_3_ADDRESS_GENERATION}
    sd_reset_layout -sd_name {FIC_3_PERIPHERALS}
    save_smartdesign -sd_name {FIC_3_PERIPHERALS}
    sd_reset_layout -sd_name {MSS_WRAPPER}
    save_smartdesign -sd_name {MSS_WRAPPER}
    sd_reset_layout -sd_name {MPFS_DISCOVERY_KIT}
    save_smartdesign -sd_name {MPFS_DISCOVERY_KIT}
}


save_project
puts "TCL_END: [info script]"
