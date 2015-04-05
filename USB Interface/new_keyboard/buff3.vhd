--Tri-state buffer
library ieee;
use ieee.std_logic_1164.all;

entity buff3 is
    generic(N:integer);
    port(
        input : in std_logic_vector(N-1 downto 0);
        en : in std_logic;
        output : out std_logic_vector(N-1 downto 0)
    );
end buff3;

architecture bhv of buff3 is
begin
    output <= input when en = '1' else (others => 'Z');
end buff3;