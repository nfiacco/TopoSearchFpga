----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nicholas Fiacco
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

entity generic_add_sub is

	 Generic ( bit_width : Natural := 8);

    Port (
			  A : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           B : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
			  add : in STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (bit_width-1 downto 0)
			  );
			  
end generic_add_sub;

architecture Behavioral of generic_add_sub is

begin

combi: process(A, B, add)
begin

	if add = '1' then
		output <= std_logic_vector(unsigned(A)+ unsigned(B));
	else
		output <= std_logic_vector(unsigned(A)- unsigned(B));
	end if;

end process;

end Behavioral;

