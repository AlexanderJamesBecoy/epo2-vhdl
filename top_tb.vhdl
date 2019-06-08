--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:24:48 04/30/2019
-- Design Name:   
-- Module Name:   C:/Users/dstijns/EPO2/top_tb.vhd
-- Project Name:  EPO2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
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
--USE ieee.numeric_std.ALL;
 
ENTITY top_tb IS
END top_tb;
 
ARCHITECTURE behavior OF top_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         sensor : IN  std_logic_vector(2 downto 0);
         lmotor : OUT  std_logic;
         rmotor : OUT  std_logic;
         tx : OUT  std_logic;
         rx : IN  std_logic;
         sw : IN  std_logic_vector(7 downto 0);
         btn : IN  std_logic_vector(1 downto 0);
         led : OUT  std_logic_vector(7 downto 0);
         an : OUT  std_logic_vector(3 downto 0);
         sseg : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal sensor : std_logic_vector(2 downto 0) := (others => '0');
   signal rx : std_logic := '0';
   signal sw : std_logic_vector(7 downto 0) := (others => '0');
   signal btn : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal lmotor : std_logic;
   signal rmotor : std_logic;
   signal tx : std_logic;
   signal led : std_logic_vector(7 downto 0);
   signal an : std_logic_vector(3 downto 0);
   signal sseg : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          clk => clk,
          reset => reset,
          sensor => sensor,
          lmotor => lmotor,
          rmotor => rmotor,
          tx => tx,
          rx => rx,
          sw => sw,
          btn => btn,
          led => led,
          an => an,
          sseg => sseg
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
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
		sensor <= "000";
		wait for 1 ms;
		sensor <= "100";
		wait for 30 ms;
		sensor <= "010";

      wait;
   end process;

END;
