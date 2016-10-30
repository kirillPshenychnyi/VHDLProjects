
architecture structural of shift_register is
	
	component RS_FF
		port(
			R : in STD_LOGIC;
			S : in STD_LOGIC;
			clk : in STD_LOGIC;
			Q : out STD_LOGIC
			);
	end component;	
	
	component and2_gate
		port (
			i0, i1 : in STD_LOGIC;
			f: out STD_LOGIC
			);
	end component;		 
	
	component nor2_gate is
		port(
			i0 : in STD_LOGIC;
			i1 : in STD_LOGIC;
			f : out STD_LOGIC
			);
	end component;
	
	component or2_gate
		port (
			i0, i1 : in STD_LOGIC;
			f : out STD_LOGIC
			);
	end component;	
	
	component not_gate
		port (
			i : in STD_LOGIC;
			f : out STD_LOGIC
			);
	end component;	
	
	signal and_gates : STD_LOGIC_VECTOR( 9 downto 0);	
	signal nor_gates : STD_LOGIC_VECTOR( 3 downto 0 );
	signal synchro : STD_LOGIC;
	signal Q_ff, set : STD_LOGIC_VECTOR( 3 downto 0 );
	signal nC1, nC2, nL, nnL : STD_LOGIC;
begin
	
	invL:  not_gate port map( i => L, f => nL ); 
	invnL: not_gate port map( i => nL, f => nnL ); 
	invnC1: not_gate port map( i => C1, f => nC1 ); 
	invnC2: not_gate port map( i => C2, f => nC2 ); 	
	
	invC1invL : and2_gate port map( i0 => nL, i1 => nC1, f => and_gates(0) );
	invC2L : and2_gate port map( i0 => L, i1 => nC2, f => and_gates(1) );																		 
	orC1C2 : or2_gate port map ( i0 => and_gates(0), i1 => and_gates(1), f => synchro );
	
	DRnL: and2_gate port map( i0 => Dr, i1 => nL, f => and_gates(2) );	
	D0L: and2_gate port map ( i0 => D(3), i1 => nnL, f=> and_gates(3) );
	DRnLorD0l : nor2_gate port map( i0 => and_gates(2), i1 => and_gates(3), f=> nor_gates(0) );
	
	RS_signals_gen: for i in 0 to 2 generate 
	begin
		QnL: and2_gate port map ( i0 => Q_ff(3-i), i1 => nL, f=> and_gates(4+i*2) );	
		DL : and2_gate port map ( i0 => D(2-i), i1 => nnL, f=> and_gates(5+i*2) ); 
		QnLDl: nor2_gate port map( i0 => and_gates(4+i*2), i1 => and_gates(5+i*2), f=> nor_gates(i+1) );
	end generate;
	
	set_gen: for i in 0 to 3 generate
		not_gen:not_gate port map( i => nor_gates(i), f => set(i) );
	end generate;
	
	ff_gen: for i in 0 to 3 generate
		rs_gen:RS_FF port map( R => nor_gates(i), S => set(i), Clk => synchro, Q => Q_ff(3-i) );
	end generate;
	
	Q(0) <= Q_ff(0);
	Q(1) <= Q_ff(1);
	Q(2) <= Q_ff(2);
	Q(3) <= Q_ff(3);
	
	
end structural;
