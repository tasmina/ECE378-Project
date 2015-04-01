library ieee;
use ieee.std_logic_1164.all;

entity Registrador8 is 
	port (
		CLK: in std_logic;
		RST: in std_logic;
		EN: in std_logic;
		D: in std_logic_vector(7 downto 0);
		Q: out std_logic_vector(7 downto 0)
	);
end Registrador8;

architecture behv of Registrador8 is
	begin
		process (CLK, RST, D) 
			begin 
				if (RST = '0') then
					Q <= (others =>'0');
				elsif (CLK'event and CLK = '1') then
					if (EN = '1')then --era '0', mas c/ fsm deve ser '1'
						Q <= D;
					end if;
				end if; 
		end process;
end behv;