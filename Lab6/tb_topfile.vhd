library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_topfile is
end tb_topfile;

architecture behavior of tb_topfile is

--Component Declaration for UUT

component topfile is

    Port ( switches : in STD_LOGIC_VECTOR(3 downto 0);
	        resetn : in STD_LOGIC;
	        w : in  STD_LOGIC;
			  clock : in STD_LOGIC;
           IR : in  STD_LOGIC_VECTOR (4 downto 0);
           done : out  STD_LOGIC;
           LEDS : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

--Inputs
signal resetn, w, clock : std_logic := '0';
signal switches: std_logic_vector(3 downto 0) := (others => '0');
signal IR : std_logic_vector(4 downto 0) := (others => '0');

--Outputs
signal done : std_logic;
signal LEDS : std_logic_vector(3 downto 0);

--Clock period definition
constant T : time := 10 ns;

begin
    --Instantiate the UUT
    uut: topfile port map(switches => switches, resetn => resetn, w => w, clock => clock, IR => IR, done => done, LEDS => LEDS);
    
    --Clock process definition
    clock_process :process
    begin
        clock <= '0'; wait for T/2;
        clock <= '1'; wait for T/2;
    end process;
    
    --Stimulus process
    stim_proc: process
    begin
        --hold reset state for 100 ns
        resetn <= '0'; wait for 100 ns;
        resetn <= '1';
        w <= '1';
        
        -- load IN (IN <= 0101)
        switches <= "0101"; IR <= "00000"; wait for 100 ns;
        w <= '0';
		  
		  w <= '1';
        -- load R1, IN (R1 <= 0101)
        switches <= "0101"; IR <= "00101"; wait for 100 ns;
        w <= '0';
		  
		  w <= '1';
        -- copy R0, R1 (R0 <= 0101, R1 <= 0101)
        switches <= "0101"; IR <= "01010"; wait for 100 ns;
        w <= '0';
		  
		  w <= '1';
        -- inc R1 (R1 <= 0110)
        switches <= "0101"; IR <= "11001"; wait for 100 ns;
        w <= '0';
		  
		  w <= '1';
        -- xor R0, R1 (R0 <= 0101 xor 0110 = 0011)
        switches <= "0101"; IR <= "10110"; wait for 100 ns;
        w <= '0';
		  
		  w <= '1';
        -- add R0, R1 (R0 <= 0011 + 0110 = 1001)
        switches <= "0101"; IR <= "01110"; wait for 100 ns;
        w <= '0';
		  
		  w <= '1';
        -- load OUT, R0 (OUT <= 1001)
        switches <= "0101"; IR <= "11100"; wait for 100 ns;
		  w <= '0';
		  
		resetn <= '0';
        
        wait;
    end process;
end;