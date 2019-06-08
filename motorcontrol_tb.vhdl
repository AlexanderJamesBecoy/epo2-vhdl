--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:33:04 04/30/2019
-- Design Name:   
-- Module Name:   C:/Users/dstijns/EPO2/motorcontrol_tb.vhd
-- Project Name:  EPO2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: motorcontrol
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY motorcontrol_tb IS
END motorcontrol_tb;
 
ARCHITECTURE behavior OF motorcontrol_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT motorcontrol
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         direction : IN  std_logic;
         motor_move : IN  std_logic;
         count_in : IN  std_logic_vector(19 downto 0);
         pwm : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal direction : std_logic := '0';
   signal motor_move : std_logic := '0';
   signal count_in : std_logic_vector(19 downto 0) := (others => '0');

 	--Outputs
   signal pwm : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: motorcontrol PORT MAP (
          clk => clk,
          reset => reset,
          direction => direction,
          motor_move => motor_move,
          count_in => count_in,
          pwm => pwm
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		count_in <= std_logic_vector(unsigned(count_in) + 1);
		if(reset = '1') then count_in <= (others => '0'); end if;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset <= '1';
      wait for 100 ns;	
		reset <= '0';

      wait for clk_period*10;

      -- insert stimulus here 
		direction <= '1';
		motor_move <= '1';
		
		wait for 20 ms;
		reset <= '1';
      wait for 100 ns;	
		reset <= '0';
		direction <= '0';
		motor_move <= '1';
		
		wait for 20 ms;
		reset <= '1';
      wait for 100 ns;	
		reset <= '0';
		direction <= '0';
		motor_move <= '0';

      wait;
   end process;

END;
