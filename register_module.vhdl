library ieee;
use ieee.std_logic_1164.all;

-- This is the module used to write to and read from 4 registers on clock signal when enable is true

-- rs and rt are two bit numbers input to identify the appropriate registers
-- rsval and rtval are the contents of these two registers
-- des is the destination register to be written to
-- write val is the data to be written
-- enableWrite is the input signal that determines if a register should be written to
entity register_module is
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
end register_module;



-- need to add 4 shift registers and allow proper reading and writing on clock when write_data is true


architecture structure of register_module is

-- include our 8 bit shift register from previous lab
component shift_reg_8b
port(
    I:	in std_logic_vector (7 downto 0);
	I_SHIFT_IN: in std_logic;
	sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
	clock:		in std_logic; -- positive level triggering in problem 3
	enable:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
	O:	out std_logic_vector(7 downto 0) := "00000000"
);
end component;

-- sel signals for each register
signal select0,select1,select2,select3 : std_logic_vector(1 downto 0);
-- output signals for each register
signal reg0Val, reg1Val, reg2Val, reg3Val : std_logic_vector(7 downto 0);
-- signal to trigger the register operations after necessary processes have finished
signal triggerRegisters: std_logic := '0';


begin
-- process to handle writing to register
process(enableWrite, des, clk) is
begin
    -- 00 is hold and 11 is load operation for shift registers
    select0 <= "00";
    select1 <= "00";
    select2 <= "00";
    select3 <= "00";
    if(enableWrite='1') then
        case des is
            when "00" => select0 <= "11";
            when "01" => select1 <= "11";
            when "10" => select2 <= "11";
            when "11" => select3 <= "11";
            when others => select0 <= "11"; -- default case for safety
        end case;
        -- a little bit "cheaty" here, but this ensures the write happens before the read
        if(clk'event) then
            if(clk = '1') then
                triggerRegisters <= '1';
            end if;
            if(clk = '0') then
                triggerRegisters <= '0';
            end if;
        end if;
    end if;
end process;

-- processes to handle reading from appropriate registers
process(reg0Val, reg1Val, reg2Val, reg3Val, rs, clk) is
begin
    case rs is
        when "00" => rsval <= reg0Val;
        when "01" => rsval <= reg1Val;
        when "10" => rsval <= reg2Val;
        when "11" => rsval <= reg3Val;
        when others => rsval <= reg0Val; -- safety again
    end case;
end process;

process(reg0Val, reg1Val, reg2Val, reg3Val, rt, clk) is
begin
    case rt is
        when "00" => rtval <= reg0Val;
        when "01" => rtval <= reg1Val;
        when "10" => rtval <= reg2Val;
        when "11" => rtval <= reg3Val;
        when others => rtval <= reg0Val; -- safety again
    end case;
end process;

reg0: shift_reg_8b port map(
    I => write_data,
	I_SHIFT_IN => '0',
	sel => select0,
	clock => triggerRegisters,
	enable => '1',
	O => reg0Val
);

reg1: shift_reg_8b port map(
    I => write_data,
	I_SHIFT_IN => '0',
	sel => select1,
	clock => triggerRegisters,
	enable => '1',
	O => reg1Val
);

reg2: shift_reg_8b port map(
    I => write_data,
	I_SHIFT_IN => '0',
	sel => select2,
	clock => triggerRegisters,
	enable => '1',
	O => reg2Val
);

reg3: shift_reg_8b port map(
    I => write_data,
	I_SHIFT_IN => '0',
	sel => select3,
	clock => triggerRegisters,
	enable => '1',
	O => reg3Val
);


end structure;

