# Asynchronous SPI inputs.
# Each input must feed only its first synchronizer stage.
set_false_path -from [get_ports {NUCLEO_SPI_SCK}]
set_false_path -from [get_ports {NUCLEO_SPI_MOSI}]
set_false_path -from [get_ports {NUCLEO_SPI_CS_N}]