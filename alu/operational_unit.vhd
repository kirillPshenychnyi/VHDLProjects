library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use ieee.std_logic_signed.all;

entity operational_unit is port(	
		clk : in STD_LOGIC; reset : in STD_LOGIC;
		d1 : in STD_LOGIC_VECTOR(15 downto 0); 
		d2 : in STD_LOGIC_VECTOR(7 downto 0); 
		y : in STD_LOGIC_VECTOR(1 to 23);
		x : out std_logic_vector(0 to 9);
		r : out STD_LOGIC_VECTOR(15 downto 0) );
	
end operational_unit;


architecture behavioral of operational_unit is
	
	signal b:std_logic_vector(8 downto 0); 
	signal a:std_logic_vector(15 downto 0); 
	signal c:std_logic_vector(7 downto 0);
	signal cnt:std_logic_vector(2 downto 0); 
	signal IRQ1, IRQ2, TGs : STD_LOGIC;
	
begin
	
	process(clk,reset) is begin
		
		if reset='0' then 
			a<=(others=>'0'); 
			b<=(others=>'0'); 
			c<=(others=>'0');  
			r<= (others=>'Z');
			cnt<="111";
			
		elsif rising_edge (clk) then
			
			if y(1)='1' then 
				a(7 downto 0)<=d1(7 downto 0);	  
			elsif y(10) = '1' then 
				A <= d1;	
			end if;
			
			if y(2)='1' then 
				b(7 downto 0) <= d2;
			elsif y(11) = '1' then
				b <= d2 & '0';
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
				cnt<="111"; 
			elsif y(8)='1' then 
				cnt<=cnt-1; 
			end if;
			
			if y(12) = '1' then 
				TGs	<= A(15);
			end if;
			
			if y(13) = '1' then
				b <= b(8) & b(8 downto 1);
			end if;	
			
			if y(14) = '1' then
				IRQ1 <= '1';
			end if;
			
			if y(15) = '1' then
				A(15 downto 7) <= A(15 downto 7) + not B + 1;			
			elsif y(16) = '1' then
				A(15 downto 7) <= A(15 downto 7) + B;
			end if;
			
			if y(17) = '1' then
				IRQ2 <= '1';
			end if;	   
			
			if y(19) = '1' then
				C <= C(6 downto  0) & '1';
			elsif y(18) = '1' then
				C <= C(6 downto  0) & '0';
			end if;
		
			if y(20) = '1' then
				A <= A(14 downto 0) & '0';
			elsif y(21) = '1' then
				A <= A + not B + 1;
			elsif y(22) = '1' then
				A <= A + B;
			end if;
			
			if y(23) = '1' then
				C <= C + 1;
			end if;
			
			if y(9) = '1' then
				r <= c & b(7 downto 0);
			end if;
			
		end if;
	end process; 
	
	
	x(1) <= b(0);
	x(2) <='1' when cnt="111" else '0';									
	x(3) <= '1' when b = "00000000" else '0';
	x(4) <= a(15) xor b(8);
	x(5) <= a(15) xor TgS;
	x(6) <= B(8);
	x(7) <= B(8) xor TgS;
	x(8) <= TgS;
	x(9) <= '1' when a = "0000000000000000" else '0'; 
	
end behavioral;