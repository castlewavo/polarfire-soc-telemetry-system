# Exporting core apb_regs to TCL
# Exporting Create HDL core command for module apb_regs
create_hdl_core -file {hdl/apb_regs.v} -module {apb_regs} -library {work} -package {}
# Exporting BIF information of  HDL core command for module apb_regs
hdl_core_add_bif -hdl_core_name {apb_regs} -bif_definition {APB:AMBA:AMBA2:slave} -bif_name {APB_SLAVE} -signal_map {\
"PADDR:paddr" \
"PENABLE:penable" \
"PWRITE:pwrite" \
"PRDATA:prdata" \
"PWDATA:pwdata" \
"PREADY:pready" \
"PSLVERR:pslverr" \
"PSELx:psel" }
