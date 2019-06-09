library ieee;
use ieee.std_logic_1164.all;

entity mux2 is
	generic(width: integer);
	port(
		d0, d1: in std_logic_vector(width-1 downto 0);
		s: in std_logic;
		y: out std_logic_vector(width-1 downto 0)
	);
end;

architecture beh of mux2 is
begin
	y <= d1 when s='1' else d0;
end beh;

library ieee;
use ieee.std_logic_1164.all;

entity mux4 is
	generic(width: integer);
	port(
		d0, d1, d2, d3: in std_logic_vector(width-1 downto 0);
		s: in std_logic_vector(1 downto 0);
		y: out std_logic_vector(width-1 downto 0)
	);
end;

architecture beh of mux4 is
begin
	with s select y <=
		d1 when "01",
	 	d2 when "10",
	 	d3 when "11",
		d0 when others;
end beh;

library ieee;
use ieee.std_logic_1164.all;

entity mux8 is
	generic(width: integer);
	port(
		d0, d1, d2, d3, d4, d5, d6, d7: in std_logic_vector(width-1 downto 0);
		s: in std_logic_vector(2 downto 0);
		y: out std_logic_vector(width-1 downto 0)
	);
end;

architecture beh of mux8 is
begin
	with s select y <=
		d1 when "001",
	 	d2 when "010",
	 	d3 when "011",
	 	d4 when "100",
	 	d5 when "101",
	 	d6 when "110",
	 	d7 when "111",
		d0 when others;
end beh;
