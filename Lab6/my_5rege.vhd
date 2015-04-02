----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:10:22 04/01/2015 
-- Design Name: 
-- Module Name:    my_5rege - Behavioral 
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
---------------------------------------------------------------------------
-- This VHDL file was developed by Daniel Llamocca (2013).  It may be
-- freely copied and/or distributed at no cost.  Any persons using this
-- file for any purpose do so at their own risk, and are responsible for
-- the results of such use.  Daniel Llamocca does not guarantee that
-- this file is complete, correct, or fit for any particular purpose.
-- NO WARRANTY OF ANY KIND IS EXPRESSED OR IMPLIED.  This notice must
-- accompany any copy of this file.
--------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- N-bit Register
-- E = '1', sclr = '0' --> Input data 'D' is copied on Q
-- E = '1', sclr = '1' --> Q is cleared (0)
entity my_5rege is
   generic (N: INTEGER:= 5);
	port ( clock: in std_logic;
	       E: in std_logic; -- sclr: Synchronous clear
			 D: in std_logic_vector (N-1 downto 0);
	       Q: out std_logic_vector (N-1 downto 0));
end my_5rege;

architecture Behavioral of my_5rege is

	signal Qt: std_logic_vector (N-1 downto 0);
	
begin

	process (clock)
	begin
	--	if resetn = '0' then
	--		Qt <= (others => '0');
		if (clock'event and clock = '1') then
			if E = '1' then	
		--		if sclr = '1' then
		--			Qt <= (others => '0');
		--		else
					Qt <= D;
				end if;
			end if;
	--	end if;
		
	end process;

	Q <= Qt;
end Behavioral;
