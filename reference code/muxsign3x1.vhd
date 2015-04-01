library IEEE;
use IEEE.Std_Logic_1164.all;

entity muxsign3x1 is
	port (
		x, y, z: in std_logic;
		s: in std_logic_vector(4 downto 0);
		m: buffer std_logic
	);
end muxsign3x1;

architecture circuito of muxsign3x1 is
	signal tempM:std_logic;
		begin 
			m <= x when s = "01011" else--sign A
				y when s = "00101" else--sign B
				z when s = "10000" else--sign result
				m;
end circuito;
