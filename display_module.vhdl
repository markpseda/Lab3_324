library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DISPLAY is
	Port ( reg_data : in STD_LOGIC_VECTOR(7 downto 0);
		   enable   : in STD_LOGIC
	);	  
end entity DISPLAY;

architecture Behavioral of DISPLAY is 
begin  
	process(reg_data, enable) is
	begin
		if(enable = '0') then
			report "0000";
		else
			report integer'image(to_integer(signed(reg_data)));
		end if;
	end process;


end Behavioral;