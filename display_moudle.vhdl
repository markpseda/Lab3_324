library IEEE;

entity display_module is
	Port ( Reg : in STD_LOGIC_VECTOR(1 downto 0); -- 4 registers total
		   EN : in STD_LOGIC;
		   CLK : in STD_LOGIC;
		   Result : out STD_LOGIC_VECTOR (3 downto 0)
	);
end display_module;

architecture Behavioral of display_module is 

begin

end Behavioral;