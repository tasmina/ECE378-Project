----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:28:18 04/01/2015 
-- Design Name: 
-- Module Name:    TopFile - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopFile is
    Port ( switches : in STD_LOGIC_VECTOR(3 downto 0);
	        resetn : in STD_LOGIC;
	        w : in  STD_LOGIC;
			  clock : in STD_LOGIC;
           IR : in  STD_LOGIC_VECTOR (4 downto 0);
           done : out  STD_LOGIC;
           LEDS : out  STD_LOGIC_VECTOR (3 downto 0));
end TopFile;

architecture Behavioral of TopFile is

	component ALU
		port  ( sel : in  STD_LOGIC_VECTOR (3 downto 0);
				A : in  STD_LOGIC_VECTOR (3 downto 0);
				B : in  STD_LOGIC_VECTOR (3 downto 0);
				G : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;

	component Multiplexer
		Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
				B : in  STD_LOGIC_VECTOR (3 downto 0);
				C : in  STD_LOGIC_VECTOR (3 downto 0);
				D : in  STD_LOGIC_VECTOR (3 downto 0);
				SM : in  STD_LOGIC_VECTOR (1 downto 0);
				BUS1 : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;

	
	component my_rege
	generic (N: INTEGER:= 4);
	port ( clock, resetn, sclr: in std_logic;
	       E: in std_logic; -- sclr: Synchronous clear
			 D: in std_logic_vector (N-1 downto 0);
	       Q: out std_logic_vector (N-1 downto 0));
	end component;	 
	
	component ControlCircuit
    Port ( clock : in STD_LOGIC;
	        w : in  STD_LOGIC;
			  resetn: in STD_LOGIC;
           IR : in  STD_LOGIC_VECTOR (4 downto 0);
           op : out  STD_LOGIC_VECTOR (3 downto 0);
           SM : out  STD_LOGIC_VECTOR (1 downto 0);
           E_A : out  STD_LOGIC;
           E_G : out  STD_LOGIC;
           E_IN : out  STD_LOGIC;
           E_OUT : out  STD_LOGIC;
           done : out  STD_LOGIC;
           E_R0 : out  STD_LOGIC;
           E_R1 : out  STD_LOGIC);
	  end component;

signal E_IN0, E_OUT0, E_R1, E_R0,E_A0,E_G0: std_logic;
signal G0, ALU0, mux0, mux1, mux2, mux3, BUS0,op0: std_logic_vector(3 downto 0); 
signal SM0: std_logic_vector(1 downto 0); 
signal sclrR: std_logic;
begin
sclrR <= '0';
f0: my_rege port map(clock=>clock, sclr => sclrR, resetn => resetn, E=>E_IN0, D=>switches, Q=> mux0);
f1: Multiplexer port map(A=>mux0, B=>mux1, C=>mux2, D=>mux3, SM=>SM0, BUS1=>BUS0);
f2: my_rege port map(clock=>clock, resetn => resetn, sclr => sclrR, E=>E_R1, D=>BUS0, Q=>mux3);
f3: my_rege port map(clock=>clock, resetn => resetn, sclr => sclrR, E=>E_R0, D=>BUS0, Q=>mux2);
f4: my_rege port map(clock=>clock, resetn => resetn, sclr => sclrR, E=>E_A0, D=> BUS0, Q=>ALU0);
f5: ALU port map(sel=>op0, A=>ALU0, B=>BUS0, G=>G0);
f6: my_rege port map(clock=>clock, resetn => resetn, sclr => sclrR, E=>E_G0, D=>G0, Q=>mux1);
f7: my_rege port map(clock=>clock, resetn => resetn,  sclr => sclrR, E=>E_OUT0, D=>BUS0, Q=>LEDS);
f8: ControlCircuit port map(clock=>clock,w=>w,IR=>IR,resetn=>resetn,
op=>op0,SM=>SM0,E_A=>E_A0,E_G=>E_G0,E_IN=>E_in0,E_OUT=>E_OUT0,
done=>done,E_R0=>E_R0, E_R1=>E_R1);


end Behavioral;