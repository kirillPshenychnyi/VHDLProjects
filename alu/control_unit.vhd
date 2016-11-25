library IEEE;

use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all;

entity control_unit is port(	
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		y  : out STD_LOGIC_VECTOR(1 to 23);
		x  : in STD_LOGIC_VECTOR(0 to 9)
		);
	
end control_unit;

architecture behavioral of control_unit is 
	subtype Command is STD_LOGIC_VECTOR(27 downto  0);
	type TROM is array(0 to 32) of Command;
	
	constant ROM:TROM := 
	( 
		"000"&"000"&"000"&"000"&"0001"&"000001"&"000111"		   --0
	,	"001"&"001"&"001"&"001"&"0000"&"000110"&"000110"		   --1
	,	"010"&"000"&"000"&"000"&"0000"&"000011"&"000111"		   --2
	,	"011"&"010"&"010"&"000"&"0011"&"000110"&"000100"		   --3
	,	"000"&"011"&"000"&"000"&"0000"&"000101"&"000101"		   --4
	,	"000"&"000"&"000"&"101"&"0000"&"000000"&"000000"		   --5
	,	"000"&"000"&"000"&"000"&"0010"&"000011"&"000010"		   --6
	,	"100"&"100"&"000"&"000"&"0100"&"001000"&"100000"		   --7
	,	"101"&"101"&"000"&"000"&"0101"&"001010"&"001001"		   --8
	,	"000"&"000"&"011"&"000"&"0101"&"001011"&"001100"		   --9
	,	"000"&"110"&"000"&"000"&"0101"&"001011"&"001100"		   --10
	,	"000"&"000"&"001"&"001"&"0000"&"011001"&"011001"		   --11
	,	"000"&"000"&"011"&"000"&"0000"&"000101"&"000101"		   --12
	,	"000"&"000"&"101"&"000"&"0000"&"001111"&"001111"		   --13
	,	"000"&"000"&"110"&"000"&"0000"&"001111"&"001111"		   --14
	,	"000"&"000"&"010"&"000"&"0011"&"010001"&"010000"		   --15
	,	"000"&"000"&"000"&"000"&"0101"&"011010"&"010010"		   --16
	,	"000"&"000"&"000"&"000"&"0101"&"010111"&"010101"		   --17
	,	"000"&"000"&"000"&"000"&"0111"&"010100"&"010011"		   --18
	,	"000"&"000"&"000"&"011"&"0000"&"011010"&"011010"		   --19
	,	"000"&"000"&"000"&"100"&"0000"&"011010"&"011010"		   --20
	,	"000"&"000"&"010"&"000"&"0000"&"010110"&"010110"		   --21
	,	"000"&"000"&"000"&"100"&"0000"&"011001"&"011001"		   --22
	,	"000"&"000"&"010"&"010"&"0000"&"011000"&"011000"		   --23
	,	"000"&"000"&"000"&"011"&"0000"&"011001"&"011001"		   --24
	,	"000"&"000"&"000"&"000"&"0101"&"001110"&"001101"		   --25
	,	"000"&"000"&"000"&"000"&"1000"&"011100"&"011011"		   --26
	,	"000"&"000"&"000"&"000"&"1001"&"011111"&"011101"		   --27
	,	"000"&"000"&"000"&"000"&"1001"&"000101"&"011110"		   --28
	,	"000"&"000"&"000"&"000"&"1010"&"011111"&"000101"		   --29
	,	"000"&"000"&"000"&"000"&"1010"&"000101"&"011111"		   --30
	,	"000"&"000"&"000"&"110"&"0000"&"000101"&"000101"		   --31
	,	"110"&"000"&"000"&"000"&"0000"&"000101"&"000101"		   --32
	);
	
	signal RegCom:Command;
	signal s : STD_LOGIC_VECTOR(0 to 1);
	signal current_command, x_decoded : integer;	   
	
begin
	
	x_decoded <= conv_integer( RegCom(15 downto 12) ) - 1;
	
	process( clk, reset ) 
	begin
		
		if(reset = '0') then
			RegCom <= (others => '0');
		elsif( rising_edge(clk) ) then
			if( x_decoded = -1 or x( x_decoded ) = '0' ) then 
				current_command <= conv_integer( RegCom(11 downto 6) );
				RegCom <= ROM( conv_integer( RegCom(11 downto 6) ) ); 
			else
				current_command <= conv_integer( RegCom(5 downto 0) );
				RegCom <= ROM( conv_integer( RegCom(5 downto 0) ) );
			end if;
		end if;	
	end process;
	
	y(1) <=  '1' when RegCom(27 downto 25) = "001" else '0';
	y(5) <=  '1' when RegCom(27 downto 25) = "010" else '0';
	y(6) <=  '1' when RegCom(27 downto 25) = "011" else '0';
	y(10) <= '1' when RegCom(27 downto 25) = "100" else '0';
	y(12) <= '1' when RegCom(27 downto 25) = "101" else '0';
	y(14) <= '1' when RegCom(27 downto 25) = "110" else '0';	
	
	y(2) <=  '1' when RegCom(24 downto 22) = "001" else '0';
	y(7) <=  '1' when RegCom(24 downto 22) = "010" else '0';
	y(9) <=  '1' when RegCom(24 downto 22) = "011" else '0';
	y(11) <= '1' when RegCom(24 downto 22) = "100" else '0';
	y(13) <= '1' when RegCom(24 downto 22) = "101" else '0';
	y(15) <= '1' when RegCom(24 downto 22) = "110" else '0';			
	
	y(3) <=  '1' when RegCom(21 downto 19) = "001" else '0';
	y(8) <=  '1' when RegCom(21 downto 19) = "010" else '0';
	y(16) <= '1' when RegCom(21 downto 19) = "011" else '0';
	y(17) <= '1' when RegCom(21 downto 19) = "100" else '0';
	y(18) <= '1' when RegCom(21 downto 19) = "101" else '0';
	y(19) <= '1' when RegCom(21 downto 19) = "110" else '0';			
		
	y(4)  <= '1' when RegCom(18 downto 16) = "001" else '0';
	y(20) <= '1' when RegCom(18 downto 16) = "010" else '0';
	y(21) <= '1' when RegCom(18 downto 16) = "011" else '0';
	y(22) <= '1' when RegCom(18 downto 16) = "100" else '0';
	y(21) <= '1' when RegCom(18 downto 16) = "011" else '0';
	y(23) <= '1' when RegCom(18 downto 16) = "110" else '0';
		
end behavioral;