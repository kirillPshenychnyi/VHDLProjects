
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity and2_gate is
	 port(
		 i1 : in STD_LOGIC;
		 i0 : in STD_LOGIC;
		 o : out STD_LOGIC
	     );
end and2_gate;

--}} End of automatically maintained section

architecture and2_gate of and2_gate is
begin

	 o <= i0 and i1;

end and2_gate;
