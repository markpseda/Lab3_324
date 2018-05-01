library IEEE;

entity CONTROLLER is
	Port ( OpCode : in STD_LOGIC_VECTOR (7 downto 5);
		   CLK : in STD_LOGIC;
		   SKIP : out STD_LOGIC;
		   SPEC_OP: out STD_LOGIC;
		   ALU_SUB: out STD_LOGIC;
		   ADD_SUB: out STD_LOGIC;
		   PRINT_EN: out STD_LOGIC;
		   DEST_SEL: out STD_LOGIC);
end CONTROLLER;

architecture Behavioral of CONTROLLER is 

begin
	process(clock)
	begin
	-- Only do anything on a rising clock edge while enable is '1'
	if (enable='1' and clock'event and clock='1') then
		SKIP <= '1' when (OpCode = "100") else '0';
		SPEC_OP <= '1' when (OpCode = "010") else '0';
		ALU_SUB <= '1' when (OpCode = "101" or "100" or "001" or "000" or "010" or "011") else '0';
		ADD_SUB <= '1' when (OpCode = "100" or "110" or "111" or "101" or "010" or "011") else '0';
		PRINT_EN <= '1' when (OpCode = "010") else '0';
		DEST_SEL <= '1' when (OpCode = "100" or "110" or "111" or "101" or "010" or "011") else '0';
	end if;
	end process;
end Behavioral;
