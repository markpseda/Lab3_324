library ieee;
use ieee.std_logic_1164.all;

-- this is the highest level implementation of our calulator ISA using all other modules
-- The controller is implemented in parts here, rather than in it's own structure, to reduce the number of signals passed around that are confusing
-- Any controller value from the schematic is mentioned here where it is generated. 


entity single_cycle is
    port(
        I: in std_logic_vector(7 downto 0);
        clk: in std_logic;
        O: out std_logic_vector(7 downto 0)
    );

end entity single_cycle;

architecture structure of single_cycle is
component register_module is
    port(
        rs:     in std_logic_vector(1 downto 0);
        rt:     in std_logic_vector(1 downto 0);
        des:    in std_logic_vector(1 downto 0);
        write_data: in std_logic_vector(7 downto 0);
        clk:    in std_logic;
        enableWrite: in std_logic;
        rsval:   out std_logic_vector(7 downto 0);
        rtval:   out std_logic_vector(7 downto 0)
    );
end component;

component display_module is
    port(
        reg_data : in std_logic_vector(7 downto 0);
		reg_num: in std_logic_vector(1 downto 0);
		enable   : in std_logic;
		clk : in std_logic
    );
end component;

-- do we need hold register? Probably

component adder_subtractor_8b is
    port(
        Mode : in std_logic;
        A, B : in std_logic_vector(7 downto 0);
        C: out std_logic_vector(7 downto 0)
    );
end component;


component sign_extend_module is
    port(
        in_4b: in std_logic_vector (3 downto 0);
		out_8b: out std_logic_vector (7 downto 0)
    );
end component;


-- SIGNALS HERE
signal sign_extend_val, write_data_input, rs_value, rt_value, addsub_input_a, addsub_input_b, adder_subtractor_8b_out: std_logic_vector(7 downto 0);
-- hold register?
signal display_enable, write_enable, subtraction_enable: std_logic;

signal rs_in, rt_in, des_in: std_logic_vector(1 downto 0); -- vary because of varying opcodes



-- END SIGNALS

begin


sign_extend: sign_extend_module port map(
    in_4b => I(3 downto 0),
    out_8b => sign_extend_val
);

register_mod: register_module port map(
    rs => rs_in,
    rt => rt_in,
    des => des_in,
    write_data => write_data_input,
    clk => clk,
    enableWrite => write_enable,
    rsval => rs_value,
    rtval => rt_value
);

adder_subtractor: adder_subtractor_8b port map(
    Mode => subtraction_enable,
    A => addsub_input_a,
    B => addsub_input_b,
    C => write_data_input
);

display: display_module port map(
    reg_data => rs_value,
    reg_num => rs_in,
    enable => display_enable,
    clk => clk
);


-- SPEC_OP CONTROL SIGNALS
process(I(7), I(6)) is
    begin
        if(I(7) = '0' and I(6) = '1') then
            rs_in <= I(4 downto 3);
            rt_in <= I(5 downto 4);
        else
            rs_in <= I(5 downto 4);
            rt_in <= I(3 downto 2);
        end if;
end process;

-- DEST_SEL CONTROL SIGNAL
process(I(7), I(6)) is
    begin
        if(I(7) = '1' or I(6) = '1') then
            des_in <= I(1 downto 0);
        else
            des_in <= I(5 downto 4);
        end if;
end process;

-- ADD_SUB_SEL
process(I(7), I(6)) is
    begin
        if(I(7) = '1' or I(6) = '1') then
            addsub_input_a <= rs_value;
            addsub_input_b <= rt_value;
        else
            addsub_input_a <= "00000000";
            addsub_input_b <= sign_extend_val;
        end if;
end process;

-- PRINT_EN
process(I(7 downto 5)) is
    begin
        if(I(7 downto 5) = "010") then
            display_enable <= '1';
        else
            display_enable <= '0';
        end if;
end process;

-- ALU_SUB
process(I(7 downto 6)) is
    begin
        if(I(6) = '0' or (I(7) = '0' and I(6) = '1')) then
            subtraction_enable <= '1';
        else
            subtraction_enable <= '0';
        end if;
end process;

-- WRITE_EN
write_enable <= '1';



-- idea - make all the control values one process that is sequential and triggered by clock, then triggers the internal clock signals that gets sent to the other modules...





--component controller_module
--    port(
--        A: in std_logic
--    );
--end component;

end structure;