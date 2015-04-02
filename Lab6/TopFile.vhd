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
    Port ( switches : in STD_LOGIC_VECTOR;
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
				SM : in  STD_LOGIC_VECTOR (2 downto 0);
				BUS1 : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component my_rege
	generic (N: INTEGER:= 4);
	port ( clock: in std_logic;
	       E: in std_logic; -- sclr: Synchronous clear
			 D: in std_logic_vector (N-1 downto 0);
	       Q: out std_logic_vector (N-1 downto 0));
	end component;	 

signal mux0, mux1, mux2, mux3, SM, BUS1, ALU0, G0: std_logic;
begin
f0: my_rege port map(clock=>clock, E=>E_in, D=>switches, Q=> mux1);
f1: Multiplexer port map(A=>mux0, B=>mux1, C=>mux2, D=>mux3, SM=>SM, BUS1=>BUS1);
f2: my_rege port map(clock=>clock, E=>E_R1, D=>BUS1, Q=>mux3);
f3: my_rege port map(clock=>clock, E=>E_R0, D=>BUS1, Q=>mux2);
f4: my_rege port map(clock=>clock, E=>E_A, D=> BUS1, Q=>ALU0);
f5: ALU port map(sel=>op, A=>ALU0, B=>BUS1, G=>G0);
f6: my_rege port map(clock=>clock, E=>E_G, D=>G0, G=>mux1);
f7: my_rege port map(clock=>clock, E=>E_OUT, D=>BUS1, G=>LEDS);
f8: Control port map(
end Behavioral;

