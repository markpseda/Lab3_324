library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity shift_reg_8b_tb is
end shift_reg_8b_tb;

architecture behav of shift_reg_8b_tb is
--  Declaration of the component that will be instantiated.
component shift_reg_8b
port (	I:	in std_logic_vector (7 downto 0);
		I_SHIFT_IN: in std_logic;
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; 
		enable:		in std_logic;
		O:	out std_logic_vector(7 downto 0)
);
end component;
--  Specifies which entity is bound with the component.
-- for shift_reg_0: shift_reg use entity work.shift_reg(rtl);
signal i, o : std_logic_vector(7 downto 0);
signal i_shift_in, clk, enable : std_logic;
signal sel : std_logic_vector(1 downto 0);
begin
--  Component instantiation.
shift_reg_8b_0: shift_reg_8b port map (I => i, I_SHIFT_IN => i_shift_in, sel => sel, clock => clk, enable => enable, O => o);

--  This process does the real job.
process
type pattern_type is record
--  The inputs of the shift_reg.
i: std_logic_vector (7 downto 0);
i_shift_in, clock, enable: std_logic;
sel: std_logic_vector(1 downto 0);
--  The expected outputs of the shift_reg.
o: std_logic_vector (7 downto 0);
end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=

-- Every other signal must have a zero for clock, so the next instruction's rising edge triggers the shift register, this is handled after the assert further down.
-- Every single operation type is tested here with all possible values for enable, shift input, and two values for I. 
-- *** Test for sel = "11", i.e. load a value. ***
-- enable false - these all are expected to do nothing
-- shift in 1
(("01010101", '1', '1', '0', "11", "00000000"), -- set to 0 upon initialization
("11111111", '1', '1', '0', "11", "00000000"),
-- shift in 0
("01010101", '0', '1', '0', "11", "00000000"),
("11101110", '0', '1', '0', "11", "00000000"),
-- enable true - these all are expected to work, but shift in will not affect the result
-- shift in 1
("11101110", '1', '1', '1', "11", "11101110"),
("01010101", '1', '1', '1', "11", "01010101"),
-- shift in 0
("10011001", '0', '1', '1', "11", "10011001"),
("11111111", '0', '1', '1', "11", "11111111"),
-- *** Test for sel = "10", i.e. shift left. ***
-- enable false -- these are all expected to do nothing
-- the next line is just to set up:
("01100110", '1', '1', '1', "11", "01100110"),
-- shift in 1
("00000000", '1', '1', '0', "10", "01100110"), -- TEST #10
("11111111", '1', '1', '0', "10", "01100110"),
-- shift in 0
("00000000", '0', '1', '0', "10", "01100110"),
("11111111", '0', '1', '0', "10", "01100110"),
-- enable true - these will work, and shift value will affect behavior of course
-- shift in 1
("00000000", '1', '1', '1', "10", "10110011"),
("11111111", '1', '1', '1', "10", "11011001"),
-- shift in 0
("00000000", '0', '1', '1', "10", "01101100"),
("11111111", '0', '1', '1', "10", "00110110"),

-- *** Test for sel = "01", i.e. shift left. ***
-- enable false - nothing will happen -- next line just to set up
("10011001", '1', '1', '1', "11", "10011001"),
-- shift in 1
("00000000", '1', '1', '0', "01", "10011001"),
("11111111", '1', '1', '0', "01", "10011001"), -- TEST #20
-- shift in 0
("00000000", '0', '1', '0', "01", "10011001"),
("11111111", '0', '1', '0', "01", "10011001"),
-- enable true - these will work, and shift value will affect behavior of course
-- shift in 1
("00000000", '1', '1', '1', "01", "00110011"),
("11111111", '1', '1', '1', "01", "01100111"),
-- shift in 0
("00000000", '0', '1', '1', "01", "11001110"),
("11111111", '0', '1', '1', "01", "10011100"),


-- *** Test for sel = "00", i.e. hold and do nothing. ***
-- enable false - these all are expected to do nothing, next line just for initialization
("10111011", '1', '1', '1', "11", "10111011"),
-- shift in 1
("01010101", '1', '1', '0', "00", "10111011"), -- set to 0 upon initialization
("10101010", '1', '1', '0', "00", "10111011"),
-- shift in 0
("01010101", '0', '1', '0', "00", "10111011"), -- TEST #30
("11101110", '0', '1', '0', "00", "10111011"),
-- enable true - no change
-- shift in 1
("11101110", '1', '1', '1', "00", "10111011"),
("01010101", '1', '1', '1', "00", "10111011"),
-- shift in 0
("10011001", '0', '1', '1', "00", "10111011"),
("11111111", '0', '1', '1', "00", "10111011"));

begin
--  Check each pattern.
for n in patterns'range loop
--  Set the inputs.
i <= patterns(n).i;
i_shift_in <= patterns(n).i_shift_in;
sel <= patterns(n).sel;
clk <= patterns(n).clock;
enable <= patterns(n).enable;
--  Wait for the results.
wait for 1 ns;
--  Check the outputs.
assert o = patterns(n).o
report "bad output value" severity error;

-- Set clock low and wait, so that next instruction can have a rising edge, nothing will be triggered for a falling edge ever. 
clk <= '0';
wait for 1 ns;

end loop;
assert false report "end of test" severity note;
--  Wait forever; this will finish the simulation.
wait;
end process;
end behav;
