ghdl -a shift_reg.vhdl

ghdl -a shift_reg_8b.vhdl

ghdl -a register_module.vhdl
ghdl -a register_module_tb.vhdl
ghdl -e register_module_tb
ghdl -r register_module_tb --vcd=register_module.vcd