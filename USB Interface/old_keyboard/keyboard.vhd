-- Example 41a: keyboard
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity keyboard is
    port(
        clk25 : in STD_LOGIC;
        clr : in STD_LOGIC;
        PS2C : in STD_LOGIC;
        PS2D : in STD_LOGIC;
        xkey : out STD_LOGIC_VECTOR(15 downto 0)
    );
end keyboard;

architecture keyboard of keyboard is

    signal PS2Cf, PS2Df: std_logic;
    signal ps2c_filter, ps2d_filter: std_logic_vector(7 downto 0);
    signal shift1, shift2: std_logic_vector(10 downto 0);
    
begin

xkey <= shift2(8 downto 1) & shift1(8 downto 1);

-- filter for PS2 clock and data
filter: process(clk25, clr)
begin
    if clr = '1' then
        ps2c_filter <= (others => '0');
        ps2d_filter <= (others => '0');
        PS2Cf <= '1';
        PS2Df <= '1';
    elsif clk25'event and clk25 = '1' then
        ps2c_filter(7) <= PS2C;
        ps2c_filter(6 downto 0) <= ps2c_filter(7 downto 1);
        ps2d_filter(7) <= PS2D;
        ps2d_filter(6 downto 0) <= ps2d_filter(7 downto 1);
        if ps2c_filter = X"FF" then
            PS2Cf <= '1';
        elsif ps2c_filter = X"00" then
            PS2Cf <= '0';
        end if;
        if ps2d_filter = X"FF" then
            PS2Df <= '1';
        elsif ps2d_filter = X"00" then
            PS2Df <= '0';
        end if;
    end if;
end process filter;

--Shift Registers used to clock in scan codes from PS2--
shift: process(PS2Cf, clr)
begin
    if (clr = '1') then
        Shift1 <= (others => '0');
        Shift2 <= (others => '0');
    elsif (PS2Cf'event and PS2Cf = '0') then
        Shift1 <= PS2Df & Shift1(10 downto 1);
        Shift2 <= Shift1(0) & Shift2(10 downto 1);
    end if;
end process shift;

end keyboard;