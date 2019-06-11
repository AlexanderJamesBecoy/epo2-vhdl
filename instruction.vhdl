library ieee;
use ieee.std_logic_1164.all;

entity inst_decode is
	port(
		x: in std_logic_vector(7 downto 0);
		y: out std_logic_vector(2 downto 0)
	);
end;

architecture beh of inst_decode is
begin
	with x select y <=
		"000" when "01010011", --S
		"001" when "01001100", --L
		"010" when "01010010", --R
		"011" when "01010101", --U
		"100" when "01010001", --Q
		"---" when others;
end beh;

library ieee;
use ieee.std_logic_1164.all;

entity resp_encode is
	port(
		x: in std_logic_vector(1 downto 0);
		y: out std_logic_vector(7 downto 0)
	);
end;

architecture beh of resp_encode is
begin
	with x select y <=
		"01000010" when "00", --B
		"01000011" when "01", --C
		"01001101" when "10", --M
		"--------" when others;
end beh;
