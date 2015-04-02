----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:08:05 04/01/2015 
-- Design Name: 
-- Module Name:    ControlCircuit - Behavioral 
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

entity ControlCircuit is
    Port ( clock : in STD_LOGIC;
	        w : in  STD_LOGIC;
           IR : in  STD_LOGIC_VECTOR (4 downto 0);
           op : out  STD_LOGIC_VECTOR (3 downto 0);
           SM : out  STD_LOGIC;
           E_A : out  STD_LOGIC;
           E_G : out  STD_LOGIC;
           E_IN : out  STD_LOGIC;
           E_OUT : out  STD_LOGIC;
           done : out  STD_LOGIC;
           E_RO : out  STD_LOGIC;
           E_R1 : out  STD_LOGIC);
end ControlCircuit;

architecture Behavioral of ControlCircuit is

component my_5rege
   generic (N: INTEGER:= 5);
	port ( clock: in std_logic;
	       E: in std_logic; -- sclr: Synchronous clear
			 D: in std_logic_vector (N-1 downto 0);
	       Q: out std_logic_vector (N-1 downto 0));
   end component;
signal I_IR: std_logic; 
signal IRq: std_logic_vector (4 downto 0);
begin
f0: my_5rege port map(clock=>clock, E=>I_IR, D=>IR, Q=>IRq);

end Behavioral;

