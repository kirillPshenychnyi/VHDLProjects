library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity shift_register is
	port(
		c1 : in STD_LOGIC;
		c2 : in STD_LOGIC;
		Dr : in STD_LOGIC;
		L : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(3 downto 0);
		Q : out STD_LOGIC_VECTOR(3 downto 0)
		);
end shift_register;

architecture behavioural of shift_register is
	signal q_temp : STD_LOGIC_VECTOR(3 downto 0);
begin
	
	main:process ( L, c1, c2 ) begin
		if( L = '1' and falling_edge(c1) ) then
			q_temp <= D;
		elsif ( L = '0' and falling_edge(c2) ) then	
			q_temp <= Dr & q_temp(3 downto 1);
			
		end if;
	end process main; 
	
		Q <= q_temp;
end behavioural;
