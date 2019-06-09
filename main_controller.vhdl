library ieee;
use ieee.std_logic_1164.all;


entity main_controller is
	port (
		clk,reset: in std_logic;
		motor_drive: out std_logic_vector(2 downto 0);
		-- "000" = stop "001" = line_follower "010" = back_follower
		-- "100" = back "101" = rotate_left "110" = rotate_right
		uart_response: out std_logic_vector(1 downto 0);
		-- "00" = B "01" = C "10" = M
		uart_send: out std_logic;

		uart_rec: in std_logic_vector(1 downto 0);
		-- "00" = S "01" = L "10" = R "11" = S
		line_sense: in std_logic_vector(2 downto 0);
		-- left is MSB
		mine_sense, uart_avail, timeout: in std_logic

	);
end main_controller;

architecture behaviour of main_controller is
type statetype is ( send_B, send_M, send_C, send_C_after_stop,
	line_follow, line_follow_till_white, back_follow, line_follow_timeout,
	back_till_white, back_till_black,
	left_till_time, left_till_black, right_till_time, right_till_black,
	time_line, time_rot,
	stop_till_u, stop_forever,
	read);

signal state, nextstate: statetype;
signal a_black, a_white: std_logic; -- flags for control
begin
	a_black <= not( line_sense(0) and line_sense(1) and line_sense(2));
	a_white <= line_sense(0) or line_sense(1) or line_sense(2);

	seq: process
	begin
		wait until rising_edge(clk);
		if(reset = '1') then
			state <= send_B;
		else
			state <= nextstate;
		end if;
	end process;

end behaviour;		
