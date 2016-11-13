library IEEE;

use IEEE.STD_LOGIC_1164.all; 
use ieee.std_logic_unsigned.all;

entity operational_unit is port(
		
		clk : in STD_LOGIC; reset : in STD_LOGIC;
		d1 : in STD_LOGIC_VECTOR(7 downto 0); 
		d2 : in STD_LOGIC_VECTOR(7 downto 0); 
		y : in STD_LOGIC_VECTOR(1 to 9);
		
		x	: out std_logic_vector(1 to 2);
		r : out STD_LOGIC_VECTOR(15 downto 0) );
	
end operational_unit;


architecture behavioral of operational_unit is
	
	signal a,b:std_logic_vector(7 downto 0); 
	signal c:std_logic_vector(8 downto 0);
	signal cnt:std_logic_vector(2 downto 0);
begin
	
	process(clk,reset) is begin
		
		if reset='0' then 
			a<=(others=>'0'); 
			b<=(others=>'0'); 
			c<=(others=>'0');
			cnt<="111";
			
		elsif rising_edge (clk) then
			
			if y(1)='1' then 
				a<=d1;
			end if;
			
			if y(2)='1' then 
				b<=d2;
				
			elsif y(6)='1' then
				b<=c(0)&b(7 downto 1);
			end if;
			
			if y(3)='1' then 
				c<=(others=>'0'); 
			elsif y(5)='1' then
				c<=c+a;			
			elsif y(7)='1' then 
				c<='0'&c(8 downto 1); 
			end if;
			
			if y(4)='1' then
				cnt<="111"; 
			elsif y(8)='1' then 
				cnt<=cnt-1; 
			end if;
			
		end if;
	end process; 
	
	r<=c(7 downto 0)&b when y(9)='1' else (others=>'Z');
	
	x(1)<=b(0);
	
	x(2)<='1' when cnt="111" else '0';
	
end behavioral;