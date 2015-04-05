-- Example 41b: keyboard_top
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.ps2_components.all;

entity keyboard_top is
    port(
        mclk : in STD_LOGIC;
        PS2C: in STD_LOGIC;
        PS2D: in STD_LOGIC;
        btn : in STD_LOGIC_VECTOR(3 downto 0);
        a_to_g : out STD_LOGIC_VECTOR(6 downto 0);
        dp : out STD_LOGIC;
        an : out STD_LOGIC_VECTOR(3 downto 0)
    );
end keyboard_top;

architecture keyboard_top of keyboard_top is

signal pclk, clk25, clk190, clr: std_logic;
signal xkey: std_logic_vector(15 downto 0);

begin
    clr <= btn(3);
    dp <= '1'; -- decimal points off
    
U1 : clkdiv2
    port map(mclk => mclk, clr => clr, clk25 => clk25, clk190 => clk190);
    
U2 : keyboard
    port map(clk25 => clk25, clr => clr, PS2C => PS2C, PS2D => PS2D, xkey => xkey);
    
U3 : x7segb
    port map(x => xkey, cclk => clk190, clr => clr,a_to_g => a_to_g, an => an);
    
end keyboard_top;