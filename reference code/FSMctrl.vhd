library ieee; use ieee.std_logic_1164.all;
entity FSMctrl is

	port ( 
		Clk, Rst, Enter : in std_logic;
		operacao: in std_logic_vector(1 downto 0);
		selecao: out std_logic_vector(1 downto 0);
		Enable_1, Enable_2: out std_logic
	);
end FSMctrl;

architecture FSM_beh of FSMctrl is
	type states is (S0, S1, S2, S3, S4, S5, S6, S7);
	signal EA, PE: states;
	signal clock: std_logic;
	signal reset: std_logic;
	signal temp: std_logic_vector(1 downto 0);
	
	begin
		clock <= Clk;
		reset <= Rst;
		
		P1: process(clock, reset)--process transicao
			begin
				if reset = '0' then
					EA <= S0;
				elsif rising_edge(clock) then
					EA <= PE;
				end if;
			end process;
			
		P2: process(EA, enter)-- process proximo estado
			begin
				case EA is
					when S0 =>
						if enter = '1' then
							PE <= S0;
						else 
							PE <= S1;
						end if;				
					when S1 =>
						if enter = '0' then
							PE <= S1;
						else
							PE <= S2;
						end if;							
					when S2 =>
						if operacao = "00" then
							PE <= S3; -- Fazer soma
						elsif operacao = "01" then
							PE <= S4; -- Fazer subtracao
						elsif operacao = "10" then
							PE <= S5; --fazer divisao
						elsif operacao = "11" then
							PE <= S6;--fazer produto
						end if;
					when S3 =>
						if Enter = '1' then 
							PE <= S3; 
						else 
							PE <= S7;
						end if;
					when S4 =>
						if Enter = '1' then 
							PE <= S4; 
						else 
							PE <= S7;							
							end if;
					when S5 =>
						if Enter = '0' then
							PE <= S5; 
						else 
							PE <= S0;
						end if;
					when S6 =>
						if Enter = '0' then --adicionado um looping para esperar o Enter ser solto
							PE <= S6;
						else
							PE <= S0;
						end if;
					when S7 =>
						if Enter = '0' then --adicionado um looping para esperar o Enter ser solto
							PE <= S7;
						else
							PE <= S0;
						end if;										
				end case;
			end process;
			
			P3: process(EA)--process output
			begin
				case EA is
					when S0 =>
						Enable_1 <= '0'; 
						Enable_2 <= '0';
						selecao <= temp;
					when S1 =>
						Enable_1 <= '1';
						Enable_2 <= '0';
						selecao <= temp;
					when S2 =>
						Enable_1 <= '0'; 
						Enable_2 <= '0';
						selecao <= temp;
					when S3 =>
						temp <= "00";
						temp <= "00";
						selecao <= temp;
					when S4 =>
						Enable_1 <= '0'; 
						Enable_2 <= '0';
						temp <= "01";
						selecao <= temp;
					when S5 =>
						Enable_1 <= '0'; 
						Enable_2 <= '1';
						temp <= "10";
						selecao <= temp;
					when S6 =>
						Enable_1 <= '0'; 
						Enable_2 <= '1';
						temp <= "11";
						selecao <= temp;
					when S7 =>
						Enable_1 <= '0';
						Enable_2 <= '1';
						selecao <= temp;
				end case;
			end process;
end FSM_beh;