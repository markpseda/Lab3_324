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
        -- Begin by testing loading registers and basic addition
        (("00000011", '1', "00000011"), -- load 3 into register 0
        ("00010111", '1', "00000111"), -- load 7 into register 1
        ("01000000", '1', "00000111"), -- print register 0
        ("11100001", '1', "00001010"), -- add registers 0 and 1 and put in 2
        ("11000001", '1', "00001010"), -- add registers 0 and 1 and put in 0
        ("01000000", '1', "00000111"), -- print register 0 (10)
        ("01001000", '1', "00000111"), -- print register 1 (7)
        ("01010000", '1', "00000111"), -- print register 2 (10)
        ("01011000", '1', "00000111"), -- print register 3 (0)
        -- Next test subtraction of positive numbers
        ()

        -- Next try loading negative values 


        -- Adding negative numbers


        --Adding positive numbers

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