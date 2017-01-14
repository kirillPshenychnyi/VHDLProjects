
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mx_top is
	 port(
		 en_1 : in STD_LOGIC;
		 en_2 : in STD_LOGIC;
		 addr : in STD_LOGIC_VECTOR(1 downto 0);
		 data_f : in STD_LOGIC_VECTOR(3 downto 0);
		 data_s : in STD_LOGIC_VECTOR(3 downto 0);
		 data_out_f : out STD_LOGIC;
		 data_out_s : out STD_LOGIC
	     );
end mx_top;

--}} End of automatically maintained section

architecture structural of mx_top is	 
component mux is
	port(
		en : in STD_LOGIC;
		addr : in STD_LOGIC_VECTOR(1 downto 0);
		data_in : in STD_LOGIC_VECTOR(3 downto 0);
		data_out : out STD_LOGIC
		);
end component mux; 
begin

	top: mux port map( en => en_1, addr => addr, data_in => data_f, data_out => data_out_f );
	low: mux port map( en => en_2, addr => addr, data_in => data_s, data_out => data_out_s );

end structural;
