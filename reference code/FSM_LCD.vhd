library ieee; 
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity FSM_LCD is
	port(
		Clk, Rst : in std_logic;
		Operacao: in std_logic_vector(1 downto 0);
		sign: in std_logic;
		S: out std_logic_vector(4 downto 0);--selecao LCD_mux19x1
		RS: out std_logic;--0=comando, 1=dado
		EN: out std_logic--0=bloqueado, 1=liberado
	);
end FSM_LCD;

architecture automat of FSM_LCD is
	type states is (S0, S1, S2, S3,S3_0, S4, S5, S6_00, S6_01, S6_10, S6_11, S7_0, S7_1, S8, S9, S10, S11, S11_0, S12, S13, S14, S7_S, shift1, shift2, shift3, shift4, shift5);
	signal EA, PE: states;
	signal clock: std_logic;
	signal reset: std_logic;
	signal delay : integer :=300000;
	constant M : integer := 300000;--distinguir valor ao simular(30) e ao executar por hardware(10^6)

	begin
		clock <= Clk;
		reset <= Rst;
	
		P1: process(clock, reset)
				begin
					if reset = '0' then 
						EA <= S0;--S0,S1 e S2 sao setup, nao ignorar-los ao resetar
						delay <= M;
					elsif rising_edge(clock) then 
						if delay = 1000 then	
							EA <= PE;							
						else
							delay <= delay - 1;
						end if;
						if delay < 1500 and delay > 500 then
							EN <= '1'; 
							else
							EN <= '0';
						end if;
						if delay = 1000 then
						delay <= M;
						end if;
					end if;
			end process;
												
		P2: process(EA)
				begin
						case EA is
							
							when S0 =>				--setup 1
								RS <= '0';
								--EN <= '1';
								S <= "01001";
								PE <= S1;														
							when S1 =>				--setup 2
								RS <= '0';
								--EN <= '1';
								S <= "01010";
								PE <= S2;
							when S2 =>				--setup 3
								RS <= '0';
								--EN <= '1';
								S <= "01011";
								PE <= S3_0;
							when S3_0 =>			--sinal A
								RS <= '1';
								if sign = '1' then S <= "01101";
								else S <= "01100";
								end if;	
								PE <= S3;	
							when S3 =>				--hundreds A
								RS <= '1';
								S <= "00011";
								PE <= S4;
							when S4 =>				--tens A
								RS <= '1';
								S <= "00100";
								PE <= S5;
							when S5 =>				--units A
								RS <= '1';
								S <= "00101";
								case Operacao is
									when "00" =>
										PE <= S6_00;
									when "01" =>
										PE <= S6_01;
									when "10" =>
										PE <= S6_10;
									when "11" =>
										PE <= S6_11;
									when others =>
										PE <= S6_00;
								end case;
							when S6_00 =>			--soma
								RS <= '1';
								S <= "01100";
								PE <= S7_S;
							when S6_01 =>			--subtracao
								RS <= '1';
								S <= "01101";
								PE <= S7_S;
							when S6_10 =>			--divisao por 2
								RS <= '1';
								S <= "01110" ;
								PE <= S7_1;
							when S6_11 =>			--multiplicacao por 2
								RS <= '1';
								S <= "01111";
								PE <= S7_1;
							when S7_S =>			--sinal de B
								if sign = '1' then S <= "01101";
								else S <= "01100";
								end if;
								PE <= S7_0;
							when S7_0 =>			--hundreds B
								RS <= '1';
								S <= "00110";
								PE <= S8;
							when S7_1 =>			--2
								RS <= '1';
								S <= "10001";
								PE <= S10;
							when S8 =>				--tens B
								RS <= '1';
								S <= "00111";
								PE <= S9;
							when S9 =>				--units B
								RS <= '1';
								S <= "01000";
								PE <= S10;
							when S10 =>				-- "="
								RS <= '1';
								S <= "10000";
								PE <= S11_0;
							when S11_0 =>			--Sinal do resultado
								RS <= '1';
								if sign = '1' then S <= "01101";
								else S <= "01100";
								end if;
								PE <= S11;								
							when S11 =>				--hudreds do resultado
								RS <= '1';
								S <= "00000";
								PE <= S12;
							when S12 =>				--tens do resultado
								RS <= '1';
								S <= "00001";
								PE <= S13;
							when S13 =>				--units do resultado
								RS <= '1';
								S <= "00010";
								PE <= shift1;
							when S14 =>				--comando limpar tela
								RS <= '0';
								S <= "10010";
								PE <= S2;
							when shift1 =>				--setup 3 (cursor pra direita)
								RS <= '0';
								S <= "01011";
								PE <= shift2;
							when shift2 =>				--setup 3 (cursor pra direita)
								RS <= '0';
								S <= "01011";
								PE <= shift3;
							when shift3 =>				--setup 3 (cursor pra direita)
								RS <= '0';
								S <= "01011";
								PE <= shift4;
							when shift4 =>				--setup 3 (cursor pra direita)
								RS <= '0';
								S <= "01011";
								PE <= shift5;
							when shift5 =>				--setup 3 (cursor pra direita)
								RS <= '0';
								S <= "01011";
								PE <= S14;
						end case;					
			end process;
end automat;