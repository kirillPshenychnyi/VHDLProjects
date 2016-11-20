library IEEE;

use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all;

entity control_unit is port(	
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		y  : out STD_LOGIC_VECTOR(1 to 21);
		x  : in STD_LOGIC_VECTOR(0 to 9)
		);
	
end control_unit;

architecture behavioral of control_unit is 
	subtype Command is STD_LOGIC_VECTOR(27 downto  0);
	type TROM is array(0 to 32) of Command;
	
	constant ROM:TROM := 
	( 
		"0010010000000001000001000111"		   --0
	,	"0000000010010000000110000110"		   --1
	,	"0100000000000000000011000011"		   --2
	,	"0110100100000011000110000100"		   --3
	,	"0000110000000000000101000101"		   --4
	,	"0000000001000000000000000000"		   --5
	,	"0000000000000010000011000010"		   --6
	,	"0000000000000100001001001000"		   --7
	,	"1010000000000000000101000101"		   --8
	,	"1001000000000101001011001010"		   --9
	,	"1100000000000101001101001100"		   --10
	,	"0001010000000101000101001101"		   --11
	,	"0001100000000000000101000101"		   --12
	,	"0000000010010000011010011110"		   --13
	,	"0000001000000000010000010000"		   --14
	,	"0000000110000000010000010000"		   --15
	,	"0000000100000011010010010001"		   --16
	,	"0000000000000110011011010011"		   --17
	,	"0000000000000101010101010100"		   --18
	,	"0000000000000111011000011010"		   --19
	,	"0000001010000000010111010111"		   --20
	,	"0000001010000000010110010110"		   --21
	,	"0000001100000000011010011010"		   --22
	,	"0000000000100000011010011010"		   --23
	,	"0000000000100000011011011011"		   --24
	,	"0000001100000000011011011011"		   --25
	,	"0000000000000101001111001110"		   --26
	,	"0000000000001000011101011100"		   --27
	,	"0000000000001001100000011110"		   --28
	,	"0000000000001001000101011111"		   --29
	,	"0000000000001010100000000101"		   --30
	,	"0000000000001010000101100000"		   --31
	,	"0000000000110000000101000101"		   --32
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
	--y(1) <=  '1' when RegCom(18 downto 16) = "100" else '0';
		
end behavioral;