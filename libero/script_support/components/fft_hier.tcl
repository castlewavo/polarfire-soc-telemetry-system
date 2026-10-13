# Creating SmartDesign "fft_hier"
set sd_name {fft_hier}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {fft_axis_output_0_pin_m_axis_tready} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fft_control_0_pin_block_ready} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fft_control_0_pin_clk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fft_control_0_pin_rst_n} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fft_control_0_pin_start_async} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fft_core_0_pin_sample_rd_valid} -port_direction {IN}

sd_create_scalar_port -sd_name ${sd_name} -port_name {fft_axis_output_0_pin_m_axis_tlast} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fft_axis_output_0_pin_m_axis_tvalid} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fft_control_0_pin_busy} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fft_control_0_pin_done} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fft_core_0_pin_done} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fft_core_0_pin_release_block} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {fft_core_0_pin_sample_rd_en} -port_direction {OUT}


# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {fft_core_0_pin_sample_rd_data} -port_direction {IN} -port_range {[15:0]}

sd_create_bus_port -sd_name ${sd_name} -port_name {fft_axis_output_0_pin_m_axis_tdata} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {fft_axis_output_0_pin_m_axis_tkeep} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {fft_axis_output_0_pin_m_axis_tstrb} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {fft_core_0_pin_sample_rd_addr} -port_direction {OUT} -port_range {[9:0]}


# Add fft_axis_output_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {fft_axis_output} -hdl_file {hdl\fft_axis_output.v} -instance_name {fft_axis_output_0}



# Add fft_control_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {fft_control} -hdl_file {hdl\fft_control.v} -instance_name {fft_control_0}



# Add fft_core_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {fft_core} -hdl_file {hdl\fft_core.v} -instance_name {fft_core_0}



# Add fft_magnitude_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {fft_magnitude} -hdl_file {hdl\fft_magnitude.v} -instance_name {fft_magnitude_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_axis_output_0:busy" "fft_control_0:axis_busy" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_axis_output_0:clk" "fft_control_0:clk" "fft_control_0_pin_clk" "fft_core_0:clk" "fft_magnitude_0:clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_axis_output_0:done" "fft_control_0:axis_done" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_axis_output_0:m_axis_tlast" "fft_axis_output_0_pin_m_axis_tlast" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_axis_output_0:m_axis_tready" "fft_axis_output_0_pin_m_axis_tready" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_axis_output_0:m_axis_tvalid" "fft_axis_output_0_pin_m_axis_tvalid" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_axis_output_0:power_valid" "fft_magnitude_0:out_valid" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_axis_output_0:result_rd_en" "fft_core_0:result_rd_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_axis_output_0:results_ready" "fft_control_0:fft_results_ready" "fft_core_0:results_ready" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_axis_output_0:rst_n" "fft_control_0:rst_n" "fft_control_0_pin_rst_n" "fft_core_0:rst_n" "fft_magnitude_0:rst_n" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_axis_output_0:start" "fft_control_0:axis_start" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_control_0:block_ready" "fft_control_0_pin_block_ready" "fft_core_0:block_ready" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_control_0:busy" "fft_control_0_pin_busy" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_control_0:done" "fft_control_0_pin_done" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_control_0:fft_busy" "fft_core_0:busy" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_control_0:fft_start" "fft_core_0:start" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_control_0:start_async" "fft_control_0_pin_start_async" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_core_0:done" "fft_core_0_pin_done" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_core_0:release_block" "fft_core_0_pin_release_block" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_core_0:result_valid" "fft_magnitude_0:in_valid" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_core_0:sample_rd_en" "fft_core_0_pin_sample_rd_en" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_core_0:sample_rd_valid" "fft_core_0_pin_sample_rd_valid" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_axis_output_0:m_axis_tdata" "fft_axis_output_0_pin_m_axis_tdata" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_axis_output_0:m_axis_tkeep" "fft_axis_output_0_pin_m_axis_tkeep" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_axis_output_0:m_axis_tstrb" "fft_axis_output_0_pin_m_axis_tstrb" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_axis_output_0:power_data" "fft_magnitude_0:out_power" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_axis_output_0:result_rd_addr" "fft_core_0:result_rd_addr" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_core_0:result_imag" "fft_magnitude_0:in_imag" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_core_0:result_real" "fft_magnitude_0:in_real" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_core_0:sample_rd_addr" "fft_core_0_pin_sample_rd_addr" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"fft_core_0:sample_rd_data" "fft_core_0_pin_sample_rd_data" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the SmartDesign 
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign "fft_hier"
generate_component -component_name ${sd_name}
