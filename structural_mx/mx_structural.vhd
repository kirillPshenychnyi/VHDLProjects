library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MX is
	port(
		En : in STD_LOGIC;
		DI : in STD_LOGIC_VECTOR(15 downto 0);
		A : in STD_LOGIC_VECTOR(3 downto 0);
		Q : out STD_LOGIC
		);
end MX;

--}} End of automatically maintained section

architecture Structural of MX is
	component not_gate
		port(
			i : in STD_LOGIC;
			o : out STD_LOGIC
			);
	end component;	 
	
	component and2_gate
		port(
			i0,i1 : in STD_LOGIC;
			o : out STD_LOGIC
			);	
	end component;
	
	component and4_gate
		port(
			i0, i1, i2, i3 : in STD_LOGIC;
			o : out STD_LOGIC
			);
	end component;			
	
	component or2_gate
		port (
			i0 : in STD_LOGIC;
			i1 : in STD_LOGIC;
			output : out STD_LOGIC
			);
	end component;	
	
	component or4_gate
		port(
			i0, i1, i2, i3 : in STD_LOGIC;
			o : out STD_LOGIC
			);
	end component;	
	
	signal q_temp, nq_temp, nEn : STD_LOGIC;
	signal na : STD_LOGIC_VECTOR( 3 downto 0);
	signal temp, DI_temp: STD_LOGIC_VECTOR ( 15 downto 0 );
	signal terms : STD_LOGIC_VECTOR( 4 downto 0 );
begin
	
	gen_not:for i in 0 to 3 generate
		notA: not_gate port map(i => A(i), o => na(i));
	end generate;  
	
	-- nEn
	n_en:not_gate port map (i => En, o => nEn);
	
	-- 0000			  
	DI0_and1:and4_gate port map (i0 => na(3), i1 => na(2), i2 => na(1), i3 => na(0), o => temp(0) );
	DIO_and2:and2_gate port map (i0=>DI(0), i1=>temp(0), o => DI_temp(0));
	
	-- 0001		 
	DI1_and1:and4_gate port map (i0 => na(3), i1 => na(2), i2 => na(1), i3 => A(0), o => temp(1) );
	DI1_and2:and2_gate port map (i0=>DI(1), i1=>temp(1), o => DI_temp(1));
	
	-- 0010
	DI2_and1:and4_gate port map (i0 => na(3), i1 => na(2), i2 => A(1), i3 => na(0), o => temp(2) );
	DI2_and2:and2_gate port map (i0=>DI(2), i1=>temp(2), o => DI_temp(2));
	
	-- 0011			
	DI3_and1:and4_gate port map (i0 => na(3), i1 => na(2), i2 => A(1), i3 => A(0), o => temp(3) );
	DI3_and2:and2_gate port map (i0=>DI(3), i1=>temp(3), o => DI_temp(3));
	
	-- 0100	
	DI4_and1:and4_gate port map (i0 => na(3), i1 => A(2), i2 => na(1), i3 => na(0), o => temp(4) );
	DI4_and2:and2_gate port map (i0=>DI(4), i1=>temp(4), o => DI_temp(4));
	
	-- 0101
	DI5_and1:and4_gate port map (i0 => na(3), i1 => A(2), i2 => na(1), i3 => A(0), o => temp(5) );
	DI5_and2:and2_gate port map (i0=>DI(5), i1=>temp(5), o => DI_temp(5));
	
	-- 0110
	DI6_and1:and4_gate port map (i0 => na(3), i1 => A(2), i2 => A(1), i3 => na(0), o => temp(6) );
	DI6_and2:and2_gate port map (i0=>DI(6), i1=>temp(6), o => DI_temp(6));
	
	-- 0111
	DI7_and1:and4_gate port map (i0 => na(3), i1 => A(2), i2 => A(1), i3 => A(0), o => temp(7) );
	DI7_and2:and2_gate port map (i0=>DI(7), i1=>temp(7), o => DI_temp(7));
	
	-- 1000
	DI8_and1:and4_gate port map (i0 => A(3), i1 => na(2), i2 => na(1), i3 => na(0), o => temp(8) );
	DI8_and2:and2_gate port map (i0=>DI(8), i1=>temp(8), o => DI_temp(8));
	
	-- 1001
	DI9_and1:and4_gate port map (i0 => A(3), i1 => na(2), i2 => na(1), i3 => A(0), o => temp(9) );
	DI9_and2:and2_gate port map (i0=>DI(9), i1=>temp(9), o => DI_temp(9));
	
	-- 1010
	DI10_and1:and4_gate port map (i0 => A(3), i1 => na(2), i2 => A(1), i3 => na(0), o => temp(10) );
	DI10_and2:and2_gate port map (i0=>DI(10), i1=>temp(10), o => DI_temp(10));
	
	-- 1011
	DI11_and1:and4_gate port map (i0 => A(3), i1 => na(2), i2 => A(1), i3 => A(0), o => temp(11) );
	DI11_and2:and2_gate port map (i0=>DI(11), i1=>temp(11), o => DI_temp(11));
	
	-- 1100
	DI12_and1:and4_gate port map (i0 => A(3), i1 => A(2), i2 => na(1), i3 => na(0), o => temp(12) );
	DI12_and2:and2_gate port map (i0=>DI(12), i1=>temp(12), o => DI_temp(12));
	
	-- 1101
	DI13_and1:and4_gate port map (i0 => A(3), i1 => A(2), i2 => na(1), i3 => A(0), o => temp(13) );
	DI13_and2:and2_gate port map (i0=>DI(13), i1=>temp(13), o => DI_temp(13));
	
	-- 1110
	DI14_and1:and4_gate port map (i0 => A(3), i1 => A(2), i2 => A(1), i3 => na(0), o => temp(14) );
	DI14_and2:and2_gate port map (i0=>DI(14), i1=>temp(14), o => DI_temp(14));
	
	-- 1111
	DI15_and1:and4_gate port map (i0 => A(3), i1 => A(2), i2 => A(1), i3 => A(0), o => temp(15) );
	DI15_and2:and2_gate port map (i0=>DI(15), i1=>temp(15), o => DI_temp(15));
	
	t1: or4_gate port map ( i0 => DI_temp(0), i1 => DI_temp(1), i2 => DI_temp(2), i3 => DI_temp(3), o => terms(0) );
	t2: or4_gate port map ( i0 => DI_temp(4), i1 => DI_temp(5), i2 => DI_temp(6), i3 => DI_temp(7), o => terms(1) );
	t3: or4_gate port map ( i0 => DI_temp(8), i1 => DI_temp(9), i2 => DI_temp(10), i3 => DI_temp(11), o => terms(2) );
	t4: or4_gate port map ( i0 => DI_temp(12), i1 => DI_temp(13), i2 => DI_temp(14), i3 => DI_temp(15), o => terms(3) );
	
	out_q:or4_gate port map( i0 => terms(0), i1 => terms(1), i2 => terms(2), i3 => terms(3), o => q_temp );
	
	out_en:and2_gate port map( i0 => nEn, i1 => q_temp, o => nq_temp );	
	
	nq:not_gate port map (i => nq_temp, o => Q);	
		
end Structural;
