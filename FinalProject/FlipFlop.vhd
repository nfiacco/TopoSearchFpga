----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nicholas Fiacco
-- 
-- Create Date:    13:55:25 05/23/2014 
-- Design Name: 
-- Module Name:    FlipFlop - Behavioral 
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

entity FlipFlop is
			  
    Port ( data_in : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           load : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           data_out : out  STD_LOGIC;
			  not_data_out : out STD_LOGIC);
end FlipFlop;

architecture Behavioral of FlipFlop is
signal data : STD_LOGIC := '0';
begin

Clk_process: process(clk)
begin

	if rising_edge(clk) then
		if clr = '1' then
			data <= '0';
		elsif load = '1' then
			data <= data_in;
		end if;
	end if;

end process;

data_out <= data;
not_data_out <= not data;

end Behavioral;
