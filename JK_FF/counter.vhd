
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity counter is
	port(
	clk, reset : in STD_LOGIC;
	Q : out STD_LOGIC_VECTOR(2 downto 0)
		);
end counter;

--}} End of automatically maintained section

architecture counter of counter is 
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
	signal q0, q1, q2, nq2, j2: STD_LOGIC;
	
begin
	j2 <= q0 and q1;
	nq2 <= not q2;
	
	bit0: JK_FF_TT port map ( J => nq2, K => '1', clk => clk, R => reset, Q => q0, nQ => open );
	bit1: JK_FF_TT port map ( J => q0, K => q0, clk => clk, R => reset, Q => q1, nQ => open );
	bit2: JK_FF_TT port map ( J => j2, K => '1', clk => clk, R => reset, Q => q2, nQ => open );
	
	Q(0) <= q0;
	Q(1) <= q1;
	Q(2) <= q2;
end counter;
