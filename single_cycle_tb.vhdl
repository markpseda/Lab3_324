library ieee;
use ieee.std_logic_1164.all;
use STD.textio.all;

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


    procedure read_v1d (variable f:in text; v : out std_logic_vector) is
        variable buf: line;
        variable c : character;
        begin 
        readline(f, buf);
        for i in v'range loop read(buf, c);
         case c is when'X' => v (i) := 'X';
         when'0' => v (i) := '0';
         when'1' => v (i) := '1';
         when others=> v (i) := '0';
         end case;
         end loop;
    end read_v1d;




    begin

        single_cycle_cpu: single_cycle port map(
            I => current_instruction,
            clk => clock,
            O => current_output
        );


        --  This process does the real job.
        process is
            file infile: TEXT open read_mode is "TestsBinaryNew.txt";
            variable currentInstruction: std_logic_vector(7 downto 0) := "00000000";
            begin

                while not(endfile(infile))loop
                    read_v1d(infile, currentInstruction);
                    current_instruction <= currentInstruction;
                    clock <= '1';
                    wait for 1 ns;
                    clock <= '0';
                    wait for 1 ns;
                end loop;
            wait;
        end process;
                    
end behavioral;


