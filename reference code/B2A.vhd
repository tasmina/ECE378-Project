library IEEE;
use IEEE.Std_Logic_1164.all;

entity B2A is
	port(
	D: in std_logic_vector(3 downto 0);		
	A: out std_logic_vector(7 downto 0)
	);
end B2A;

architecture kodifizierung of B2A is
	begin
		A(7 downto 4) <= "0011";			-- os numeros na tabela ascii
		A(3 downto 0) <= D;
end kodifizierung;