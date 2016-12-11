library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity ShiftRegister is
	port(
		R : in STD_LOGIC;
		clk : in STD_LOGIC;
		q_out : out STD_LOGIC_VECTOR(3 downto 0) 
		);	 
end ShiftRegister;

architecture structural of ShiftRegister is		
	component DFF
		port ( 
			D : in STD_LOGIC;
			clk : in STD_LOGIC;
			R : in STD_LOGIC;
			S : in STD_LOGIC;
			Q : out STD_LOGIC);
	end component ;		   
	signal Q_temp: STD_LOGIC_VECTOR(3 downto 0);
	
begin
	first:DFF  port map ( D => Q_temp(3), clk => clk, R => '1', S => R, Q => Q_temp(0) );
	
	d_ff:for i in 0 to 2 	
		generate d_ff:DFF port map ( D => Q_temp(i), clk => clk, R => R, S => '1', Q => Q_temp(i+1) );	
	end generate d_ff;
	
	q_out <= q_temp;
	
end structural;  