LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.all;

ENTITY tb_keyboard IS
END tb_keyboard;
 
ARCHITECTURE behavior OF tb_keyboard IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT keyboard_binary
    port(
        keyval1, keyval2, keyval3: in std_logic_vector(7 downto 0);
        bin: out std_logic_vector(7 downto 0)
    );
    END COMPONENT;
    

--Inputs
signal keyval1,keyval2, keyval3 : std_logic_vector(7 downto 0) := (others => '0');

--Outputs
signal bin : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: keyboard_binary PORT MAP (
          keyval1 => keyval1,
          keyval2 => keyval2,
          keyval3 => keyval3,
          bin => bin
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
      keyval1 <= X"45"; keyval2 <= X"45"; keyval3 <= X"25";
		
      wait;
   end process;

END;
