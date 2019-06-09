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
		uart_send, time_start: out std_logic;

		uart_rec: in std_logic_vector(2 downto 0);
		-- "000" = S "001" = L "010" = R "011" = U "100" = Q
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
signal a_black, all_black, a_white, all_white: std_logic; -- flags for control
signal control_v: std_logic_vector(6 downto 0);
begin
	-- flags
	a_black <= not(line_sense(0) and line_sense(1) and line_sense(2));
	all_black <= (not line_sense(0)) and (not line_sense(0)) and (not line_sense(0));
	a_white <= line_sense(0) or line_sense(1) or line_sense(2);
	all_white <= line_sense(0) and line_sense(1) and line_sense(2);

	-- output
	with state select control_v <=
	"0000010" when send_B,
	"0001010" when send_M,
	"0000110" when send_C,
	"0000110" when send_C_after_stop,
	"0010000" when line_follow,
	"0010000" when line_follow_till_white,
	"0100000" when back_follow,
	"0010000" when line_follow_timeout,
	"0100000" when back_till_white,
	"0100000" when back_till_black,
	"1010000" when left_till_time,
	"1010000" when left_till_black,
	"1100000" when right_till_time,
	"1100000" when right_till_black,
	"0000001" when time_line,
	"0000001" when time_rot,
	"0000000" when stop_till_u,
	"0000000" when stop_forever,
	"0000000" when read;
	
	(motor_drive(2), motor_drive(1), motor_drive(0), uart_response(1), uart_response(0), uart_send, time_start) <= control_v;

	-- FSM
	seq: process
	begin
		wait until rising_edge(clk);
		if(reset = '1') then
			state <= send_B;
		else
			state <= nextstate;
		end if;
	end process;

	comb: process(state,uart_rec,line_sense,mine_sense,uart_avail,timeout)
	begin
	-- default is stay in your state
	nextstate <= state;
	case state is
	when send_B => if(uart_avail = '1') then nextstate <= line_follow; end if;
	when send_M => nextstate <= back_till_white;
	when send_C => 
		case uart_rec is
		when "000" =>  nextstate <= line_follow; --S
		when "001" =>  nextstate <= time_line; --L
		when "010" =>  nextstate <= time_line; --R
		when "011" =>  nextstate <= back_till_white; --U
		when "100" =>  nextstate <= stop_forever; --Q
		when others => nextstate <= state;
		end case;
	when send_C_after_stop => nextstate <= back_till_black;
	when line_follow => 
		if(mine_sense = '1') then nextstate <= send_M;
		elsif(all_white = '1') then nextstate <= stop_till_U ;
		elsif(all_black = '1') then nextstate <= read; 
		end if;
	when line_follow_till_white => if(a_white = '1') then nextstate <= line_follow; end if;
	when back_follow => if(all_black = '1') then nextstate <= read; end if;
	when line_follow_timeout => if(timeout = '1') then nextstate <= read; end if;
	when back_till_white => if(a_white = '1') then nextstate <= back_follow; end if;
	when back_till_black => if(a_black = '1') then nextstate <= back_follow; end if;
	when left_till_time => if(timeout = '1') then nextstate <= left_till_black; end if;
	when left_till_black => if(a_black = '1') then nextstate <= line_follow; end if;
	when right_till_time => if(timeout = '1') then nextstate <= right_till_black; end if;
	when right_till_black => if(a_black = '1') then nextstate <= line_follow; end if;
	when time_line => nextstate <= line_follow_timeout;
	when time_rot => 
		case uart_rec is
		when "001" =>  nextstate <= left_till_time; --L
		when "010" =>  nextstate <= right_till_time; --R
		when others => nextstate <= state;
		end case;
	when stop_till_u =>
		if(uart_avail = '1' and uart_rec = "11") --U
		then nextstate <= send_C_after_stop; 
		end if;
	when stop_forever => nextstate <= stop_forever; --Only way out is a reset
	when read => if(uart_avail = '1') then nextstate <= send_C; end if;
	end case;
	end process;

end behaviour;		
