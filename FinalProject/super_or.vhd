----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:13:11 05/23/2014 
-- Design Name: 
-- Module Name:    super_or - Behavioral 
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

entity super_or is

    Port ( input : in  STD_LOGIC_VECTOR (255 downto 0);
           output : out  STD_LOGIC);
			  
end super_or;

architecture Behavioral of super_or is
signal out_sig : STD_LOGIC := '0';
begin

combi_process: process(input)
begin
	out_sig <= '0';
	for i in 0 to 255 loop

		if input(i) = '1' then
			out_sig <= '1';
		end if;

	end loop;
end process;

output <= out_sig;

end Behavioral;

