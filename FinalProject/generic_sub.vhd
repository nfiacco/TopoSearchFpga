----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:07:07 05/23/2014 
-- Design Name: 
-- Module Name:    generic_add_sub - Behavioral 
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

entity generic_sub is

	 Generic ( bit_width : Natural := 8);

    Port (
			  A : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           B : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           output : out  STD_LOGIC_VECTOR (bit_width-1 downto 0)
			  );
			  
end generic_sub;

architecture Behavioral of generic_sub is

begin

combi: process(A, B)
begin

output <= std_logic_vector(unsigned(A)- unsigned(B));

end process;

end Behavioral;
