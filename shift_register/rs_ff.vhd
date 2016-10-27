library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity RS_FF is
	port(
		R : in STD_LOGIC;
		S : in STD_LOGIC;
		clk : in STD_LOGIC;
		Q : out STD_LOGIC
		);
end RS_FF;

--}} End of automatically maintained section

architecture Behavioural of RS_FF is  
	signal q_temp : STD_LOGIC;
begin  
	
	ff:process( clk )
	begin
		if( rising_edge(clk) ) then
			if( R = '0' and S = '0' ) then
				q_temp <= q_temp;
			elsif( S = '0' and R = '1' ) then
				q_temp <= '0';
			elsif ( S = '1' and R = '0' ) then
				q_temp <= '0';
			else 
				q_temp <= q_temp;  
			end if;
		end if;
	end process ff;
	
	Q <= q_temp;
	
end Behavioural;
