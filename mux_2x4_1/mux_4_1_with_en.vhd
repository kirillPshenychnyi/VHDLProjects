
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux is
	port(
		en : in STD_LOGIC;
		addr : in STD_LOGIC_VECTOR(1 downto 0);
		data_in : in STD_LOGIC_VECTOR(3 downto 0);
		data_out : out STD_LOGIC
		);
end mux;

--}} End of automatically maintained section

architecture behavioral of mux is
begin
	
	main:process( en, addr, data_in ) begin
		
		if(en = '0' ) then
			case (addr) is 
				when "00" => data_out <= data_in(0);
				when "01" => data_out <= data_in(1);
				when "10" => data_out <= data_in(2);
				when "11" => data_out <= data_in(3);
				when others => data_out <= 'X';
			end case;
		else 
			data_out <= 'X';
		end if;
	end process main;	
	
end behavioral;
