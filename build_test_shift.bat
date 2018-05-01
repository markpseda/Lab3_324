ghdl -a shift_reg.vhdl
ghdl -a shift_reg_tb.vhdl
ghdl -e shift_reg_tb
ghdl -r shift_reg_tb --vcd=shift_reg.vcd