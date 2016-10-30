
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity reverse_reg is
	port(
		clk : in STD_LOGIC;
		DL : in STD_LOGIC;
		DR : in STD_LOGIC;
		S0 : in STD_LOGIC;
		S1 : in STD_LOGIC;
		R : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR(3 downto 0);
		Q : out STD_LOGIC_VECTOR(3 downto 0)
		);
end reverse_reg;


architecture behavioural of reverse_reg is
	signal code : STD_LOGIC_VECTOR(1 downto 0);
	signal q_temp : STD_LOGIC_VECTOR(3 downto 0);
begin
	
	code <= S0 & S1;
	
	main:process( clk, R )
	begin
		if( R = '0') then
			q_temp <= (others => '0');  		
		elsif ( rising_edge(clk) ) then
			
			case code is
				when "00" => null;
				when "01" => q_temp <= q_temp(2 downto 0) & DL;
				when "10" => q_temp <= DR & q_temp(3 downto 1 );
				when "11" => q_temp <= D;
				when others => null;
			end case;
			
		end if;	
	end process main;	
	
	Q <= q_temp;
	
end behavioural;
