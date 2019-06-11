library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mine_sense is
	generic(max_time: integer);
	port(
		clk,reset: in std_logic;
		mine_raw: in std_logic;
		mine_out: out std_logic;

		time_reset: out std_logic;
		time: in std_logic_vector(16 downto 0)
	);
end mine_sense;

architecture beh of mine_sense is
type statetype is (wait_on_1, start_time, mine_found, timeout);
signal state, nextstate: statetype;
begin
	seq: process
	begin
		wait until rising_edge(clk);
		if(reset = '1') then
			state <= wait_on_1;
		else
			state <= nextstate;
		end if;
	end process;

	comb: process(clk)
	begin
		--default next state is current state
		nextstate <= state;
		case state is
		when wait_on_1 =>
			time_reset <= '1';
			mine_out <= '0';
			if(mine_raw = '1') then
				nextstate <= start_time;
			end if;
		when start_time =>
			time_reset <= '0';
			mine_out <= '0';
			if(unsigned(time) = max_time) then nextstate <= timeout;
			elsif(mine_raw = '0') then nextstate <= mine_found;
			end if;
		when mine_found =>
			time_reset <= '1';
			mine_out <= '1';
			if(mine_raw = '0') then
				nextstate <= wait_on_1;
			end if;
		when timeout =>
			time_reset <= '1';
			mine_out <= '0';
			if(mine_raw = '0') then
				nextstate <= wait_on_1;
			end if;
		end case;
	end process;
end beh;
