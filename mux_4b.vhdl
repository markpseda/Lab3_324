library ieee;
use ieee.std_logic_1164.all;

entity mux_4b is
port (  I1, I2, I3, I4: in std_logic_vector (3 downto 0);
        sel:        in std_logic_vector(1 downto 0); 
        O:  out std_logic_vector(3 downto 0)
);
end mux_4b;

architecture behav of mux_4b is
begin
  O <= I1  when (sel = "00") else I2  when (sel = "01") else I3  when (sel = "10") else I4  when (sel = "11");
end behav;