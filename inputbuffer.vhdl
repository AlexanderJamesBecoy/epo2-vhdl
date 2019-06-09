library IEEE;
-- Hier komen de gebruikte libraries:
use ieee.std_logic_1164.all;

entity inputbuffer is
	generic(width: integer);
	port (	clk		: in	std_logic;
		reset		: in	std_logic;
		x		: in	std_logic_vector(width-1 downto 0);
		y		: out	std_logic_vector(width-1 downto 0)
	);
end entity inputbuffer;

architecture behaviour of inputbuffer is
signal ff1, ff2 : std_logic_vector(width-1 downto 0);
begin
	process
	begin
		wait until rising_edge(clk);
		if(reset = '1') then
			ff1 <= (others => '0');
			ff2 <= (others => '0');
		else
			ff1 <= x;
			ff2 <= ff1;
		end if;
	end process;
	
	y <= ff2;	
end behaviour;

library IEEE;
-- Hier komen de gebruikte libraries:
use ieee.std_logic_1164.all;

entity inputbuffer1 is
	port (	clk		: in	std_logic;
		reset		: in	std_logic;
		x		: in	std_logic;
		y		: out	std_logic
	);
end entity inputbuffer1;

architecture behaviour of inputbuffer1 is
signal ff1, ff2 : std_logic;
begin
	process
	begin
		wait until rising_edge(clk);
		if(reset = '1') then
			ff1 <= '0';
			ff2 <= '0';
		else
			ff1 <= x;
			ff2 <= ff1;
		end if;
	end process;
	
	y <= ff2;	
end behaviour;
