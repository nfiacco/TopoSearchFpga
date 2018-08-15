----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nicholas Fiacco
-- 
-- Create Date:    13:15:48 05/23/2014 
-- Design Name: 
-- Module Name:    small_mux - Behavioral 
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

entity small_mux is

	 Generic ( bit_width : Natural := 8);
	 
    Port ( A : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           B : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           en : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (bit_width-1 downto 0));
end small_mux;

architecture Behavioral of small_mux is

begin

combi_process: process(A,B,en)
begin
	if en = '1' then
		data_out <= A;
	else data_out <= B;

	end if;
end process;
end Behavioral;

