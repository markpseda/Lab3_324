library ieee;
use ieee.std_logic_1164.all;

entity sign_extend_module is
	port(	
        in_4b: in std_logic_vector (3 downto 0);
		out_8b: out std_logic_vector (7 downto 0)
	);
end entity sign_extend_module;

architecture behav of sign_extend_module is
begin
	process (in_4b) is
	begin
        out_8b(0) <= in_4b(0);
        out_8b(1) <= in_4b(1);
        out_8b(2) <= in_4b(2);
        for i in 3 to 7 loop
            out_8b(i) <= in_4b(3);
        end loop;
	end process;
end behav;