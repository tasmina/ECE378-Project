--Keyboard top
library ieee;
use ieee.std_logic_1164.all;
--use work.ps2_components.all;

entity keyboard_top is
    port(
        mclk : in std_logic;
        PS2C : in std_logic;
        PS2D : in std_logic;
        btn : in std_logic;
        ld : out std_logic_vector(7 downto 0);
        a_to_g : out std_logic_vector(6 downto 0);
        dp : out std_logic;
        an : out std_logic_vector(7 downto 0)
    );
end keyboard_top;

architecture keyboard_top of keyboard_top is

	component clkdiv2 is
    port (
        mclk: in std_logic;
        clr : in std_logic;
        clk25 : out std_logic;
        clk190 : out std_logic
    );
	end component;
	
	component keyboard_ctrl is
    port(
        clk25 : in std_logic;
        clr : in std_logic;
        PS2C : in std_logic;
        PS2D : in std_logic;
        keyval1 : out std_logic_vector(7 downto 0);
        keyval2 : out std_logic_vector(7 downto 0);
        keyval3 : out std_logic_vector(7 downto 0)
    );
	end component;
	
	component x7segbc is
    port(
        x: in std_logic_vector(15 downto 0);
        cclk : in std_logic;
        clr : in std_logic;
        a_to_g : out std_logic_vector(6 downto 0);
        an : out std_logic_vector(7 downto 0);
        dp : out std_logic
    );
	end component;

    signal pclk, clk25, clk190, clr : std_logic;
    signal xkey: std_logic_vector(15 downto 0);
    signal keyval1, keyval2, keyval3: std_logic_vector(7 downto 0);
    
begin
    xkey <= keyval1 & keyval2;
    ld <= keyval3;
    clr <= btn;
    
U1 : clkdiv2
    port map (mclk => mclk, clr => clr, clk25 => clk25, clk190 => clk190);
    
U2 : keyboard_ctrl
    port map (clk25 => clk25, clr => clr, PS2C => PS2C, PS2D => PS2D, keyval1 => keyval1, keyval2 => keyval2, keyval3 => keyval3);
    
U3 : x7segbc
    port map (x => xkey, cclk => clk190, clr => clr, a_to_g => a_to_g, an => an, dp => dp);
    
end keyboard_top;