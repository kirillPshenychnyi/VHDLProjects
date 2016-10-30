library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity nor2_gate is
	 port(
		 i0 : in STD_LOGIC;
		 i1 : in STD_LOGIC;
		 f : out STD_LOGIC
	     );
end nor2_gate;
									  

architecture functional of nor2_gate is 	
begin

	f <= i0 nor i1;

end functional;
