library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity keycode_operator is
    port(
        keycode: in std_logic_vector(7 downto 0);
        op: out std_logic_vector(1 downto 0)
    );
end keycode_operator;

architecture keycode_operator of keycode_operator is
    
    signal buff: std_logic_vector(1 downto 0);
    
begin

    process(keycode)
    begin
        case keycode is
            when 
        end case;
    end process;
    
    bin <= conv_std_logic_vector(buff, 8);
    
end keycode_operator;