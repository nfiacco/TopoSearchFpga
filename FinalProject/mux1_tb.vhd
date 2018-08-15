--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:50:51 05/25/2014
-- Design Name:   
-- Module Name:   O:/Documents/Xilinx/FinalProject/mux1_tb.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: location_mux
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
use work.data_bus4bit.all;

ENTITY mux1_tb IS
END mux1_tb;
 
ARCHITECTURE behavior OF mux1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT location_mux
    PORT(
         data_in : IN  data_array4bit;
         addr : IN  std_logic_vector(7 downto 0);
         data_out : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal data_in : data_array4bit := (others => "0000");
   signal addr : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal data_out : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: location_mux PORT MAP (
          data_in => data_in,
          addr => addr,
          data_out => data_out
        );


 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	

      -- insert stimulus here 
		data_in(1) <= "1111";
		addr <= "00000001";
		
		
      wait;
   end process;

END;
