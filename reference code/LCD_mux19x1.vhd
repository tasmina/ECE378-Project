library IEEE;
use IEEE.Std_Logic_1164.all;

entity LCD_mux19x1 is --criado em 10/11/13
	port (
		a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s: in std_logic_vector(7 downto 0);
		selLCD: in std_logic_vector(4 downto 0);
		output: out std_logic_vector(7 downto 0)
	);
end LCD_mux19x1;

architecture circuito of LCD_mux19x1 is
	begin 															--inputs
		output <= a when selLCD = "00000" else--H res		m1\
					b when selLCD = "00001" else --T res		m2 \
					c when selLCD = "00010" else --U res		m3  \
					d when selLCD = "00011" else --H opA		m4   \
					e when selLCD = "00100" else --T opA		m5    >- from the decoder B2A
					f when selLCD = "00101" else --U opA		m6   /
					g when selLCD = "00110" else --H opB		m7  /
					h when selLCD = "00111" else --T opB		m8 /
					i when selLCD = "01000" else --U opB		m9/
					j when selLCD = "01001" else --setup 1		"00111000"
					k when selLCD = "01010" else --setup 2		"00001111"
					l when selLCD = "01011" else --setup 3		"00000110"
					m when selLCD = "01100" else -- "+"			"00101011"
					n when selLCD = "01101" else -- "-"			"00101101"
					o when selLCD = "01110" else -- "*"			"00101111"
					p when selLCD = "01111" else -- "/"			"00101010"
					q when selLCD = "10000" else -- "="			"00111101"
					r when selLCD = "10001" else -- "2"			"00110010"
					s;								--"00000001"
end circuito;