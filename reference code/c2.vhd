library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all; -- necessario para o +

entity C2 is
	port (
		A: in std_logic_vector(7 downto 0);
		B: in std_logic_vector(7 downto 0);
		F: out std_logic_vector(7 downto 0);
		LG01C2: out std_logic_vector(1 downto 0)-- 0->ledg0, 1->ledg1
		);
end C2;

architecture circuito of C2 is
	signal carry: std_logic_vector (7 downto 0);
	signal soma: std_logic_vector (7 downto 0);
	signal B2: std_logic_vector (7 downto 0);
	
	component FA
	port (a, b, c: in std_logic;
		soma, carry: out std_logic);
	end component;
	
	begin 
	B2 <= not(B);
	
	FA0: FA port map (A(0), B2(0), '1', soma(0), carry(0)); --carry in deve ser 1 na subtracao

	FA1: FA port map (A(1), B2(1), carry(0), soma(1), carry(1));

	FA2: FA port map (A(2), B2(2), carry(1), soma(2), carry(2));

	FA3: FA port map (A(3), B2(3), carry(2), soma(3), carry(3));
	
	FA4: FA port map (A(4), B2(4), carry(3), soma(4), carry(4));

	FA5: FA port map (A(5), B2(5), carry(4), soma(5), carry(5));

	FA6: FA port map (A(6), B2(6), carry(5), soma(6), carry(6));

	FA7: FA port map (A(7), B2(7), carry(6), soma(7), carry(7));
	
	F <= soma;
	
	LG01C2(0) <= carry(7); -- carry out
	LG01C2(1) <= carry(6) xor carry(7); -- overflow: esta e' uma previsao de overflow, ou seja, acendera' o flag mesmo antes de concluir a operacao 
end circuito;

--nao era possivel ligar direto nos leds, tem que usar top como intermedio