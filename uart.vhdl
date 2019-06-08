library ieee;
use ieee.std_logic_1164.all;

entity uart is
	port (
		clk, reset: in std_logic;
		rx: in std_logic; --input bit stream
		tx: out std_logic; --output bit stream
		tx_in: in std_logic_vector(7 downto 0); --byte to be sent
		rx_out: out std_logic_vector(7 downto 0); --received byte
		write_data: in std_logic; --write to transmitter buffer 
		read_data: in std_logic; --read from receiver buffer 
		data_avail: out std_logic --data available for reading
	);
end uart;

architecture behaviour of uart is
signal s_tick, rx_done_tick, tx_done_tick, tx_start: std_logic;
signal dout, din: std_logic_vector(7 downto 0);
begin
	baud_gen: entity work.baud_gen
		port map(clk,reset,s_tick);
	uart_rec: entity work.uart_rx
		port map(clk,reset,rx,s_tick,rx_done_tick,dout);
	uart_trans: entity work.uart_tx
		port map(clk,reset,tx_start,s_tick,din,tx_done_tick,tx);
	rx_buf: entity work.buf_reg
		port map(clk,reset,read_data,rx_done_tick,dout,rx_out,data_avail);
	tx_buf: entity work.buf_reg
		port map(clk,reset,tx_done_tick,write_data,tx_in,din,tx_start);
end behaviour;
