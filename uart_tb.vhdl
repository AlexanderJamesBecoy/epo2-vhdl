library ieee;
use ieee.std_logic_1164.all;

entity uart_tb is
end uart_tb;

architecture behaviour of uart_tb is
signal clk,reset,rx,tx,write_data,read_data,data_avail: std_logic;
signal data_in, data_out: std_logic_vector(7 downto 0);
begin
	uut: entity work.uart
		port map(clk,reset,rx,tx,data_in,data_out,write_data,read_data,data_avail);
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

		data_in <= "01101001";
		write_data <= '1';
		read_data <= '1'; 

		wait for 20 ns;
		write_data <= '0';

		rx <= '0';
		wait for 104 us; --1/9600 seconds

		rx <= '0';
		wait for 104 us;
		rx <= '1';
		wait for 104 us;
		rx <= '1';
		wait for 104 us;
		rx <= '0';
		wait for 104 us;
		rx <= '1';
		wait for 104 us;
		rx <= '0';
		wait for 104 us;
		rx <= '0';
		wait for 104 us;
		rx <= '1';

		wait for 104 us;
		rx <= '1';

		read_data <= '0';

		wait for 200 us;

		rx <= '0';
		wait for 104 us;

		rx <= '1';
		wait for 104 us;
		rx <= '1';
		wait for 104 us;
		rx <= '1';
		wait for 104 us;
		rx <= '0';
		wait for 104 us;
		rx <= '1';
		wait for 104 us;
		rx <= '0';
		wait for 104 us;
		rx <= '0';
		wait for 104 us;
		rx <= '1';

		wait for 104 us;
		rx <= '1';

		read_data <= '1';
		wait for 20 ns;
		read_data <= '0';

		wait;
	end process;
end behaviour;
