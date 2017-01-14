  
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity testbench is
end testbench;

--}} End of automatically maintained section

architecture testbench of testbench is 

component mx_top is
	 port(
		 en_1 : in STD_LOGIC;
		 en_2 : in STD_LOGIC;
		 addr : in STD_LOGIC_VECTOR(1 downto 0);
		 data_f : in STD_LOGIC_VECTOR(3 downto 0);
		 data_s : in STD_LOGIC_VECTOR(3 downto 0);
		 data_out_f : out STD_LOGIC;
		 data_out_s : out STD_LOGIC
	     );
end component mx_top;

signal en1, en2, data_out1, data_out2 : STD_LOGIC;
signal data1, data2: STD_LOGIC_VECTOR(3 downto 0);
signal adr : STD_LOGIC_VECTOR(1 downto 0);
	
begin
								   
   top: mx_top port map( 
					   en_1 => en1, 
					   en_2 => en2, 
					   addr => adr, 
					   data_f => data1,
					   data_s => data2, 
					   data_out_f => data_out1, 
					   data_out_s => data_out2 );
	 
	gen:process begin
	
	en1 <= '0';
	data1 <= "0101";
	
	adr <= "00";
	wait for 10ns;
	
	adr <= "01";
	wait for 10ns;
	
	adr <= "10";
	wait for 10ns;
	
	adr <= "11";
	wait for 10ns;
	
	en2 <= '0';
	data2 <= "1010";
	
	adr <= "00";
	wait for 10ns;
	
	adr <= "01";
	wait for 10ns;
	
	adr <= "10";
	wait for 10ns;
	
	adr <= "11";
	wait for 10ns;
	
	end process gen;
					   
end testbench;
