
library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity DFF is
	port(	 D : in STD_LOGIC;
		clk : in STD_LOGIC;
		R : in STD_LOGIC;
		S : in STD_LOGIC;
		Q : out STD_LOGIC
		);
end DFF;

architecture behavioral of DFF is
begin
	flip_flop:process(clk, r, s) is 
		variable p :std_logic_vector(0 to 1);
	begin
		p := r & s;
		case p is
			when "00" => Q <= 'X'; 
			when "01" => Q <= '0';
			when "10" => Q <= '1';
			when "11" =>
				if( rising_edge(clk) ) then 
					Q <= D;
			end if;	
			when others => null;
		end case;				
	end	process;
end behavioral;