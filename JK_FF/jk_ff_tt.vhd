library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity JK_FF_TT is
	port(
		J : in STD_LOGIC;
		K : in STD_LOGIC;
		clk : in STD_LOGIC;
		R : in STD_LOGIC;
		Q : out STD_LOGIC;
		nQ : out STD_LOGIC
		);			 
end JK_FF_TT;

architecture JK_FF_TT of JK_FF_TT is	
	component JK_FF
		port (
			J : in STD_LOGIC;
			K : in STD_LOGIC;
			clk : in STD_LOGIC;
			R : in STD_LOGIC;
			Q : out STD_LOGIC;
			nQ : out STD_LOGIC
			);
	end component;	
	signal q_connect, nq_connect, n_clk : std_logic;
begin		 
	n_clk <= not clk;
	
	master: JK_FF port map (J => J, K => K, clk => clk, R => R, Q => q_connect, nQ => nq_connect );
	slave:  JK_FF port map (J => q_connect, K => nq_connect, clk => n_clk, R => R, Q => Q, nQ => nQ );
		
end JK_FF_TT;
