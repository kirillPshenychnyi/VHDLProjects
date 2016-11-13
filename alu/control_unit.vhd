library IEEE;

use IEEE.STD_LOGIC_1164.all;

entity control_unit is port(	
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		x : in std_logic_vector(1 to 2);
		y : out STD_LOGIC_VECTOR(1 to 9)
		);
	
end control_unit;

architecture behavioral of control_unit is 
	type tstate is (s0,s1,s2,s3,s4); 
	signal next_state,state:tstate;
	
begin
	
	process(reset, clk) 
	begin
		if( reset = '0') then 
			state <= s0;
		elsif (rising_edge(clk)) then 
			state <= next_state;
		end if;			
	end process;
	
	process(state, x)
	begin
		case state is 
			when s0 => next_state <= s1;
			when s1 => 
				if(x(1) = '1') then 
					next_state <= s2;
				else 
					next_state <= s3;
			end if;
			when s2 => next_state <= s3;
			when s3 =>
				if(x(2) = '1') then 
					next_state <= s4;
				elsif( x(1) = '1') then 
					next_state <= s2;
				else
					next_state <= s3;
			end if;	
			when s4 => next_state <= s0;
		end case;	
	end process;	
		
	y <= 
	     ( 1 => '1', 2 => '1', 3 => '1', 4 => '1', others => '0' ) when state = s1
	else ( 5 => '1', others => '0') when state = s2
	else ( 6 => '1', 7 => '1', 8 => '1', others => '0') when state = s3
	else ( 9 => '1', others => '0') when state = s4
	else ( others => '0');
	
end behavioral;