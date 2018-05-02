library ieee;
use ieee.std_logic_1164.all;

entity single_cycle_tb is
end single_cycle_tb;

architecture behavioral of single_cycle_tb is

    component single_cycle 
    port
    (
        I: in std_logic_vector(7 downto 0);
        clk: in std_logic;
        O: out std_logic_vector(7 downto 0)
    );
    end component;

    signal current_instruction, current_output: std_logic_vector(7 downto 0);
    signal clock: std_logic;

    begin

        single_cycle_cpu: single_cycle port map(
            I => current_instruction,
            clk => clock,
            O => current_output
        );


        --  This process does the real job.
        process
        type pattern_type is record
        --  The inputs of the register module.
        test_in : std_logic_vector(7 downto 0);
        test_clock : std_logic;
        test_out : std_logic_vector(7 downto 0);
        end record;

        --  The patterns to apply.
        type pattern_array is array (natural range <>) of pattern_type;
        -- low clock values are handled by the test suite since updates only occur on rising edges
        constant patterns : pattern_array :=
        (("00000011", '1', "00000011"),
        ("00000111", '1', "00000111"),
        ("01000000", '1', "00000111"));

        begin

            for n in patterns'range loop

                current_instruction <= patterns(n).test_in;
                clock <= patterns(n).test_clock;
                wait for 1 ns;
                assert current_output = patterns(n).test_out
                report "bad output value" severity error;

                clock <= '0';
                wait for 1 ns;

            end loop;
        assert false report "end of test" severity note;

        wait;

    end process;
end behavioral;