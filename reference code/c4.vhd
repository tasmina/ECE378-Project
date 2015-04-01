library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity C4 is --desloc_1_bit_esq
	generic ( N : natural := 8 );
	port ( 
		clk : in std_logic;
		enable : in std_logic;
		reset : in std_logic;
		A: in std_logic_vector((N - 1) downto 0);
		F : out std_logic_vector((N - 1) downto 0);
		LG01C4: out std_logic_vector(1 downto 0)
	);
end entity;

architecture rtl of C4 is
	signal sr: std_logic_vector ((N - 1) downto 0); -- Registrador de N bits
	begin
		process(clk, reset)
			begin
				if reset = '0' then
					sr <= (others => '0');					
				elsif (rising_edge(clk)) then
					if enable = '1' then						
						sr((N - 1) downto 1) <= A((N - 2) downto 0);
						sr(0) <= '0';
					end if;
				end if;					
				F <= sr;
				if A > "0111111" OR A < "10000001" then
					LG01C4(1) <= '1';
				end if;
				LG01C4(0) <= '0';
		end process;
end rtl;

