----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nicholas Fiacco
-- 
-- Create Date:    15:54:48 04/28/2014 
-- Design Name: 
-- Module Name:    BaudRateGen - Behavioral 
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

entity clock25div is
	 
    Port ( 
			  clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           output : out  STD_LOGIC
	 );
	 
end clock25div;

architecture Behavioral of clock25div is

constant M : integer := 4; --ClockDivRate

signal count : integer range 0 to 4:= 0;
begin

counter: process(clk)
begin

if rising_edge(clk) then
	
	if en = '1' then
	
		if count = M-1 then
			count <= 0;
		
		else
			count <= count + 1;
		
		end if;
		
	end if;
	
end if;

end process;

output <= '1' when count = (M-1) else '0';

end Behavioral;