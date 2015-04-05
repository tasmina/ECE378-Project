--Clock Divider
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clkdiv2 is
    port (
        mclk: in std_logic;
        clr : in std_logic;
        clk25 : out std_logic;
        clk190 : out std_logic
    );
end clkdiv2;

architecture clkdiv2 of clkdiv2 is
    
    signal q: std_logic_vector(17 downto 0);
    
begin
    --clock divider
    process(mclk, clr)
    begin
        if clr = '1' then
            q <= (others => '0');
        elsif mclk'event and mclk = '1' then
            q <= q + 1;
        end if;
    end process;
    
    clk25 <= q(0);
    clk190 <= q(17);
    
end clkdiv2;
    
    