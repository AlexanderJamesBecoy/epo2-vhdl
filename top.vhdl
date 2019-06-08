----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:21:38 04/26/2019 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
	port ( clk : in std_logic;
	       reset : in std_logic;
			 sensor : in std_logic_vector(2 downto 0);
	       lmotor, rmotor : out std_logic;
			 tx : out std_logic;
			 rx : in std_logic;
			 sw : in std_logic_vector(7 downto 0);
			 btn : in std_logic_vector(1 downto 0);
			 led : out std_logic_vector(7 downto 0);
			 an : out std_logic_vector(3 downto 0);
			 sseg : out std_logic_vector(7 downto 0)
			 );
end top;

architecture structural of top is
signal tcount : std_logic_vector(19 downto 0);
signal linel, linem, liner : std_logic;
signal motor_l_rst, motor_l_dir, motor_l_mov : std_logic;
signal motor_r_rst, motor_r_dir, motor_r_mov : std_logic;
signal timebase_rst : std_logic;
begin
	timebase : entity work.timebase
		port map(clk, timebase_rst, tcount);
	linebuff : entity work.inputbuffer
		port map(clk, reset, sensor(2), sensor(1), sensor(0), linel, linem, liner);
	motor_l : entity work.motorcontrol
		port map(clk, motor_l_rst, motor_l_dir, motor_l_mov, tcount, lmotor);
	motor_r : entity work.motorcontrol
		port map(clk, motor_r_rst, motor_r_dir, motor_r_mov, tcount, rmotor);
	line_follower : entity work.line_follower
		port map(clk, reset, linel, linem, liner, tcount, timebase_rst, motor_l_rst, motor_l_mov, motor_l_dir, motor_r_rst, motor_r_mov, motor_r_dir);
	
	led <= (0 => tcount(19), 1 => linel, 2 => linem, 3 => liner, others => '1');
	tx <= '0';
	an <= (others => '0');
	sseg <= (others => '0');
end structural;

