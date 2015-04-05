library ieee;
use ieee.std_logic_1164.all;

entity fsm is
    port(   resetn,w,Rx,Ry,clock: in std_logic;
            f : in std_logic_vector(2 downto 0);
            SM : out std_logic_vector(1 downto 0);
            E_A, E_G, E_IN, E_OUT, done, E_IR, Ex : out std_logic;
            op: out std_logic_vector(3 downto 0));
end fsm;

architecture bhv of fsm is

    type state is (S1, S2, S3a, S3b, S4a, S4b, S5a, S5b, S6, S7);
    signal y : state;

begin

    --Transitions
    Transitions: process(clock, resetn, w, f)
    begin
        if resetn = '0' then
            y <= S1;  
		  elsif (clock'event and clock = '1') then
            case y is
                when S1 =>
                    if w = '1' then
                        y <= S2;
                    else
                        y <= S1;
                    end if;
                    
                when S2 =>
                    case f is
                        when "000" => y <= S7;
                        when "001" => y <= S7;
                        when "010" => y <= S7;
                        when "011" => y <= S3a;
                        when "100" => y <= S4a;
                        when "101" => y <= S5a;
                        when "110" => y <= S6;
                        when others => y <= S7;
                    end case;
                    
                when S3a => y <= S3b;
                when S3b => y <= S7;
                when S4a => y <= S4b;
                when S4b => y <= S7;
                when S5a => y <= S5b;
                when S5b => y <= S7;
                when S6 =>  y <= S7;
                when S7 =>
                    if w = '1' then
                        y <= S7;
                    else 
                        y <= S1;
                    end if;
            end case;
        end if;
    end process;


    --Outputs
    Outputs: process(y, w, f, Rx, Ry)
    begin
        --Initialize the output signals
        SM <= (others => '0');
        E_A <= '0';
        E_G <= '0';
        op <= (others => '0');
        E_IN <= '0';
        E_OUT <= '0';
        done <= '0';
        E_IR <= '0';
        Ex <= '0';
        
        case y is
            when S1 =>
                if w = '1' then
                    E_IR <= '1';
                end if;
                
            when S2 =>
                case f is
                    when "000" =>
                        E_IN <= '1'; 
                    when "001" =>
                        SM <= "00";
                        Ex <= '1';
                        
                    when "010" =>
                        SM <= '1' & Ry;
                        Ex <= '1';
                    when "011" =>
                        SM <= '1' & Rx;
                        E_A <= '1';
                    when "100" => 
                        SM <= '1' & Rx;
                        E_A <= '1';
                    when "101" => 
                        SM <= '1' & Rx;
                        E_A <= '1';
                    when "110" =>
                        SM <= '1' & Rx;
                        op <= "0100";
                        E_G <= '1';
                    when others =>
                        SM <= '1' & Rx;
                        E_OUT <= '1';
                    end case;
            when S3a =>
                SM <= '1' & Ry;
                E_G <= '1';
                op <= "0110";
            when S3b =>
                SM <= "01";
                Ex <= '1';
            when S4a=>
                SM <= "00";
                E_G <= '1';
                op <= "0110";
            when S4b =>
                SM <= "01";
                Ex <= '1';
            when S5a =>
                SM <= '1' & Ry;
                E_G <= '1';
                op <= "1110";
            when S5b =>
                SM <= "01";
                Ex <= '1';
            when S6 =>
                SM <= "01";
                Ex <= '1';
            when S7 =>
                done <= '1';
        end case;
    end process;
end bhv;