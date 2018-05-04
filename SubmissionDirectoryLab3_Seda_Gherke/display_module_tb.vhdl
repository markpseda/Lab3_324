library ieee;
use ieee.std_logic_1164.all;

entity display_module_tb is
end display_module_tb;

architecture behavioral of display_module_tb is

	component display_module
		port (
			reg_data : in std_logic_vector(7 downto 0);
			reg_num : in std_logic_vector(1 downto 0);
			enable   : in std_logic;
			clk : in std_logic
			);
	end component;

	signal reg_data_input : std_logic_vector(7 downto 0);
	signal reg_num_input : std_logic_vector(1 downto 0);
	signal enable_input : std_logic;
	signal clk_input : std_logic;

begin
	
	display_test : display_module port map(
						reg_data => reg_data_input,
						reg_num => reg_num_input,
						enable => enable_input,
						clk => clk_input
						);

	process
		type display_record is record
		
			reg_data_in : std_logic_vector(7 downto 0);
			reg_num_in : std_logic_vector(1 downto 0);
			enable_in : std_logic;
			clk_in: std_logic;
		end record;

		type display_array is array (natural range <>) of display_record;
		constant tests : display_array :=
		(
			("10000001", "00", '1', '1'),--displays -127
			("10000001", "10", '0', '1'),--displays 0000
			("00000011", "10", '1', '1'),--displays 3
			("00000011", "11", '1', '1'),--no display
			("11111111", "01", '0', '1'),--displays 0000
			("10101010", "00", '1', '1')--displays -86
		);

		begin
	
	    for n in tests'range loop
		
			reg_data_input <= tests(n).reg_data_in;
			reg_num_input <= tests(n).reg_num_in;
			enable_input <= tests(n).enable_in;
			clk_input <= tests(n).clk_in;
			wait for 1 ns;
			clk_input <= '0';
			wait for 1 ns;
		end loop;
		assert false report "end of test" severity note;
		wait;
	end process;
end behavioral;