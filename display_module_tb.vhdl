library ieee;
use ieee.std_logic_1164.all;

entity display_module_tb is
end display_module_tb;

architecture behavioral of display_module_tb is

	component display_module
		port (
			reg_data : in std_logic_vector(7 downto 0);
			enable   : in std_logic
			);
	end component;

	signal REG_DATA : std_logic_vector(7 downto 0);
	signal ENABLE : std_logic;

begin
	
	display_test : display_module port map(
						reg_data => REG_DATADATA,
						enable => ENABLE
						);

	process
		type display_record is record
		
			REG_DATA : std_logic_vector(7 downto 0);
			ENABLE : std_logic;
		end record;

		type display_array is array (natural range <>) of display_record;
		constant tests : dsiplay_array :=
		(
			("10000001", '1'),--displays -127
			("10000001", '0'),--displays 0000
			("00000011", '1'),--displays 3
			("00000011", '1'),--no display
			("11111111", '0'),--displays 0000
			("10101010", '1')--displays -86
		);

		begin
	
	    for n in tests'range loop
		
			REG_DATA <= tests(n).REG_DATA;
			ENABLE <= tests(n).ENABLE;

			wait for 1 ns;
		end loop;
		assert false report "end of test" severity note;
		wait;
	end process;
end behavioral;