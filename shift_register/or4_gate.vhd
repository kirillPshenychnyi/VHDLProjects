
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity or4_gate is
	port(
		 i0 : in STD_LOGIC;
		 i1 : in STD_LOGIC;	
		 i2 : in STD_LOGIC;
		 i3 : in STD_LOGIC;
		 o : out STD_LOGIC
	     );
end or4_gate;
									
architecture or4_gate of or4_gate is
begin
	
	o <= i0 or i1 or i2 or i3;
	
end or4_gate;
