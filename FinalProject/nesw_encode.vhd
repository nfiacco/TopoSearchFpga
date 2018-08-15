----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:49:39 05/23/2014 
-- Design Name: 
-- Module Name:    nesw_encode - Behavioral 
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

entity nesw_encode is
    Port ( nesw : in  STD_LOGIC_VECTOR (3 downto 0);
           output : out  STD_LOGIC_VECTOR (1 downto 0));
end nesw_encode;

architecture Behavioral of nesw_encode is

begin

combi: process(nesw)
begin
output <= "00";

	case nesw is
		
		when "0001" =>
			output <= "00";
		
		when "0010" =>
			output <= "01";
		
		when "0100" =>
			output <= "10";
		
		when "1000" =>
			output <= "11";
		
		when others =>
	
	end case;
	
end process;

end Behavioral;

