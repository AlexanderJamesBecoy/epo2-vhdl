library IEEE;
-- Hier komen de gebruikte libraries:
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity back_follower is
	port (	clk			: in	std_logic;
		reset			: in	std_logic;

		sensor_l		: in	std_logic;
		sensor_m		: in	std_logic;
		sensor_r		: in	std_logic;

		motor_l_move	   : out std_logic;
		motor_l_direction	: out	std_logic;

		motor_r_move	   : out std_logic;
		motor_r_direction	: out	std_logic
	);
			
			
end entity back_follower;

architecture behaviour of back_follower is
type headingtype is (left, right, hardleft, hardright, straight, stop);
signal heading, nextheading : headingtype;
signal motorvect : std_logic_vector(3 downto 0);
signal sensorvect : std_logic_vector(2 downto 0);
begin
	seq : process
	begin
		wait until rising_edge(clk);
		
		if (reset = '1') then
			heading <= stop;
		else
			heading <= nextheading;
		end if;
	end process;
	
	comb : process
	begin
	-- All states are just copies of each other with minor adjustments
	if(heading = stop ) then
	case sensorvect is
		when "000" => nextheading <= straight;
		when "001" => nextheading <= left;
		when "010" => nextheading <= straight;
		when "011" => nextheading <= hardleft;
		when "100" => nextheading <= right;
		when "101" => nextheading <= straight;
		when "110" => nextheading <= hardright;
		when "111" => nextheading <= stop;
		when others => nextheading <= stop;
	end case;
	elsif(heading = right ) then
	case sensorvect is
		when "000" => nextheading <= straight;
		when "001" => nextheading <= left;
		when "010" => nextheading <= straight;
		when "011" => nextheading <= hardleft;
		when "100" => nextheading <= right;
		when "101" => nextheading <= straight;
		when "110" => nextheading <= hardright;
		when "111" => nextheading <= stop;
		when others => nextheading <= stop;
	end case;
	elsif(heading = hardright ) then
	case sensorvect is
		when "000" => nextheading <= straight;
		when "001" => nextheading <= left;
		when "010" => nextheading <= straight;
		when "011" => nextheading <= hardleft;
		when "100" => nextheading <= right;
		when "101" => nextheading <= straight;
		when "110" => nextheading <= hardright;
		--when "111" => nextheading <= stop;
		when others => nextheading <= stop;
	end case;
	elsif(heading = left ) then
	case sensorvect is
		when "000" => nextheading <= straight;
		when "001" => nextheading <= left;
		when "010" => nextheading <= straight;
		when "011" => nextheading <= hardleft;
		when "100" => nextheading <= right;
		when "101" => nextheading <= straight;
		when "110" => nextheading <= hardright;
		when "111" => nextheading <= stop;
		when others => nextheading <= stop;
	end case;
	elsif(heading = hardleft ) then
	case sensorvect is
		when "000" => nextheading <= straight;
		when "001" => nextheading <= left;
		when "010" => nextheading <= straight;
		when "011" => nextheading <= hardleft;
		when "100" => nextheading <= right;
		when "101" => nextheading <= straight;
		when "110" => nextheading <= hardright;
		--when "111" => nextheading <= stop;
		when others => nextheading <= stop;
	end case;
	elsif(heading = straight ) then
	case sensorvect is
		when "000" => nextheading <= straight;
		when "001" => nextheading <= left;
		when "010" => nextheading <= straight;
		when "011" => nextheading <= hardleft;
		when "100" => nextheading <= right;
		when "101" => nextheading <= straight;
		when "110" => nextheading <= hardright;
		when "111" => nextheading <= stop;
		when others => nextheading <= stop;
	end case;
	end if;
	end process;
	
	sensorvect(0) <= sensor_l;
	sensorvect(1) <= sensor_m;
	sensorvect(2) <= sensor_r;
	
	with heading select motorvect <=
		"1010" when straight,
		"0010" when left,
		"1000" when right,
		"1011" when hardleft,
		"1110" when hardright,
		"0000" when stop,
		"0000" when others;
		
	motor_l_move <= motorvect(0);
	motor_l_direction <= motorvect(1);
	motor_r_move <= motorvect(2);
	motor_r_direction <= not motorvect(3);
end behaviour;
