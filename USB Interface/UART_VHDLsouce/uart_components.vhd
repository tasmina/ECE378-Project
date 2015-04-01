-- A package containing component declarations
-- for uart Examples 33-34
library IEEE;
use IEEE.std_logic_1164.all;

package uart_components is
	
	component clkdiv
	port(
		mclk : in std_logic;
		clr : in std_logic;
		clk25 : out std_logic;
		clk190 : out std_logic);
	end component;

	component debounce4
	port(
		cclk : in std_logic;
		clr : in std_logic;
		inp : in std_logic_vector(3 downto 0);
		outp : out std_logic_vector(3 downto 0));
	end component;

	component clock_pulse
	port(
		inp : in std_logic;
		cclk : in std_logic;
		clr : in std_logic;
		outp : out std_logic);
	end component;

	component gcd3
	port(
		clk : in std_logic;
		clr : in std_logic;
		go : in std_logic;
		xin : in std_logic_vector(3 downto 0);
		yin : in std_logic_vector(3 downto 0);
		done : out std_logic;
		gcd : out std_logic_vector(3 downto 0));
	end component;

	component x7segb
	port(
		x : in std_logic_vector(15 downto 0);
		cclk : in std_logic;
		clr : in std_logic;
		a_to_g : out std_logic_vector(6 downto 0);
		an : out std_logic_vector(3 downto 0));
	end component;

component brom8x16
	port (
	addr: IN std_logic_VECTOR(2 downto 0);
	clk: IN std_logic;
	dout: OUT std_logic_VECTOR(15 downto 0));
end component;

	component counter
	generic(
		N : INTEGER := 8);
	port(
		clr : in std_logic;
		clk : in std_logic;
		q : out std_logic_vector(N-1 downto 0));
	end component;

	component uart_tx
	port(
		clk : in std_logic;
		clr : in std_logic;
		tx_data : in std_logic_vector(7 downto 0);
		ready : in std_logic;
		tdre : out std_logic;
		TxD : out std_logic);
	end component;

	component test_tx_ctrl
	port(
		clk : in std_logic;
		clr : in std_logic;
		go : in std_logic;
		tdre : in std_logic;
		ready : out std_logic);
	end component;

	component uart_rx
	port(
		RxD : in std_logic;
		clk : in std_logic;
		clr : in std_logic;
		rdrf_clr : in std_logic;
		rdrf : out std_logic;
		FE : out std_logic;
		rx_data : out std_logic_vector(7 downto 0));
	end component;

	component test_rx_ctrl
	port(
		clk : in std_logic;
		clr : in std_logic;
		rdrf : in std_logic;
		rdrf_clr : out std_logic);
	end component;
	
end uart_components; 
  
  
