-- Example 3: Debounce pushbuttons
library IEEE;
use IEEE.std_logic_1164.all;

entity debounce4 is
	  port (
		cclk, clr: in std_logic;
		inp: in std_logic_vector(3 downto 0);
		outp: out std_logic_vector(3 downto 0)
	  );
end debounce4;

architecture debounce4 of debounce4 is
signal delay1, delay2, delay3: std_logic_vector(3 downto 0);
begin
    process(cclk, clr)
    begin
       	if clr = '1' then
    		delay1 <= "0000";
	   	    	delay2 <= "0000";
	   		delay3 <= "0000"; 
		elsif cclk'event and cclk='1' then
	   		delay1 <= inp;
	   		delay2 <= delay1;
	   		delay3 <= delay2;
		end if;
    end process;

    outp <= delay1 and delay2 and delay3;
end debounce4;
