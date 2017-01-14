library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity testbecnh is
end testbecnh;

--}} End of automatically maintained section

architecture struct of testbecnh is	   

component mux_8_1 is
	port(
		address : in STD_LOGIC_VECTOR(2 downto 0);
		data : in STD_LOGIC_VECTOR(7 downto 0);
		data_out : out STD_LOGIC
		);
end component;

signal adr : STD_LOGIC_VECTOR(2 downto 0);
signal data: STD_LOGIC_VECTOR(7 downto 0);
signal d_out : STD_LOGIC;

begin
	
	top: mux_8_1 port map (address => adr, data => data, data_out => d_out);
	
	main:process begin 
	data <= "01011010";
	
	adr <= "000";
	wait for 10ns;
	
	adr <= "001";
	wait for 10ns;
	
	adr <= "010";
	wait for 10ns;
	
	adr <= "011";
	wait for 10ns;
	
	adr <= "100";
	wait for 10ns;
	
	adr <= "101";
	wait for 10ns;
	
	adr <= "110";
	wait for 10ns;
	
	adr <= "111";
	wait for 10ns;
	
	end process main;
	
	
end struct;
