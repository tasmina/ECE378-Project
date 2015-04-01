library IEEE;
use IEEE.Std_Logic_1164.all;
--BEHR
entity modadd3 is
	port (
		A: in std_logic_vector(3 downto 0);
		S: out std_logic_vector(3 downto 0)
	);
end modadd3;

architecture combination of modadd3 is
	begin
		S <= "0000" when A = "0000" else
		"0001" when A = "0001" else
		"0010" when A = "0010" else
		"0011" when A = "0011" else
		"0100" when A = "0100" else
		"1000" when A = "0101" else --Quando A>=5, entao +3
		"1001" when A = "0110" else
		"1010" when A = "0111" else
		"1011" when A = "1000" else
		"1100" when A = "1001";--don't care para as demais
	end combination;