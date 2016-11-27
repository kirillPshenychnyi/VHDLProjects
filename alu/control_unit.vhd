library IEEE;

use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all;

entity control_unit is port(	
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		y  : out STD_LOGIC_VECTOR(1 to 24);
		x  : in STD_LOGIC_VECTOR(0 to 8)
		);
	
end control_unit;

architecture behavioral of control_unit is 
	subtype Command is STD_LOGIC_VECTOR(25 downto  0);
	type TROM is array(0 to 26) of Command;
	
	constant ROM:TROM := 
	( 	 --y1 --y2	--y3   --y4	 --x   --a0  	--a1
		"000"&"000"&"000"&"000"&"0001"&"00001"&"00111"		   --0
	,	"001"&"001"&"001"&"001"&"0010"&"00110"&"00110"		   --1
	,	"010"&"000"&"000"&"000"&"0000"&"00011"&"00011"		   --2
	,	"011"&"010"&"000"&"010"&"0011"&"00110"&"00100"		   --3
	,	"000"&"011"&"000"&"000"&"0000"&"00101"&"00101"		   --4
	,	"000"&"000"&"000"&"011"&"0000"&"00000"&"00000"		   --5
	,	"000"&"000"&"000"&"000"&"0010"&"00011"&"00010"		   --6
	,	"100"&"100"&"000"&"000"&"0100"&"01001"&"01000"		   --7
	,	"000"&"000"&"000"&"011"&"0000"&"01001"&"01001"		   --8
	,	"101"&"101"&"000"&"000"&"0101"&"01011"&"01010"		   --9
	,	"000"&"000"&"000"&"011"&"0000"&"01011"&"01011"		   --10
	,	"000"&"000"&"000"&"000"&"0110"&"01101"&"01100"		   --11
	,	"000"&"000"&"000"&"100"&"0000"&"01101"&"01101"		   --12
	,	"000"&"000"&"010"&"000"&"0111"&"10000"&"01111"		   --13
	,	"000"&"000"&"011"&"000"&"0000"&"00101"&"00101"		   --14
	,	"110"&"110"&"001"&"001"&"0000"&"11001"&"11001"		   --15
	,	"000"&"000"&"010"&"000"&"0000"&"10000"&"10000"		   --16
	,	"000"&"000"&"101"&"000"&"0000"&"10011"&"10011"		   --17
	,	"000"&"000"&"010"&"000"&"0000"&"10011"&"10011"		   --18
	,	"000"&"110"&"110"&"010"&"0011"&"11000"&"10100"		   --19
	,	"000"&"000"&"000"&"000"&"1000"&"10110"&"10101"		   --20	  
	,	"000"&"000"&"101"&"000"&"0000"&"10110"&"10110"		   --21
	,	"000"&"000"&"000"&"000"&"1001"&"10101"&"11010"		   --22	
	,	"000"&"000"&"001"&"101"&"0000"&"00101"&"00101"		   --23
	,	"110"&"000"&"000"&"000"&"0000"&"11001"&"11001"		   --24
	,	"000"&"000"&"000"&"000"&"1000"&"10010"&"10001"		   --25	 
	,	"000"&"000"&"000"&"110"&"0000"&"00101"&"00101"		   --26	
	);
	
	signal RegCom:Command;
	signal s : STD_LOGIC_VECTOR(0 to 1);
	signal current_command, x_decoded : integer;	   
	
begin
	
	x_decoded <= conv_integer( RegCom(13 downto 10 ) ) - 1;
	
	process( clk, reset ) 
	begin
		
		if(reset = '0') then
			RegCom <= (others => '0');
		elsif( rising_edge(clk) ) then
			if( x_decoded = -1 or x( x_decoded ) = '0' ) then 
				current_command <= conv_integer( RegCom(9 downto 5) );
				RegCom <= ROM( conv_integer( RegCom(9 downto 5) ) ); 
			else
				current_command <= conv_integer( RegCom(4 downto 0) );
				RegCom <= ROM( conv_integer( RegCom(4 downto 0) ) );
			end if;
		end if;	
	end process;
	
	y(1)  <= '1' when RegCom(25 downto 23) = "001" else '0';
	y(5)  <= '1' when RegCom(25 downto 23) = "010" else '0';
	y(6)  <= '1' when RegCom(25 downto 23) = "011" else '0';
	y(10) <= '1' when RegCom(25 downto 23) = "100" else '0';
	y(12) <= '1' when RegCom(25 downto 23) = "101" else '0';
	y(20) <= '1' when RegCom(25 downto 23) = "110" else '0';	
	
	y(2) <=  '1' when RegCom(22 downto 20) = "001" else '0';
	y(7) <=  '1' when RegCom(22 downto 20) = "010" else '0';
	y(9) <=  '1' when RegCom(22 downto 20) = "011" else '0';
	y(11) <= '1' when RegCom(22 downto 20) = "100" else '0';
	y(13) <= '1' when RegCom(22 downto 20) = "101" else '0';
	y(19) <= '1' when RegCom(22 downto 20) = "110" else '0';			
	
	y(3)  <= '1' when RegCom(19 downto 17) = "001" else '0';
	y(16) <= '1' when RegCom(19 downto 17) = "010" else '0';
	y(17) <= '1' when RegCom(19 downto 17) = "011" else '0';
	y(18) <= '1' when RegCom(19 downto 17) = "100" else '0';
    y(21) <= '1' when RegCom(19 downto 17) = "101" else '0';
	y(22) <= '1' when RegCom(19 downto 17) = "110" else '0';
		
		
	y(4)  <= '1' when RegCom(16 downto 14) = "001" else '0';
	y(8)  <= '1' when RegCom(16 downto 14) = "010" else '0';
	y(14) <= '1' when RegCom(16 downto 14) = "011" else '0';
	y(15) <= '1' when RegCom(16 downto 14) = "100" else '0';
	y(23) <= '1' when RegCom(16 downto 14) = "101" else '0';
	y(24) <= '1' when RegCom(16 downto 14) = "110" else '0';
		
end behavioral;