--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:53:01 04/30/2019
-- Design Name:   
-- Module Name:   C:/Users/dstijns/EPO2/controller_tb.vhd
-- Project Name:  EPO2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: controller
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY controller_tb IS
END controller_tb;
 
ARCHITECTURE behavior OF controller_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT controller
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         sensor_l : IN  std_logic;
         sensor_m : IN  std_logic;
         sensor_r : IN  std_logic;
         motor_l_reset : OUT  std_logic;
         motor_l_move : OUT  std_logic;
         motor_l_direction : OUT  std_logic;
         motor_r_reset : OUT  std_logic;
         motor_r_move : OUT  std_logic;
         motor_r_direction : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal sensor_l : std_logic := '0';
   signal sensor_m : std_logic := '0';
   signal sensor_r : std_logic := '0';
   signal count_in : std_logic_vector(19 downto 0) := (others => '0');

 	--Outputs
   signal count_reset : std_logic;
   signal motor_l_reset : std_logic;
   signal motor_l_move : std_logic;
   signal motor_l_direction : std_logic;
   signal motor_r_reset : std_logic;
   signal motor_r_move : std_logic;
   signal motor_r_direction : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: controller PORT MAP (
          clk => clk,
          reset => reset,
          sensor_l => sensor_l,
          sensor_m => sensor_m,
          sensor_r => sensor_r,
          count_in => count_in,
          count_reset => count_reset,
          motor_l_reset => motor_l_reset,
          motor_l_move => motor_l_move,
          motor_l_direction => motor_l_direction,
          motor_r_reset => motor_r_reset,
          motor_r_move => motor_r_move,
          motor_r_direction => motor_r_direction
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		count_in <= std_logic_vector(unsigned(count_in) + 1);
		if(count_reset = '1') then count_in <= (others => '0'); end if;
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
		sensor_l <= '0';
		sensor_m <= '0';
		sensor_r <= '0';
		
		wait for 100 ns;

		sensor_l <= '1';
		sensor_m <= '0';
		sensor_r <= '0';
		
		wait for 100 ns;

		sensor_l <= '0';
		sensor_m <= '1';
		sensor_r <= '0';
		
		wait for 100 ns;

		sensor_l <= '1';
		sensor_m <= '1';
		sensor_r <= '0';
		
		wait for 100 ns;

		sensor_l <= '0';
		sensor_m <= '0';
		sensor_r <= '1';
		
		wait for 100 ns;

		sensor_l <= '1';
		sensor_m <= '0';
		sensor_r <= '1';
		
		wait for 100 ns;

		sensor_l <= '0';
		sensor_m <= '1';
		sensor_r <= '1';
		
		wait for 100 ns;

		sensor_l <= '1';
		sensor_m <= '1';
		sensor_r <= '1';
		
		wait for 100 ns;

      wait;
   end process;

END;
