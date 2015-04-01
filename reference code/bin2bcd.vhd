library ieee; 
use ieee.std_logic_1164.all;
--BEHR
entity bin2bcd is
	port (
		CLK: in std_logic;
		RST: in std_logic;
		D: in std_logic_vector(7 downto 0);
		H: out std_logic_vector(3 downto 0);
		T: out std_logic_vector(3 downto 0);
		U: out std_logic_vector(3 downto 0)
	);
end bin2bcd;

architecture conversor of bin2bcd is
	signal J1, J2, J3, J4, J5, J6, J7: std_logic_vector(3 downto 0);--saida dos modadd3
	component modadd3
	port (
		A: in std_logic_vector(3 downto 0);
		S: out std_logic_vector(3 downto 0)
	);
	end component;
	--Utilizacao de outro nivel de hierarquia para realizar conversao
	begin
		ma1: modadd3 
			port map (
				A(3) => '0', A(2 downto 0) => D(7 downto 5),
				S(3 downto 0) => J1
			);
		ma2: modadd3 
			port map (
				A(3 downto 1) => J1(2 downto 0), A(0) => D(4),
				S(3 downto 0) => J2
			);
		ma3: modadd3 
			port map (
				A(3 downto 1) => J2(2 downto 0), A(0) => D(3),
				S(3 downto 0) => J3	
			);
		ma4: modadd3 
			port map (
				A(3 downto 1) => J3(2 downto 0), A(0) => D(2),
				S(3 downto 0) => J4
			);	
		ma5: modadd3 
			port map (
				A(3 downto 1) => J4(2 downto 0), A(0) => D(1),
				S(3 downto 0) => J5
			);
		ma6: modadd3 
			port map (
				A(3) => '0', A(2) => J1(3), A(1) => J2(3), A(0) => J3(3),
				S(3 downto 0) => J6
			);
		ma7: modadd3 
			port map (
				A(3 downto 1) => J6(2 downto 0), A(0) => J4(3),
				S(3 downto 0) => J7
			);	
		H(3 downto 2) <= "00"; H(1) <= J6(3); H(0) <= J7(3);
		T(3 downto 1) <= J7(2 downto 0); T(0) <= J5(3);
		U(3 downto 1) <= J5(2 downto 0); U(0) <= D(0);

end conversor;