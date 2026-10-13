#Importing and Linking all the HDL source files used in the design
import_files -library work -hdl_source hdl/AXI4_STREAM_DATA_GENERATOR_MINIMAL.v
import_files -library work -hdl_source hdl/fft_axis_output.v
import_files -library work -hdl_source hdl/fft_control.v
import_files -library work -hdl_source hdl/fft_butterfly.v
import_files -library work -hdl_source hdl/fft_loader.v
import_files -library work -hdl_source hdl/fft_scheduler.v
import_files -library work -hdl_source hdl/fft_work_ram.v
import_files -library work -hdl_source hdl/twiddle_rom.v
import_files -library work -hdl_source hdl/fft_core.v
import_files -library work -hdl_source hdl/fft_magnitude.v
import_files -library work -hdl_source hdl/sample_buffer.v
import_files -library work -hdl_source hdl/spi_rx.v
import_files -library work -hdl_source hdl/apb_arbiter.v
import_files -library work -hdl_source hdl/APB_PASS_THROUGH.v
import_files -library work -hdl_source hdl/apb_regs.v
