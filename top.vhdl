library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
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
signal miner, mines, ctbr, mrtbr, mltbr, wu, rdu, au: std_logic;
signal ru, tu: std_logic_vector(7 downto 0);
signal rdec: std_logic_vector(2 downto 0);
signal tenc: std_logic_vector(1 downto 0);
signal bfm, lfm, m: std_logic_vector(3 downto 0);
signal ml, mr: std_logic_vector(1 downto 0);
signal mltb, mrtb: std_logic_vector(19 downto 0);
signal ctb: std_logic_vector(28 downto 0);
signal state: std_logic_vector(4 downto 0);
begin
	linebuff: entity work.inputbuffer
		generic map(3)
		port map(clk,reset,sensor,line);
	
	minebuf: entity work.inputbuffer1
		port map(clk,reset,mine,miner);
	
	minesens: entity work.mine_sense
		port map(clk,reset,miner,mines);
	
	bfollow: entity work.back_follower
		port map(clk,reset,line,bfm);

	lfollow: entity work.line_follower
		port map(clk,reset,line,lfm);
	
	uart: entity work.uart
		port map(clk,reset,rx,tx,tu,ru,wu,au);
	
	uart_dec: entity work.inst_decode
		port map(ru,rdec);

	uart_enc: entity work.resp_encode
		port map(tenc,tu);
	
	motormux: entity work.mux8
		generic map(4)
		port map("0000",lfm,bfm,"1010","1110","1011","0000","0000",md,m);
		-- "000" = stop "001" = line_follower "010" = back_follower
		-- "011" = back "100" = rotate_left "101" = rotate_right

	motorl: entity work.motorcontrol
		port map(clk,reset,ml,mltb,mltbr,lmotor);

	motorr: entity work.motorcontrol
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
		port map(clk,reset,md,tenc,wu,ctbr,state,rdec,line,mines,au,ctb);
	
	rdu <= '0'; -- controller doesn't care about the flag


	led <= state & "000";
	an <= (others => '0');
	sseg <= (others => '0');
end structural;

