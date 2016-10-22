
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity and4_gate is
	port(
		 i0 : in STD_LOGIC;
		 i1 : in STD_LOGIC;	
		 i2 : in STD_LOGIC;
		 i3 : in STD_LOGIC;
		 o : out STD_LOGIC
	     );
end and4_gate;

--}} End of automatically maintained section

architecture and4_gate of and4_gate is
signal c0, c1 : STD_LOGIC;
component and2_gate
	port (
	i0, i1 : in STD_LOGIC;
	o : out STD_LOGIC	
		);
end component;

begin
	
	and0:and2_gate port map( i0 => i0, i1 => i1, o => c0 );
	and1:and2_gate port map( i0 => i2, i1 => i3, o => c1 );
	
	o <= c0 and c1;
	
end and4_gate;
