----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nicholas Fiacco
-- 
-- Create Date:    12:48:00 05/23/2014 
-- Design Name: 
-- Module Name:    generic_comparator - Behavioral 
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

entity generic_comparator is
    
	 Generic (
			  bit_width : Natural := 8);
	 
	 Port ( A : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           B : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
			  en : in STD_LOGIC;
			  equal : out  STD_LOGIC);
			  
end generic_comparator;

architecture Behavioral of generic_comparator is

begin

combi_process: process(A, B, en)
begin

equal <= '0';
if en = '1' then

	if unsigned(A) = unsigned(B) then

			equal <= '1';

	end if;

end if;

end process;

end Behavioral;

