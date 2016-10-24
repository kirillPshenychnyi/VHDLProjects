
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity greyCounter is
	port(
		clk : in STD_LOGIC;
		Reset : in STD_LOGIC;
		Q : out STD_LOGIC_VECTOR(2 downto 0)
		);
end greyCounter;

--}} End of automatically maintained section

architecture greyCounter of greyCounter is
	component JK_FF_TT
		port(
			J : in STD_LOGIC;
			K : in STD_LOGIC;
			clk : in STD_LOGIC;
			R : in STD_LOGIC;
			Q : out STD_LOGIC;
			nQ : out STD_LOGIC
			);
	end component;
	signal j, k, q_temp: STD_LOGIC_VECTOR( 2 downto 0 );
begin
	
	j(2) <= q_temp(1) and not q_temp(0);
	k(2) <= not q_temp(1) and not q_temp(0);
	
	j(1) <= not q_temp(2) and q_temp(0);
	k(1) <= q_temp(2) and q_temp(0);
	
	j(0) <= ( not q_temp(2) and not q_temp(1) ) or ( q_temp(2) and q_temp(1) );
	k(0) <= q_temp(1) xor q_temp(2);
	
	gen:for i in 0 to 2 generate
		t:JK_FF_TT port map ( J => j(i), K => k(i), clk => clk, R => Reset, Q => q_temp(i), nQ => open );
	end generate;
	
	Q <= q_temp;
	
end greyCounter;
