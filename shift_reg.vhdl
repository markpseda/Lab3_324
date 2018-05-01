library ieee;
use ieee.std_logic_1164.all;

entity shift_reg is
port(	I:	in std_logic_vector (3 downto 0);
		R_SHIFT_IN: in std_logic;
		L_SHIFT_IN: in std_logic;
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; -- positive level triggering in problem 3
		enable:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
		O:	out std_logic_vector(3 downto 0) := "0000"
);
end shift_reg;

architecture behav of shift_reg is
-- Internal signal to which will be next state of shift register
signal next_value:	std_logic_vector(3 downto 0) := "0000";

begin
	-- process triggered by change in clock state
	process(clock)
	begin
		-- Only do anything on a rising clock edge while enable is '1'
		if (enable='1' and clock'event and clock='1') then
			-- "11" means set the output to be the input
			if(sel="11") then
				next_value <= I;
			-- "10" means shift right
			elsif(sel="10")then
				next_value(2 downto 0) <= next_value(3 downto 1);
				next_value(3) <= L_SHIFT_IN;
			--  "01" means shift left
			elsif(sel="01") then
				next_value(3 downto 1) <= next_value(2 downto 0);
				next_value(0) <= R_SHIFT_IN;
			-- "00" means hold and do nothing
			else
				next_value <= next_value;
			end if;
		end if;
	end process;
	-- update the output value accordingly
	O <= next_value;
end behav;

