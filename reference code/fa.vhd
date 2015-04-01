library ieee;
use ieee.std_logic_1164.all;
-- somador completo (FA)
entity FA is
	port (
		a, b, c: in std_logic;
		soma, carry: out std_logic);
	end FA;
architecture FA_beh of FA is
begin
	soma <= (a xor b) xor c;
	--carry <= b when ((a xor b) = '0') 
	--else c;
	carry <= (a and b) or (a and c) or (b and c);
end FA_beh;