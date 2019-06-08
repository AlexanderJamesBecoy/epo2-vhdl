library IEEE;
-- Hier komen de gebruikte libraries:
use ieee.std_logic_1164.all;

entity inputbuffer is
	port (	clk		: in	std_logic;
		reset		: in	std_logic;

		sensor_l_in	: in	std_logic;
		sensor_m_in	: in	std_logic;
		sensor_r_in	: in	std_logic;

		sensor_l_out	: out	std_logic;
		sensor_m_out	: out	std_logic;
		sensor_r_out	: out	std_logic
		
	);
end entity inputbuffer;

architecture behaviour of inputbuffer is
signal ff1, ff2 : std_logic_vector(2 downto 0);
begin
	process
	begin
		wait until rising_edge(clk);
		if(reset = '1') then
			ff1 <= "000";
			ff2 <= "000";
		else
			ff1 <= (0 => sensor_l_in, 1 => sensor_m_in, 2 => sensor_r_in);
			ff2 <= ff1;
		end if;
	end process;
	
	sensor_r_out <= ff2(0);
	sensor_m_out <= ff2(1);
	sensor_l_out <= ff2(2);
	
end behaviour;
