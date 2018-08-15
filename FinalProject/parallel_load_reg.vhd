----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nicholas Fiacco
-- 
-- Create Date:    12:40:33 05/23/2014 
-- Design Name: 
-- Module Name:    parallel_load_reg - Behavioral 
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

entity parallel_load_reg is

	 Generic (
			  bit_width : Natural := 8);
			  
    Port ( data_in : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           clk : in  STD_LOGIC;
           load : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (bit_width-1 downto 0));
			  
end parallel_load_reg;

architecture Behavioral of parallel_load_reg is
signal data : STD_LOGIC_VECTOR(bit_width-1 downto 0) := (others=>'0');
begin

Clk_process: process(clk)
begin

	if rising_edge(clk) then
		if clr = '1' then
			data <= (others =>  '0');
		elsif load = '1' then
			data <= data_in;
		end if;
	end if;

end process;

data_out <= data;

end Behavioral;

