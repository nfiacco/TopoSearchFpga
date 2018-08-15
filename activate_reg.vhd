----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:11:00 05/23/2014 
-- Design Name: 
-- Module Name:    activate_reg - Behavioral 
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

entity generic_activate_register is
    Port ( data_in : in  STD_LOGIC_VECTOR (255 downto 0);
           clr : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (255 downto 0));
end generic_activate_register;

architecture Behavioral of generic_activate_register is
signal data : STD_LOGIC_VECTOR(255 downto 0) := (others => '0');
begin

data_process: process(data_in, clr)
begin

if clr = '1' then
	data <= (others => '0');

else
	for i in 0 to 255 loop

	data(i) <= (data(i) and '0') or data_in(i);
	
	end loop;
	
end if;

end process;

data_out <= data;

end Behavioral;

