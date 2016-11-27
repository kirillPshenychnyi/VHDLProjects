library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use ieee.std_logic_unsigned.all;

entity operational_unit is port(	
		clk : in STD_LOGIC; reset : in STD_LOGIC;
		d1 : in STD_LOGIC_VECTOR(15 downto 0); 
		d2 : in STD_LOGIC_VECTOR(7 downto 0); 
		y : in STD_LOGIC_VECTOR(1 to 24);
		x : out std_logic_vector(0 to 8);
		r : out STD_LOGIC_VECTOR(15 downto 0) );
	
end operational_unit;


architecture behavioral of operational_unit is
	
	signal b:std_logic_vector(8 downto 0); 
	signal a:std_logic_vector(16 downto 0); 
	signal c:std_logic_vector(7 downto 0);
	signal cnt:std_logic_vector(3 downto 0); 
	signal TgsA, TgsB, TgA, IRQ1, IRQ2 : STD_LOGIC;
	
begin
	
	process(clk,reset) is begin
		
		if reset='0' then 
			a<=(others=>'0'); 
			b<=(others=>'0'); 
			c<=(others=>'0');  
			r<= (others=>'Z');
			TgA  <= '0';
			TgsA <= '0';
			TgsB <= '0';
			IRQ1 <='0';
			IRQ2 <= '0';
			cnt<="1000";
			
		elsif rising_edge (clk) then
			
			if y(1)='1' then 
				a(7 downto 0)<=d1(7 downto 0);	  
			elsif y(10) = '1' then 
				A <= '0' & d1;	
			end if;
			
			if y(2)='1' then 
				b(7 downto 0) <= d2;
			elsif y(11) = '1' then
				b <= '0' & d2;
			end if;
				
			if y(6)='1' then
				b(7 downto 0)<=c(0)&b(7 downto 1);
			end if;

			if y(3)='1' then 
				c<=(others=>'0'); 
			elsif y(5)='1' then
				c<=c+a(7 downto 0);			
			elsif y(7)='1' then 
				c<='0'&c(7 downto 1); 
			end if;
			
			if y(4)='1' then
				cnt<="1000"; 
			elsif y(8)='1' then 
				cnt<=cnt-1; 
			end if;
			
			if y(12) = '1' then 
				TgSA <= A(15);
			end if;
			
			if y(13) = '1' then 
				TgSB <= B(7);
			end if;
			
			if y(14) = '1' then 
				A(15 downto 0) <= not A(15 downto 0) + 1;
			end if;
			
			if y(15) = '1' then 
				B(7 downto 0) <= not B(7 downto 0) + 1;
			end if;
			
			if y(16) = '1' then 
				A(16 downto 8) <= A(16 downto 8) + not B + 1;
			end if;
			
			if y(17) = '1' then
				IRQ1 <= '1';
			end if;	
			
			if y(18) = '1' then
				IRQ2 <= '1';
			end if;
			
			if y(19) = '1' then
				TgA <= A(16);			
			end if;
			
			if y(20) = '1' then
				A <= A(15 downto 0) & '0';
			elsif y(21) = '1' then
				A(16 downto 8) <= A(16 downto 8) + B(8 downto 0);
			end if;	   
											
			if y(22) = '1' then
				C <= C(6 downto  0) & not A(16);
			end if;
			
			if y(9) = '1' then
				r <= c & b(7 downto 0);	
			elsif y(23) = '1' then
				R(7 downto 0) <= C;
			elsif y(24) = '1' then
				R(7 downto 0) <= not C + 1;
			end if;	
						
		end if;
	end process; 
	
	
	x(1) <= b(0);
	x(2) <='1' when cnt="0000" else '0';									
	x(3) <= '1' when b = "000000000" else '0';
	x(4) <= TgSA;
	x(5) <= TgSB;
	x(6) <= A(16);  
	x(7) <= TgA;
	x(8) <= TgSA xor TgSB;
	
end behavioral;