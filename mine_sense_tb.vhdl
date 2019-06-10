library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mine_sense_tb is
end;

architecture beh of mine_sense_tb is
signal clk,reset: std_logic;
signal mine_raw: std_logic;
signal mine_out: std_logic;

signal time_reset: std_logic;
signal time: std_logic_vector(16 downto 0);
begin
	uut: entity work.mine_sense
		port map(clk,reset,mine_raw,mine_out,time_reset,time);
	
	
	clk_tick: process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		time <= std_logic_vector(unsigned(time) + 1);
		if(time_reset = '1') then time <= (others => '0'); end if;
		wait for 10 ns;
	end process;

	stim: process
	begin
		reset <= '1';
		wait for 100 ns;
		reset <= '0';

		-- long pulse, no mine
		mine_raw <= '0';
		wait for 1 ms;
		mine_raw <= '1';
		wait for 2.1 ms;
		mine_raw <= '0';
		
		-- short pulse, mine found
		mine_raw <= '0';
		wait for 1 ms;
		mine_raw <= '1';
		wait for 1.9 ms;
		mine_raw <= '0';
		wait for 1 ms;
		wait;
	end process;
end beh;

