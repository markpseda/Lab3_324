library ieee;
use ieee.std_logic_1164.all;

entity mux_2w_4b is
port (  
    I1, I2: in std_logic_vector (3 downto 0);
    sel:        in std_logic; 
    O:  out std_logic_vector(3 downto 0)
);
end mux_2w_4b;

architecture behav of mux_2w_4b is
begin
  O <= I1  when (sel = '1') else I2  when (sel = '0');
end behav;