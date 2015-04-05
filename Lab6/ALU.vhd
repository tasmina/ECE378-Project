----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:08:33 04/01/2015 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( sel : in  STD_LOGIC_VECTOR (3 downto 0);
           A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           G : out  STD_LOGIC_VECTOR (3 downto 0));
end ALU;

architecture Behavioral of ALU is
begin
	process (A,B,sel)
	begin
		case sel is
			when "0000" => G <= A;
			when "0001" => G <= A + 1;
			when "0010" => G <= A - 1;
			when "0011" => G <= B;
			when "0100" => G <= B + 1;
			when "0101" => G <= B - 1;
			when "0110" => G <= A + B;
			when "0111" => G <= A - B;
			when "1000" => G <= not A;
			when "1001" => G <= not B;
			when "1010" => G <= A and B;
			when "1011" => G <= A or B;
			when "1100" => G <= A nand B;
			when "1101" => G <= A nor B;
			when "1110" => G <= A xor B;
			when others => G <= A xnor B;
end case;
end process;



end Behavioral;


