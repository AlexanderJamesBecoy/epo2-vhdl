library IEEE;
-- Hier komen de gebruikte libraries:
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timebase is
	port (	clk		: in	std_logic;
		reset		: in	std_logic;

		count_out	: out	std_logic_vector (19 downto 0)
	);
end entity timebase;

architecture behavioural of timebase is
signal treg : unsigned(19 downto 0);
begin
	process
	begin
		wait until rising_edge(clk);
	if(reset='1') then
		treg <= (others => '0');
	else
		treg <= treg + 1; -- counting up at 50 MHz
		if(treg = "11111111111111111111111111111111111") then
			treg <= (others => '0'); -- overflow
		end if;
	end if;
	end process;
	count_out <= std_logic_vector(treg);
end behavioural;
