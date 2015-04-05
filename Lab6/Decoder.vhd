----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:16:29 04/03/2015 
-- Design Name: 
-- Module Name:    Decoder - Behavioral 
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

entity Decoder is
    Port ( E : in  STD_LOGIC;
           w : in  STD_LOGIC;
           E_R0 : out  STD_LOGIC;
			  E_R1 : out STD_LOGIC);
end Decoder;

architecture Behavioral of Decoder is
signal ERS: std_logic_vector (1 downto 0);
begin
	process(E,w)
	begin
		if E = '1' then
			if w = '0' then
			ERS <= "01";
			else ERS <="10";
			end if;
		else ERS <= "00";
		end if;
	end process;
E_R0<=ERS(0);
E_R1<=ERS(1);
--			case w is
--				when '0' => f1 <= '1', f2<='0';
--				when others => f1 <= '0', f2<='1';
--			end case;
--		else f1<=f1,f2<=f2;
--		end if;
--	end process;
	--Process(f)
	--if f

--			if RX ='0' then E_R00 <= '1', E_R10 <= '0';
--			else E_R10 <='1', E_R00 <= '0';
--		end if;

		

end Behavioral;

