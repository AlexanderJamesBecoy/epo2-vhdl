library IEEE;
-- Hier komen de gebruikte libraries:
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity line_follower is
	port (	clk		: in	std_logic;
		reset		: in	std_logic;

		sensorvect	: in	std_logic_vector(2 downto 0);
		-- MSB is left
		motorvect	: out 	std_logic_vector(3 downto 0)
		-- 4=left-direction 3=left-move 2=right-direction 1=right-move
	);
			
			
end entity line_follower;

architecture behaviour of line_follower is
type headingtype is (left, right, hardleft, hardright, straight, stop);
signal heading, nextheading : headingtype;
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
	
	comb : process(heading, sensorvect)
	begin
	--default
	nextheading <= stop;
	-- All states are just copies of each other with minor adjustments
	if(heading = stop ) then
	case sensorvect is
		when "000" => nextheading <= straight;
		when "001" => nextheading <= right;
		when "010" => nextheading <= straight;
		when "011" => nextheading <= hardright;
		when "100" => nextheading <= left;
		when "101" => nextheading <= straight;
		when "110" => nextheading <= hardleft;
		when "111" => nextheading <= stop;
		when others => nextheading <= stop;
	end case;
	elsif(heading = right ) then
	case sensorvect is
		when "000" => nextheading <= straight;
		when "001" => nextheading <= right;
		when "010" => nextheading <= straight;
		when "011" => nextheading <= hardright;
		when "100" => nextheading <= left;
		when "101" => nextheading <= straight;
		when "110" => nextheading <= hardleft;
		when "111" => nextheading <= stop;
		when others => nextheading <= right;
	end case;
	elsif(heading = hardright ) then
	case sensorvect is
		when "000" => nextheading <= straight;
		when "001" => nextheading <= right;
		when "010" => nextheading <= straight;
		when "011" => nextheading <= hardright;
		when "100" => nextheading <= left;
		when "101" => nextheading <= straight;
		when "110" => nextheading <= hardleft;
		--when "111" => nextheading <= stop;
		when others => nextheading <= hardright;
	end case;
	elsif(heading = left ) then
	case sensorvect is
		when "000" => nextheading <= straight;
		when "001" => nextheading <= right;
		when "010" => nextheading <= straight;
		when "011" => nextheading <= hardright;
		when "100" => nextheading <= left;
		when "101" => nextheading <= straight;
		when "110" => nextheading <= hardleft;
		when "111" => nextheading <= stop;
		when others => nextheading <= left;
	end case;
	elsif(heading = hardleft ) then
	case sensorvect is
		when "000" => nextheading <= straight;
		when "001" => nextheading <= right;
		when "010" => nextheading <= straight;
		when "011" => nextheading <= hardright;
		when "100" => nextheading <= left;
		when "101" => nextheading <= straight;
		when "110" => nextheading <= hardleft;
		--when "111" => nextheading <= stop;
		when others => nextheading <= hardleft;
	end case;
	elsif(heading = straight ) then
	case sensorvect is
		when "000" => nextheading <= straight;
		when "001" => nextheading <= right;
		when "010" => nextheading <= straight;
		when "011" => nextheading <= hardright;
		when "100" => nextheading <= left;
		when "101" => nextheading <= straight;
		when "110" => nextheading <= hardleft;
		when "111" => nextheading <= stop;
		when others => nextheading <= straight;
	end case;
	end if;
	end process;
	
	with heading select motorvect <=
		"1101" when straight,
		"-001" when left,
		"11-0" when right,
		"0101" when hardleft,
		"1111" when hardright,
		"-0-0" when stop,
		"-0-0" when others;
	--N.B. due to the robot's design, right_direction (bit 2) is inverted
	-- 4=left-direction 3=left-move 2=right-direction 1=right-move
end behaviour;
