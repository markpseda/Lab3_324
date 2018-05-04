library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display_module is
	Port ( 
		reg_data : in std_logic_vector(7 downto 0);
		reg_num: in std_logic_vector(1 downto 0);
		enable   : in std_logic;
		clk : in std_logic
	);	  
end entity display_module;

architecture behavioral of display_module is 
begin  
	process(clk) is
	begin
		if(clk'event and clk = '0' and enable = '1') then
			--report "Register Number: ";
			--report integer'image(to_integer(unsigned(reg_num)));
			--report "Register Value: ";
			report integer'image(to_integer(signed(reg_data)));
			--report "";
		end if;
	end process;
end behavioral;