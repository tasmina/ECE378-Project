-- Example 34b: Controller for Testing UART receiver
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity test_rx_ctrl is
	 port(
		 clk : in STD_LOGIC;
		 clr : in STD_LOGIC;
		 rdrf : in STD_LOGIC;
		 rdrf_clr : out STD_LOGIC
	     );
end test_rx_ctrl;

architecture test_rx_ctrl of test_rx_ctrl is
type state_type is (wtrdrf, load);
signal state: state_type;

begin 
ctrl: process(clk, clr, rdrf)		
  begin
    if clr = '1' then
		state <= wtrdrf;
		rdrf_clr <= '0';
    elsif (clk'event and clk = '1') then
	case state is		  
      	   when wtrdrf =>			
		rdrf_clr <= '0';
         	if rdrf = '0' then  		
            	   state <= wtrdrf;		
         	else
            	   state <= load;	 	
         	end if;      
     	   when load =>				
		rdrf_clr <= '1';
            	state <= wtrdrf;	 	
        end case;			   
    end if;
  end process ctrl; 
end test_rx_ctrl;
