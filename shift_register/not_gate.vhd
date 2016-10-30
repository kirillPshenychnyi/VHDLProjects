
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity not_gate is
	 port(
		 i : in STD_LOGIC;
		 o : out STD_LOGIC
	     );
end not_gate;

--}} End of automatically maintained section

architecture not_gate of not_gate is
begin

	 o <= not i;

end not_gate;
