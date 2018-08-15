----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:08:44 05/23/2014 
-- Design Name: 
-- Module Name:    generic_decrementer - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity generic_decrementer is
    
	 Generic (
			  bit_width : Natural := 8);
	 
	 Port ( data_in : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
			  en : in STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (bit_width-1 downto 0));
			  
end generic_decrementer;

architecture Behavioral of generic_decrementer is

begin

count_process: process(en, data_in)
begin

if rising_edge(en) then
	
	data_out <= std_logic_vector(to_unsigned((to_integer(unsigned(data_in))- 1),bit_width));

else data_out <= data_in;

end if;

end process;

end Behavioral;

