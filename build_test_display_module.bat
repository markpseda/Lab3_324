ghdl -a display_module.vhdl
ghdl -a display_module_tb.vhdl
ghdl -e display_module_tb
ghdl -r display_module_tb --vcd=shift_reg.vcd