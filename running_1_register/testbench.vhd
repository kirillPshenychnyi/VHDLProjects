
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity testbench is
end testbench;

architecture archie of testbench is	
	component ShiftRegister
		port  (
			R : in STD_LOGIC;
			clk : in STD_LOGIC;
			q_out : out STD_LOGIC_VECTOR(3 downto 0)
			);	
	end component;	 
	
	signal r, clk   : STD_LOGIC;
	signal q_out : STD_LOGIC_VECTOR(3 downto 0);
begin	
	r <= '0', '1' after 5ns;
	
	top_unit:ShiftRegister port map(R=>r, clk => clk, q_out => q_out);
	
	clk_gen: process is
	begin
		clk<='0', '1' after 5ns;
		wait for 10 ns;
	end process clk_gen; 	
end archie;	
