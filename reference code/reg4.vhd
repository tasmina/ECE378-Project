library ieee;
use ieee.std_logic_1164.all;

entity Registrador4 is 
	port (
		CLK: in std_logic;
		RST: in std_logic;
		EN: in std_logic;
		D: in std_logic_vector(3 downto 0);
		Q: out std_logic_vector(3 downto 0)
	);
end Registrador4;

architecture behv of Registrador4 is
	begin
		process (CLK, RST, D) 
			begin 
				if (RST = '0') then
					Q <= (others =>'0');
				elsif (CLK'event and CLK = '1') then
					if (EN = '1')then --alterado de '0' para '1'
						Q <= D;
					end if;
				end if; 
		end process;
end behv;
