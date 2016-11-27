library IEEE;

use IEEE.STD_LOGIC_1164.all;

entity proc is port(		
		clk : in STD_LOGIC; 
		reset : in STD_LOGIC;
		operation: in STD_LOGIC; 
		d1 : in STD_LOGIC_VECTOR(15 downto 0); 
		d2 : in STD_LOGIC_VECTOR(7 downto 0);
		r : out STD_LOGIC_VECTOR(15 downto 0)		
		);
end proc;

architecture proc of proc is component control_unit
		port(
			clk : in std_logic; 
			reset : in std_logic;
			x : in std_logic_vector(0 to 8);
			y : out STD_LOGIC_VECTOR(1 to 24)
			);
	end component; 
	
	component operational_unit port(			
			clk : in std_logic;
			reset : in std_logic;	
			d1 : in std_logic_vector(15 downto 0); 
			d2 : in std_logic_vector(7 downto 0); 
			y  : in STD_LOGIC_VECTOR(1 to 24);
			x  : out STD_LOGIC_VECTOR(0 to 8);			
			r : out std_logic_vector(15 downto 0)
			); 
	end component;
	
	signal y : std_logic_vector(1 to 24); 
	signal x : std_logic_vector(0 to 8);
	signal nclk:std_logic;
	
begin
	nclk<=not clk;
	x(0) <= operation;
	dd1:control_unit port map (clk,reset,x,y);
	
	dd2:operational_unit port map (clk => nclk ,reset => reset,d1 => d1, d2 =>d2, y=>y, x=>x, r =>r );
	
end proc;