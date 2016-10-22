
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MX is
	port(
		En : in STD_LOGIC;
		DI : in STD_LOGIC_VECTOR(0 to 15);
		A : in STD_LOGIC_VECTOR(0 to 3);
		Q : out STD_LOGIC
		);
end MX;

--}} End of automatically maintained section

architecture Structural of MX is
	component not_gate
		port(
			i : in STD_LOGIC;
			o : out STD_LOGIC
			);
	end component;	 
	
	component and2_gate
		port(
			i0,i1 : in STD_LOGIC;
			o : out STD_LOGIC
			);	
	end component;
	
	component and4_gate
		port(
			i0, i1, i2, i3 : in STD_LOGIC;
			o : out STD_LOGIC
			);
	end component;			
	
	component or4_gate
		port(
			i0, i1, i2, i3 : in STD_LOGIC;
			o : out STD_LOGIC
			);
	end component;	
	
begin
	
end Structural;
