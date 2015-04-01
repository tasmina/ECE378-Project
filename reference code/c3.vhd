library ieee;
use ieee.std_logic_1164.all;

entity C3 is --desloc_1_bit_dir
	generic ( N : natural := 8 );
	port ( 
		clk : in std_logic;
		enable : in std_logic;
		reset : in std_logic;
		A: in std_logic_vector((N - 1) downto 0);
		F : out std_logic_vector((N - 1) downto 0)
	);
end entity;

architecture rtz of C3 is
	signal sr: std_logic_vector ((N - 1) downto 0); -- Registrador de N bits
	begin
		process(clk, reset)
			begin
				if reset = '0' then
					sr <= (others => '0');
				elsif rising_edge(clk) then
					if enable = '1' then
						sr((N - 2) downto 0) <= A((N - 1) downto 1);
						sr(N-1) <= '0';
					end if;
				end if;
				F <= sr;
		end process;
end rtz	;