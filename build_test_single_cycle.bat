ghdl -a shift_reg.vhdl
ghdl -a shift_reg_8b.vhdl
ghdl -a register_module.vhdl
ghdl -a display_module.vhdl
ghdl -a sign_extend_module.vhdl
ghdl -a adder_subtractor_8b.vhdl

ghdl -a single_cycle.vhdl

ghdl -a single_cycle_tb.vhdl
ghdl -e single_cycle_tb
ghdl -r single_cycle_tb --vcd=single_cycle.vcd