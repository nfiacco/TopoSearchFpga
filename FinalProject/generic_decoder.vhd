----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nicholas Fiacco
-- 
-- Create Date:    14:35:45 05/23/2014 
-- Design Name: 
-- Module Name:    address_decoder - Behavioral 
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

entity address_decoder is

    Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
			  en : in STD_LOGIC;
           decoded_out : out  STD_LOGIC_VECTOR (255 downto 0));
			  
end address_decoder;

architecture Behavioral of address_decoder is

begin

decode: process(en, addr)
begin
decoded_out <= (others => '0');

	if en = '1' then
		decoded_out(to_integer(unsigned(addr))) <= '1';
	end if;

end process;

end Behavioral;

