-- Example 34: UART receive module
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity uart_rx is
	 port(
		 RxD : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 clr : in STD_LOGIC;
		 rdrf_clr : in STD_LOGIC;
		 rdrf : out STD_LOGIC;
		 FE : out STD_LOGIC;
		 rx_data : out STD_LOGIC_VECTOR(7 downto 0)
	     );
end uart_rx;

architecture uart_rx of uart_rx is
type state_type is (mark, start, delay, shift, stop);
signal state: state_type;
signal rxbuff: STD_LOGIC_VECTOR (7 downto 0);
signal baud_count: STD_LOGIC_VECTOR (11 downto 0);
signal bit_count: STD_LOGIC_VECTOR (3 downto 0);
signal rdrf_set, fe_set, cclr, cclr8, rxload: STD_LOGIC;
constant bit_time: STD_LOGIC_VECTOR (11 downto 0) := X"A28";
constant half_bit_time: STD_LOGIC_VECTOR (11 downto 0) := X"514"; 

begin

uart2: process(clk, clr, rdrf_clr)		
  begin
    if clr = '1' then
		state <= mark;
		rxbuff <= "00000000";
		baud_count <= X"000";
		bit_count <= "0000";
		rdrf <= '0';
		FE <= '0';
    elsif rdrf_clr = '1' then
		rdrf <= '0';
    elsif (clk'event and clk = '1') then
	case state is		  
          when mark =>			-- wait for start bit
   	        baud_count <= X"000";
	        bit_count <= "0000";
            if RxD = '1' then  		
            	 state <= mark;		  
            else
		       FE <= '0';
            	 state <= start;	 	--   go to start
            end if; 
		  when start =>				-- check for start bit
         	if baud_count >= half_bit_time then  	
				baud_count <= X"000";
            	state <= delay;	 	
	     	else 
				baud_count <= baud_count + 1;
            	state <= start;	 	
         	end if;
 		  when delay =>				
         	if baud_count >= bit_time then  	
				baud_count <= X"000";
				if bit_count < 8 then	
		   			state <= shift;		
				else					
            	   	state <= stop;	 	
				end if;
	   		else 
				baud_count <= baud_count + 1;
            	state <= delay;	 	
         	end if;
	 	  when shift =>				-- get next bit
	   		rxbuff(7) <= RxD;
	   		rxbuff(6 downto 0) <= rxbuff(7 downto 1);
	   		bit_count <= bit_count + 1;
	   		state <= delay;
      	  when stop =>					
	   		rdrf <= '1';
	   		if RxD = '0' then  		
          		FE <= '1';		  	
	   		else 
          		FE <= '0';		  	
	   		end if;
 	   		state <= mark;			
     	end case;			   
  	end if;
end process uart2; 
  
rx_data <= rxbuff;
 
end uart_rx;
