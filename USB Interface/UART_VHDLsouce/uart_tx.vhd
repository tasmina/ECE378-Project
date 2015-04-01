-- Example 33a: UART transmitter
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity uart_tx is
	 port(
		 clk : in STD_LOGIC;
		 clr : in STD_LOGIC;
		 tx_data : in STD_LOGIC_VECTOR(7 downto 0);
		 ready : in STD_LOGIC;
		 tdre : out STD_LOGIC;
		 TxD : out STD_LOGIC
	     );
end uart_tx;

architecture uart_tx of uart_tx is

type state_type is (mark, start, delay, shift, stop);

signal state: state_type;
signal txbuff: STD_LOGIC_VECTOR (7 downto 0);
signal baud_count: STD_LOGIC_VECTOR (11 downto 0);
signal bit_count: STD_LOGIC_VECTOR (3 downto 0);

constant bit_time: STD_LOGIC_VECTOR (11 downto 0) := X"A28";  --9600 baud


begin

uart2: process(clk, clr, ready)		
  begin
    if clr = '1' then
	state <= mark;
	txbuff <= "00000000";
	baud_count <= X"000";
	bit_count <= "0000";
	TxD <= '1';
elsif (clk'event and clk = '1') then
	  case state is		  
      	when mark =>			-- wait for ready
			bit_count <= "0000";
			tdre <= '1';
         	if ready = '0' then  		
               state <= mark;
			   txbuff <= tx_data;
         	else
			   baud_count <= X"000";
               state <= start;	 	--   go to start
         	end if;      
      when start =>	-- output start bit  	
			baud_count <= X"000";
			TxD <= '0';
			tdre <= '0';
            state <= delay;	--   go to delay
 	when delay =>		-- wait bit time
			tdre <= '0';
 	      if baud_count >= bit_time then  	
			   baud_count <= X"000";
			   if bit_count < 8 then	-- if not done
				state <= shift;	--   go to shift
			   else			-- else
 		           	state <= stop;	--   go to stop
			   end if;
			else 
			   baud_count <= baud_count + 1;
 		         state <= delay;	 	--   stay in delay
 		      end if; 
		when shift =>		-- get next bit
			tdre <= '0';
		      TxD <= txbuff(0);
     	      txbuff(6 downto 0) <= txbuff(7 downto 1);
	 	      bit_count <= bit_count + 1;
		      state <= delay;

 		when stop =>		-- stop bit
		   tdre <='0';
		   TxD <= '1';
          if baud_count >= bit_time then  	
			 baud_count <= X"000";
 		 state <= mark;	
		    else 
			 baud_count <= baud_count + 1;
             state <= stop;	 	
          end if;			  
      end case;			   
    end if;
  end process uart2; 
end uart_tx;
