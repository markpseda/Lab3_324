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

        process is
            file infile: TEXT open read_mode is "TestsBinaryNew.txt";
            variable currentInstruction: std_logic_vector(7 downto 0) := "00000000";
            begin

                while not(endfile(infile))loop
                    read_v1d(infile, check);

    

    
    end behav;

