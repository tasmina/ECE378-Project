library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all; --necessario para o +
--BEHR
entity complement2 is
	port(
	I: in std_logic_vector(7 downto 0);
	O: out std_logic_vector(7 downto 0)
	);
end complement2;

architecture lesen of complement2 is
	begin
		O <= I when I(7) = '0' else
		not(I) + "00000001";
end lesen;
--testado e funcionado em 10-11-13, 00:23