library ieee;
use ieee.std_logic_1164.all;

entity controller_module is
	Port ( OpCode : in STD_LOGIC_VECTOR (7 downto 5);
		   CLK : in STD_LOGIC;
		   SKIP : out STD_LOGIC;
		   SPEC_OP: out STD_LOGIC;
		   ALU_SUB: out STD_LOGIC;
		   ADD_SUB: out STD_LOGIC;
		   PRINT_EN: out STD_LOGIC;
		   DEST_SEL: out STD_LOGIC);
end controller_module;

architecture behavioral of controller_module is 

begin

	SKIP <= '1' when (OpCode = "100") else '0';
	SPEC_OP <= '1' when (OpCode = "010") else '0';
	ALU_SUB <= '1' when (OpCode = "101" or OpCode = "100" or OpCode = "001" or OpCode = "000" or OpCode = "010" or OpCode = "011") else '0';
	ADD_SUB <= '1' when (OpCode = "100" or OpCode = "110" or OpCode = "111" or OpCode = "101" or OpCode = "010" or OpCode = "011") else '0';
	PRINT_EN <= '1' when (OpCode = "010") else '0';
	DEST_SEL <= '1' when (OpCode = "100" or OpCode = "110" or OpCode = "111" or OpCode = "101" or OpCode = "010" or OpCode = "011") else '0';

end behavioral;
