
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity JK_FF is
	 port(
		 J : in STD_LOGIC;
		 K : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 R : in STD_LOGIC;
		 Q : out STD_LOGIC;
		 nQ : out STD_LOGIC
	     );
end JK_FF;

architecture JK_FF of JK_FF is
begin

	process( clk, R ) is
		variable Qtemp : STD_LOGIC;
	begin
	    if R = '0' then
		  	Qtemp:= '0';
		elsif falling_edge(clk) then
			if J = '0' and K = '0'
			then 
				Qtemp:= Qtemp;
			elsif J = '0' and K = '0' then
				Qtemp:= Qtemp;
			elsif J = '0' and K = '1' then
				Qtemp:= '0';
			elsif J = '1' and K = '0' then
				Qtemp:= '1';	
			elsif J = '1' and K = '1' then
				Qtemp:= not Qtemp;	
			end if;
	end if;		
	Q <= Qtemp;
	nQ <= not Qtemp;
	end process;
end JK_FF;
