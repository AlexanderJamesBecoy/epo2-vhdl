library IEEE;
-- Hier komen de gebruikte libraries:
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity motorcontrol is
	port (	clk		: in	std_logic;
		reset		: in	std_logic;
		direction	: in	std_logic;
		motor_move : in std_logic;
		count_in	: in	std_logic_vector (19 downto 0);
		count_rst	: out	std_logic;

		pwm		: out	std_logic
	);
end entity motorcontrol;

architecture behaviour of motorcontrol is
type statetype is (pwm_off, pwm_on);
signal state, next_state: statetype;
signal int_reset: std_logic;
begin
	seq : process
	begin
		wait until rising_edge(clk);
	if(reset = '1' or int_reset = '1') then
		state <= pwm_on;
	else
		state <= next_state;
	end if;
	end process;
	
	comb : process(state, count_in)
	begin
	case state is
	when pwm_on =>
		pwm <= '1';
		next_state <= pwm_on;
		if(motor_move = '0') then
			if(unsigned(count_in) = 75000) then
				next_state <= pwm_off;
			end if;
		else
			if(direction = '0' and unsigned(count_in) = 50000) then
				next_state <= pwm_off;
			elsif(direction = '1' and unsigned(count_in) = 100000) then
				next_state <= pwm_off;
			end if;
		end if;
	when pwm_off =>
		pwm <= '0';
		next_state <= pwm_off;
	end case;
	end process;
	
	-- reset
	int_reset <= '1' when unsigned(count_in) = 1000000 else '0';
	count_rst <= int_reset;
end behaviour;
