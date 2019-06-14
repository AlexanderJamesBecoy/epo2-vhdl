library IEEE;
-- Hier komen de gebruikte libraries:
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity motorcontrol is
	generic(pulse_width: integer);
	port (	clk		: in	std_logic;
		reset		: in	std_logic;
		motorvect : in std_logic_vector(1 downto 0);
		--2=direction 1=move
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
	
	comb : process(state, count_in, motorvect)
	begin
	case state is
	when pwm_on =>
		pwm <= '1';
		next_state <= pwm_on;
		if(motorvect(0) = '0') then
			if(unsigned(count_in) >= pulse_width*3) then
				next_state <= pwm_off;
			end if;
		else
			if(motorvect(1) = '0' and unsigned(count_in) >= pulse_width*2) then
				next_state <= pwm_off;
			elsif(motorvect(1) = '1' and unsigned(count_in) >= pulse_width*4) then
				next_state <= pwm_off;
			end if;
		end if;
	when pwm_off =>
		pwm <= '0';
		next_state <= pwm_off;
	end case;
	end process;
	
	-- reset
	int_reset <= '1' when unsigned(count_in) = pulse_width*20 else '0';
	count_rst <= int_reset or reset;
end behaviour;
