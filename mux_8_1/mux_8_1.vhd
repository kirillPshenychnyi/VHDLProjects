
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_8_1 is
	port(
		address : in STD_LOGIC_VECTOR(2 downto 0);
		data : in STD_LOGIC_VECTOR(7 downto 0);
		data_out : out STD_LOGIC
		);
end mux_8_1;

--}} End of automatically maintained section

architecture behavioral of mux_8_1 is
begin
	
	main: process (address, data)  
	begin
		case (address) is
			when "000" => data_out <= data(0);
			when "001" => data_out <= data(1);
			when "010" => data_out <= data(2);
			when "011" => data_out <= data(3);
			when "100" => data_out <= data(4);
			when "101" => data_out <= data(5);
			when "110" => data_out <= data(6);
			when "111" => data_out <= data(7);
			when others => null;   
		end	case;
	end process main; 
	
end behavioral;
