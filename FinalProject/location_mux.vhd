----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nicholas Fiacco
-- 
-- Create Date:    17:30:23 05/23/2014 
-- Design Name: 
-- Module Name:    location_mux - Behavioral 
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

use work.data_bus2bit.all;

entity location_mux is
    Port ( data_in : in  data_array2bit;
			  addr : in STD_LOGIC_VECTOR(7 downto 0);
           data_out : out  STD_LOGIC_VECTOR (1 downto 0));
end location_mux;

architecture Behavioral of location_mux is

begin

data_out <= data_in(to_integer(unsigned(addr)));

end Behavioral;
