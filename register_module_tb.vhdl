library ieee;
use ieee.std_logic_1164.all;

entity register_module_tb is
end register_module_tb;

architecture behav of register_module_tb is

    component register_module
    port(
        rs:     in std_logic_vector(1 downto 0);
        rt:     in std_logic_vector(1 downto 0);
        des:    in std_logic_vector(1 downto 0);
        write_data: in std_logic_vector(7 downto 0);
        clk:    in std_logic;
        enableWrite: in std_logic;
        rsval:   out std_logic_vector(7 downto 0) := "00000000";
        rtval:   out std_logic_vector(7 downto 0) := "00000000"
    );
    end component;

    signal clkInput, enableWriteInput: std_logic;
    signal rsInput, rtInput, desInput: std_logic_vector(1 downto 0);
    signal write_dataInput, rsvalResult, rtvalResult: std_logic_vector(7 downto 0);

    
    begin
        registers_implementation: register_module port map(
            rs => rsInput,
            rt => rtInput,
            des => desInput,
            write_data => write_dataInput,
            clk => clkInput,
            enableWrite => enableWriteInput,
            rsval => rsvalResult,
            rtval => rtvalResult
        );

        --  This process does the real job.
        process
        type pattern_type is record
        --  The inputs of the register module.
        rsin, rtin, desin: std_logic_vector(1 downto 0);
        write_datain: std_logic_vector(7 downto 0);

        clkin,enableWritein: std_logic;
        rsvalExpected,rtvalExpected: std_logic_vector(7 downto 0);

        end record;
        --  The patterns to apply.
        type pattern_array is array (natural range <>) of pattern_type;
        -- low clock values are handled by the test suite since updates only occur on rising edges
        constant patterns : pattern_array :=
        (("00", "01", "00", "01010101", '1', '0', "00000000", "00000000"), -- fail to write because enable write is false
        ("00", "01", "00", "01010101", '1', '1', "01010101", "00000000"), -- write correctly
        ("00", "01", "01", "10101010", '1', '1', "01010101", "10101010"), -- write to other register
        ("10", "11", "00", "11111111", '1', '1', "00000000", "00000000"), -- display the other empty registers but write to original register 0
        ("00", "11", "11", "00001111", '1', '1', "11111111", "00001111")); -- display the first, now modified, and a newly modified register

        begin

            for n in patterns'range loop


            --  Set the inputs.
            rsInput <= patterns(n).rsin;
            rtInput <= patterns(n).rtin;
            desInput <= patterns(n).desin;
            write_dataInput <= patterns(n).write_datain;
            clkInput <= patterns(n).clkin;
            enableWriteInput <= patterns(n).enableWriteIn;
            --  Wait for the results.
            wait for 1 ns;
            --  Check the outputs.
            assert rsvalResult = patterns(n).rsvalExpected
            report "bad output value" severity error;
            assert rtvalResult = patterns(n).rtvalExpected
            report "bad output value" severity error;

            -- Set clock low and wait, so that next instruction can have a rising edge, nothing will be triggered for a falling edge ever. 
            clkInput <= '0';
            wait for 1 ns;

            end loop;
            assert false report "end of test" severity note;
            --  Wait forever; this will finish the simulation.
            wait;
        end process;
    end behav;

