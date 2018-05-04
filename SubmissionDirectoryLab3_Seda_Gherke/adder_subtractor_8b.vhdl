library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port(
        A, B, Cin: in std_logic;
        S, Cout: out std_logic
    );
end full_adder;

architecture behav of full_adder is
begin
    S <= A xor B xor Cin;
    Cout <= ((A xor B) and Cin) or (A and B);
end behav;

library ieee;
use ieee.std_logic_1164.all;

entity adder_subtractor_8b is
port(
    Mode : in std_logic;
    A, B : in std_logic_vector(7 downto 0);
    C: out std_logic_vector(7 downto 0)
    );
end adder_subtractor_8b;

architecture structure of adder_subtractor_8b is
component full_adder is
    port(
        a, b, cin: in std_logic;
        S, cout: out std_logic
    );
end component;

signal b0,b1,b2,b3,b4,b5,b6,b7: std_logic;

signal c1,c2,c3,c4,c5,c6,c7,c8: std_logic;


begin

-- XOR B with Mode for subtraction
b0 <= B(0) xor Mode;
b1 <= B(1) xor Mode;
b2 <= B(2) xor Mode;
b3 <= B(3) xor Mode;
b4 <= B(4) xor Mode;
b5 <= B(5) xor Mode;
b6 <= B(6) xor Mode;
b7 <= B(7) xor Mode;

fa1: full_adder port map (
    a => A(0),
    b => b0,
    cin => Mode,
    S => C(0),
    cout => c1
);

fa2: full_adder port map (
    a => A(1),
    b => b1,
    cin => c1,
    S => C(1),
    cout => c2
);

fa3: full_adder port map (
    a => A(2),
    b => b2,
    cin => c2,
    S => C(2),
    cout => c3
);

fa4: full_adder port map (
    a => A(3),
    b => b3,
    cin => c3,
    S => C(3),
    cout => c4
);

fa5: full_adder port map (
    a => A(4),
    b => b4,
    cin => c4,
    S => C(4),
    cout => c5
);

fa6: full_adder port map (
    a => A(5),
    b => b5,
    cin => c5,
    S => C(5),
    cout => c6
);

fa7: full_adder port map (
    a => A(6),
    b => b6,
    cin => c6,
    S => C(6),
    cout => c7
);

fa8: full_adder port map (
    a => A(7),
    b => b7,
    cin => c7,
    S => C(7),
    cout => c8
);


end structure;