library IEEE;
use IEEE.Std_Logic_1164.all;

entity mux2x1 is -- Esse mux foi modificado e é na verdade um mux 4x1 de 2bit. Mantivemos o nome para não ter que mudar muitas coisas...
	port(
		x: in std_logic_vector(1 downto 0);--C1
		y: in std_logic_vector(1 downto 0);--C2
		z: in std_logic_vector(1 downto 0);--C3
		w: in std_logic_vector(1 downto 0);--C4
		s: in std_logic_vector(1 downto 0);--selecao
		m: out std_logic_vector(1 downto 0)--saida
	);
end mux2x1;

architecture circuito of mux2x1 is
begin
	m <= x when s = "00" else
		  y when s = "01" else
		  z when s = "10" else
		  w;
end circuito;
