library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main_controller_tb is
end main_controller_tb;

architecture behaviour of main_controller_tb is
signal clk,reset,uart_send,time_start,mine_sense,uart_avail: std_logic;
signal time: std_logic_vector(28 downto 0);
signal motor_drive, uart_rec, line_sense: std_logic_vector(2 downto 0);
signal uart_response: std_logic_vector(1 downto 0);
signal state_out: std_logic_vector(4 downto 0);
begin
	uut: entity work.main_controller
		port map(clk,reset,motor_drive,uart_response,uart_send,time_start,state_out,uart_rec,line_sense,mine_sense,uart_avail,time);
	clk_tick: process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;

	stim: process
	begin
		reset <= '1';
		wait for 100 ns;
		reset <= '0';
		time <= std_logic_vector(to_unsigned(0,29));

		-- Send B
		uart_rec <= "001"; --L
		uart_avail <= '1';
		
		wait for 20 ns;
		uart_avail <= '0';
		line_sense <= "101";

		-- Move foward
		wait for 1 us;

		-- Send C
		line_sense <= "000"; -- all black;
		wait for 1 us;
		line_sense <= "101";

		-- Move left
		wait for 1 us;
		line_sense <= "000";
		time <= std_logic_vector(to_unsigned(50000000,29));
		wait for 20 ns;
		time <= std_logic_vector(to_unsigned(0,29));
		wait for 1 us;
		line_sense <= "101";

		--- stop due to white
		wait for 1 us;
		line_sense <= "111";
		wait for 1 us;
		uart_rec <= "011"; --U
		wait for 1 us;
		time <= std_logic_vector(to_unsigned(50000000,29));
		wait for 20 ns;
		time <= std_logic_vector(to_unsigned(0,29));

		-- move backwards
		wait for 1 us;
		line_sense <= "110";

		wait;
	end process;
end behaviour;
