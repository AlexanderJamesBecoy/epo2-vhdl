library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
	generic(F_CPU : integer := 50000); -- clock frequency in kHz
	                                   -- min is 2, max is 50000
	port ( clk : in std_logic;
	       reset : in std_logic;
			 sensor : in std_logic_vector(2 downto 0);
	       lmotor, rmotor : out std_logic;
			 tx : out std_logic;
			 rx : in std_logic;
			 mine : in std_logic;
			 sw : in std_logic_vector(7 downto 0);
			 btn : in std_logic_vector(1 downto 0);
			 led : out std_logic_vector(7 downto 0);
			 an : out std_logic_vector(3 downto 0);
			 sseg : out std_logic_vector(7 downto 0)
			 );
end top;

architecture structural of top is
signal line: std_logic_vector(2 downto 0);
signal md: std_logic_vector(2 downto 0);
signal miner, mines, ctbr, mrtbr, mltbr, minetbr, wu, rdu, au: std_logic;
signal ru, tu: std_logic_vector(7 downto 0);
signal rdec: std_logic_vector(2 downto 0);
signal tenc: std_logic_vector(1 downto 0);
signal bfm, lfm, m: std_logic_vector(3 downto 0);
signal ml, mr: std_logic_vector(1 downto 0);
signal mltb, mrtb: std_logic_vector(19 downto 0);
signal ctb: std_logic_vector(28 downto 0);
signal minetb: std_logic_vector(16 downto 0);
signal state: std_logic_vector(4 downto 0);
begin
	linebuff: entity work.inputbuffer
		generic map(3)
		port map(clk,reset,sensor,line);
	
	minebuf: entity work.inputbuffer1
		port map(clk,reset,mine,miner);
	
	minesens: entity work.mine_sense
		generic map(F_CPU*2)
		port map(clk,reset,miner,mines,minetbr,minetb);

	mine_tb: entity work.timebase
		generic map(17)
		port map(clk,minetbr,minetb);
	
	bfollow: entity work.back_follower
		port map(clk,reset,line,bfm);

	lfollow: entity work.line_follower
		port map(clk,reset,line,lfm);
	
	uart: entity work.uart
		port map(clk,reset,rx,tx,tu,ru,wu,rdu,au);
	
	uart_dec: entity work.inst_decode
		port map(ru,rdec);

	uart_enc: entity work.resp_encode
		port map(tenc,tu);
	
	motormux: entity work.mux8
		generic map(4)
		port map("-0-0",lfm,bfm,"0111","0101","1111","----","----",md,m);
		-- "000" = stop "001" = line_follower "010" = back_follower
		-- "011" = back "100" = rotate_left "101" = rotate_right
		-- 4=left-direction 3=left-move 2=right-direction 1=right-move
		--N.B. due to the robot's design, right_direction (bit 2) is inverted

	motorl: entity work.motorcontrol
		generic map(F_CPU/2)
		port map(clk,reset,ml,mltb,mltbr,lmotor);

	motorr: entity work.motorcontrol
		generic map(F_CPU/2)
		port map(clk,reset,mr,mrtb,mrtbr,rmotor);
	
	ml <= m(3 downto 2);
	mr <= m(1 downto 0);

	ml_tb: entity work.timebase
		generic map(20)
		port map(clk,mltbr,mltb);

	mr_tb: entity work.timebase
		generic map(20)
		port map(clk,mrtbr,mrtb);
	
	ct_tb: entity work.timebase
		generic map(29)
		port map(clk,ctbr,ctb);
	
	mc: entity work.main_controller
		generic map(F_CPU*400)
		port map(clk,reset,md,tenc,wu,ctbr,state,rdec,line,mines,au,ctb);
	
	rdu <= '0'; -- controller doesn't care about the flag


	led <= state & "000";
	an <= (others => '0');
	sseg <= (others => '0');
end structural;

