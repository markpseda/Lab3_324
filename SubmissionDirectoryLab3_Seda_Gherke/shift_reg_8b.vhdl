library ieee;
use ieee.std_logic_1164.all;

entity shift_reg_8b is
port(	I:	in std_logic_vector (7 downto 0);
		I_SHIFT_IN: in std_logic;
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; -- positive level triggering in problem 3
		enable:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
		O:	out std_logic_vector(7 downto 0) := "00000000"
);
end shift_reg_8b;

architecture structure of shift_reg_8b is
component shift_reg is
	port(
		i:	in std_logic_vector (3 downto 0);
		l_shift_in: in std_logic;
		r_shift_in: in std_logic;
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; -- positive level triggering in problem 3
		enable:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
		O:	out std_logic_vector(3 downto 0) := "0000"
	);
end component;

-- In order to be able to read output to feed into shift register "shift in" values
signal output_value: std_logic_vector(7 downto 0);

begin

-- Set the appropriate shift in value for each register based on shift type

shift_reg_1: shift_reg port map (
	i => I(7 downto 4),
	l_shift_in => I_SHIFT_IN,
	r_shift_in => output_value(3),
	sel => sel,
	clock => clock,
	enable => enable,
	O => output_value(7 downto 4)
);

shift_reg_2: shift_reg port map (
	i => I(3 downto 0),
	l_shift_in => output_value(4),
	r_shift_in => I_SHIFT_IN,
	sel => sel,
	clock => clock,
	enable => enable,
	O => output_value(3 downto 0)
);

O <= output_value;


end structure;

