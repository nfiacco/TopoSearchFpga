----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nicholas Fiacco
-- 
-- Create Date:    14:50:31 05/23/2014 
-- Design Name: 
-- Module Name:    address_mux - Behavioral 
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

entity data_mux is
    Port ( data_in : in  STD_LOGIC_VECTOR(255 downto 0);
			  addr : in STD_LOGIC_VECTOR(7 downto 0);
           data_out : out  STD_LOGIC);
end data_mux;

architecture Behavioral of data_mux is

begin

data_out <= data_in(to_integer(unsigned(addr)));

end Behavioral;
