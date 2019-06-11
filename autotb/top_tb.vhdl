library ieee;
use ieee.std_logic_1164.all;

entity top_tb is
end;

architecture beh of top_tb is
signal clk,reset: std_logic;
signal sensor: std_logic_vector(2 downto 0);
signal lmotor,rmotor,tx,rx,mine: std_logic;
signal sw: std_logic_vector(7 downto 0);
signal btn : std_logic_vector(1 downto 0);
signal led : std_logic_vector(7 downto 0);
signal an : std_logic_vector(3 downto 0);
signal sseg : std_logic_vector(7 downto 0);
begin
	uut: entity work.top
		port map(clk,reset,sensor,lmotor,rmotor,tx,rx,mine,sw,btn,led,an,sseg);
	clk_tick: process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;

	stim: process
	begin
		reset <= '1';
		wait for 100 ns;
		reset <= '0';
		sensor <= "010";

		--L=01001100
		rx <= '0'; --start bit
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1'; --stop bit
		wait for 104 us; -- 1/9600 seconds

		wait for 500 ms;

		sensor <= "000"; -- crossing

		wait for 400 ms;

		sensor <= "111"; -- turn left
		wait for 100 ms;
		sensor <= "010";

		--S=01010011
		rx <= '0'; --start bit
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1'; --stop bit
		wait for 104 us; -- 1/9600 seconds

		wait for 500 ms;

		sensor <= "000"; -- crossing

		wait for 400 ms;

		sensor <= "010";

		--L=01001100
		rx <= '0'; --start bit
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1'; --stop bit
		wait for 104 us; -- 1/9600 seconds

		wait for 500 ms;

		sensor <= "000"; -- crossing

		wait for 400 ms;

		sensor <= "111"; -- turn left
		wait for 100 ms;
		sensor <= "010";

		--U=01010101
		rx <= '0'; --start bit
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1'; --stop bit
		wait for 104 us; -- 1/9600 seconds

		wait for 500 ms;

		sensor <= "111"; -- Edge

		wait for 200 ms;

		sensor <= "010";

		--S=01010011
		rx <= '0'; --start bit
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1'; --stop bit
		wait for 104 us; -- 1/9600 seconds

		wait for 500 ms;

		sensor <= "000"; -- crossing

		wait for 400 ms;

		sensor <= "010";

		--R=01010010
		rx <= '0'; --start bit
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1'; --stop bit
		wait for 104 us; -- 1/9600 seconds

		wait for 500 ms;

		sensor <= "000"; -- crossing

		wait for 400 ms;

		sensor <= "111"; -- turn right
		wait for 100 ms;
		sensor <= "010";

		mine <= '1'; -- Mine detected
		wait for 1.9 ms;
		mine <= '0';

		wait for 400 ms;


		--R=01010010
		rx <= '0'; --start bit
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1'; --stop bit
		wait for 104 us; -- 1/9600 seconds

		wait for 500 ms;

		sensor <= "000"; -- crossing

		wait for 400 ms;

		sensor <= "111"; -- turn right
		wait for 100 ms;
		sensor <= "010";

		--U=01010101
		rx <= '0'; --start bit
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1';
		wait for 104 us; -- 1/9600 seconds
		rx <= '0';
		wait for 104 us; -- 1/9600 seconds
		rx <= '1'; --stop bit
		wait for 104 us; -- 1/9600 seconds

		wait for 500 ms;

		sensor <= "000"; -- crossing

		wait for 200 ms;

		sensor <= "010";

		wait;
	end process;


end beh;
