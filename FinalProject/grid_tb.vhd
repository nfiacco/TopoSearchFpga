--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:43:41 05/25/2014
-- Design Name:   
-- Module Name:   O:/Documents/Xilinx/FinalProject/grid_tb.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CellGridTop
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
 
ENTITY grid_tb IS
END grid_tb;
 
ARCHITECTURE behavior OF grid_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CellGridTop
    PORT(
         clk : IN  std_logic;
         rxd : IN  std_logic_vector(7 downto 0);
         rx_done_tick : IN  std_logic;
         start_stop : out STD_LOGIC;
         vga_data : OUT  std_logic_vector(8 downto 0);
         vga_addr : IN  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rxd : std_logic_vector(7 downto 0) := (others => '0');
   signal rx_done_tick : std_logic := '0';
   signal vga_addr : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal start_stop : std_logic;
   signal vga_data : std_logic_vector(8 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CellGridTop PORT MAP (
          clk => clk,
          rxd => rxd,
          rx_done_tick => rx_done_tick,
          start_stop => start_stop,
          vga_data => vga_data,
          vga_addr => vga_addr
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
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here
		rxd <= "01010111";
		rx_done_tick<= '1';
		wait for clk_period;
		rx_done_tick <= '0';
		wait for clk_period;
		rxd <= "00000001";
		rx_done_tick <= '1';
		wait for clk_period;
		rx_done_tick <= '0';
		wait for clk_period;
		rxd <= "00000001";
		rx_done_tick <= '1';
		wait for clk_period;
		rx_done_tick <= '0';
		wait for clk_period;
		rxd <= "11111111";
		rx_done_tick <= '1';
		wait for clk_period;
		rx_done_tick <= '0';
		wait for clk_period;
		wait for clk_period;

		rxd <= "00000000";
		vga_addr <= "00000001";
		
		rxd <= "01010111";
		rx_done_tick<= '1';
		wait for clk_period;
		rx_done_tick <= '0';
		wait for clk_period;
		rxd <= "00000011";
		rx_done_tick <= '1';
		wait for clk_period;
		rx_done_tick <= '0';
		wait for clk_period;
		rxd <= "00000111";
		rx_done_tick <= '1';
		wait for clk_period;
		rx_done_tick <= '0';
		wait for clk_period;
		rxd <= "11111111";
		rx_done_tick <= '1';
		wait for clk_period;
		rx_done_tick <= '0';
		wait for clk_period;
		wait for clk_period;
		
		
		rxd <= "01010111";
		rx_done_tick<= '1';
		wait for clk_period;
		rx_done_tick <= '0';
		wait for clk_period;
		rxd <= "00000100";
		rx_done_tick <= '1';

      wait;
   end process;

END;
