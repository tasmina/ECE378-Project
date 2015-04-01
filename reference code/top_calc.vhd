--Projeto Final de Sistemas Digitais (EEL7020)-CTC-UFSC
--2013.2 - Calculadora com display LCD
--Alunos: Eduardo Behr, Mateus Cichelero e Vinícius Peiter

library ieee; 
use ieee.std_logic_1164.all;

entity top_calc is
	port ( 
		SW : in std_logic_vector (17 downto 0);--switches
		HEX0, HEX1: out std_logic_vector(6 downto 0);
		key: in std_logic_vector(1 downto 0);--1: enter, 0: reset
		clock_50: in std_logic;
		LEDR: out std_logic_vector (3 downto 0);--mostram flags durante as operacoes, mas considerar apenas ao final do resultado
		LEDG: out std_logic_vector (7 downto 0); --resultado em bina'rio
		LCD_BLON: out std_logic;
		LCD_ON: out std_logic;
		LCD_RW: out std_logic;
		LCD_DATA: out std_logic_vector(7 downto 0);--ligar ao LCD_mux19x1
		LCD_RS: out std_logic;--0=comando, 1=dado
		LCD_EN: out std_logic--0=bloqueado, 1=liberado
	);
end top_calc;

architecture topo_stru of top_calc is
	signal F, F1, F2, F3, F4, G3, G5, Fc2, cbA, cbB, cbR: std_logic_vector (7 downto 0);
	--F e Fx:  resultado saindo do mux4x1, soma, subt, div e prod
	--G3 e G5: saida do R3 para LEGG(7...0)  e saida do R4 para realizar soma e subtracao (operando A)
	--cbx: saida dos dados (A,B e R) do complement2 para bin2bcd
	signal G2: std_logic_vector(3 downto 0);--resultado com bits menos significativos indo para 7-seg
	signal G1: std_logic_vector(7 downto 4);--resultado com bits mais significativos indo para 7-seg
	signal E1, E2: std_logic;--enable utilizado pelo FSMctrl para controlar registradores
	signal G4: std_logic_vector(1 downto 0);--FSMctrl, mux4x1(selecao) e mux3x1(selecao)
	signal H1, H2, H3, T1, T2, T3, U1, U2, U3: std_logic_vector(3 downto 0);--sinais de saida dos bin2bcd
	signal m1, m2, m3, m4, m5, m6, m7, m8, m9: std_logic_vector(7 downto 0);--conexoes MUXLCD
	signal c1toflags, c2toflags, c4toflags: std_logic_vector(1 downto 0);--vai pros flags
	signal lcdmuxselect: std_logic_vector(4 downto 0);
	signal Si: std_logic; --conexoes dos sinais de A, B e Resultado
	signal mux2LCD: std_logic_vector(7 downto 0);--conexao entre lcd_mux19x1 e LCD_DATA
	
	component C1
		port (
			A : in std_logic_vector(7 downto 0);
			B : in std_logic_vector(7 downto 0); 
			F : out std_logic_vector(7 downto 0);
			LG01C1: out std_logic_vector(1 downto 0)-- 0->ledg0, 1->ledg1
		);
	end component;
	
	component C2
		port (
			A : in std_logic_vector(7 downto 0);
			B : in std_logic_vector(7 downto 0); 
			F : out std_logic_vector(7 downto 0);
			LG01C2: out std_logic_vector(1 downto 0)-- 0->ledg0, 1->ledg1
		);
	end component;

	component C3
		port ( 
			clk : in std_logic;
			enable : in std_logic;
			reset : in std_logic;
			A: in std_logic_vector((7) downto 0);--N
			F : out std_logic_vector((7) downto 0)--N
		);
	end component;

	component C4
		port ( 
			clk : in std_logic;
			enable : in std_logic;
			reset : in std_logic;
			A: in std_logic_vector((7) downto 0);--N
			F : out std_logic_vector((7) downto 0);--N
			LG01C4: out std_logic_vector(1 downto 0)
		);
	end component;

	component mux4x1
		port (
			w, x, y, z: in 
			std_logic_vector(7 downto 0);
			s: in std_logic_vector(1 downto 0);
			m: out std_logic_vector(7 downto 0)
			--LG32: out std_logic_vector(1 downto 0)
		);
	end component;

	component Decod7seg
		port (
			C: in std_logic_vector(3 downto 0);
			F: out std_logic_vector(6 downto 0)
		);
	end component;

	component Registrador4 --4 bits, utilizado para levar o resultado ao Decod7seg
		port (
			CLK: in std_logic;
			RST: in std_logic;
			EN: in std_logic;
			D: in std_logic_vector(3 downto 0);
			Q: out std_logic_vector(3 downto 0)
		);
	end component;

	component Registrador8 --utilizado para registrar o operando A, e para registrar o resultado(para LCDG e bin2bcd2)
		port (
			CLK: in std_logic;
			RST: in std_logic;
			EN: in std_logic;
			D: in std_logic_vector(7 downto 0);
			Q: out std_logic_vector(7 downto 0)
		);
	end component;

	component FSMctrl
		port ( 
			Clk, Rst, Enter : in std_logic;
			Operacao: in std_logic_vector(1 downto 0);
			Selecao: out std_logic_vector(1 downto 0);
			Enable_1, Enable_2: out std_logic
		);
	end component;

	component bin2bcd
		port (
			CLK: in std_logic;
			RST: in std_logic;
			D: in std_logic_vector(7 downto 0);
			H: out std_logic_vector(3 downto 0);
			T: out std_logic_vector(3 downto 0);
			U: out std_logic_vector(3 downto 0)
		);
	end component;	
	
	component B2A
		port(
			D: in std_logic_vector(3 downto 0);
			A: out std_logic_vector(7 downto 0)
		);
	end component;
		
	component complement2--converte para positivo caso seja negativo, e manda para ser processado pro LCD
		port(
			I: in std_logic_vector(7 downto 0);
			O: out std_logic_vector(7 downto 0)
		);
	end component;
	
	component FSM_LCD
	port(
		Clk, Rst : in std_logic;
		Operacao: in std_logic_vector(1 downto 0);--operacao SW(17 downto 16)
		sign: in std_logic;
		S: out std_logic_vector(4 downto 0);--selecao LCD_mux19x1
		RS: out std_logic;--0=comando, 1=dado
		EN: out std_logic--0=bloqueado, 1=liberado
	);
	end component;
	
	component LCD_mux19x1
		port (
			a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s: in std_logic_vector(7 downto 0);
			selLCD: in std_logic_vector(4 downto 0);
			output: out std_logic_vector(7 downto 0)
		);
	end component;
	
	component mux2x1--inicialmente era 2x1
		port(
			x: in std_logic_vector(1 downto 0);--C1
			y: in std_logic_vector(1 downto 0);--C2
			z: in std_logic_vector(1 downto 0);--C3
			w: in std_logic_vector(1 downto 0);--C4
			s: in std_logic_vector(1 downto 0);--selecao
			m: out std_logic_vector(1 downto 0)--saida
			);
	end component;
	
	component muxsign3x1
	port (
		x, y, z: in std_logic;
		s: in std_logic_vector(4 downto 0);
		m: buffer std_logic
	);
end component;

begin
	LCD_BLON <= '1';
	LCD_ON <= '1';
	LCD_RW <= '0';
		
	R4: Registrador8 port map (clock_50, KEY(0), E1, SW(7 downto 0), G5);
	
	L1: C1 port map (G5, SW(7 downto 0), F1, c1toflags);
	L2: C2 port map (G5, SW(7 downto 0), F2, c2toflags);
	
	L8: mux2x1 port map (c1toflags, c2toflags, "00", c4toflags, G4, LEDR(2 downto 1));--2: overflow, 1: carry

	L3: C3 port map (clock_50,'1','1', SW(7 downto 0), F3);
	L4: C4 port map (clock_50, '1', '1', SW(7 downto 0), F4, c4toflags);
	
	FS1: FSMctrl port map (clock_50, KEY(0), KEY(1), SW(17 downto 16), G4, E1, E2);
	
	L5: mux4x1 port map (F1, F2, F3, F4, G4, F);--LEDG(3 downto 2)
	
	R1: Registrador4 port map (clock_50, KEY(0),E2,F(3 downto 0),G2);
	R2: Registrador4 port map (clock_50, KEY(0),E2,F(7 downto 4),G1);
	
	L6: Decod7seg port map (G2(3 downto 0),HEX0);
	L7: Decod7seg port map (G1(7 downto 4),HEX1);
	
	R3: Registrador8 port map (clock_50, KEY(0),E2,F(7 downto 0),G3);--registrador do resultado
		
	B2B1: bin2bcd port map (clock_50, key(0), cbR, H1, T1, U1);--resultado
	B2B2: bin2bcd port map (clock_50, key(0), cbA, H2, T2, U2);--primeiro operando
	B2B3: bin2bcd port map (clock_50, key(0), cbB, H3, T3, U3);--segundo operando
		
	B2A1: B2A port map (H1, m1);
	B2A2: B2A port map (T1, m2);
	B2A3: B2A port map (U1, m3);
	B2A4: B2A port map (H2, m4);
	B2A5: B2A port map (T2, m5);
	B2A6: B2A port map (U2, m6);
	B2A7: B2A port map (H3, m7);
	B2A8: B2A port map (T3, m8);
	B2A9: B2A port map (U3, m9);
	
	MS: muxsign3x1 port map (G5(7), SW(7), G3(7), lcdmuxselect, Si);
	
	FS2: FSM_LCD port map (clock_50, key(0), SW(17 downto 16), Si, lcdmuxselect, LCD_RS, LCD_EN);
	
	MUXLCD: LCD_mux19x1 port map (m1, m2, m3, m4, m5, m6, m7, m8, m9, 
	"00111000", "00001111", "00000110", "00101011", "00101101", "00101111", "00101010", "00111101", "00110010", "00000001", lcdmuxselect, mux2LCD);
	
	LEDG(7 downto 0) <= G3;
	
	LEDR(0) <= F(7); --negativo (resultado do mux4x1)
	LEDR(3) <= '1' when F = "00000000" else '0';--zero (resultado do mux4x1)
	
	C2_A: complement2 port map (G5, cbA);
	C2_B: complement2 port map (SW(7 downto 0), cbB);
	C2_R: complement2 port map (G3, cbR);--(ate' 22/11)C2_R: complement2 port map (F, cbR);

	LCD_DATA <= mux2LCD;
	
	
end topo_stru;