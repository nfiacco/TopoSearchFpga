----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nicholas Fiacco
-- 
-- Create Date:    13:22:46 05/23/2014 
-- Design Name: 
-- Module Name:    UnitCell - Behavioral 
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

entity UnitCell is

    Port ( clk : in  STD_LOGIC;
			  slow_clk : in STD_LOGIC;
			  prgm : in STD_LOGIC;
			  reset : in STD_LOGIC;
           N : in  STD_LOGIC;
           E : in  STD_LOGIC;
           S : in  STD_LOGIC;
           W : in  STD_LOGIC;
           delay : in  STD_LOGIC_VECTOR (7 downto 0);
			  start : in STD_LOGIC;
           stop : in  STD_LOGIC;
			  on_path : in STD_LOGIC;
			  data_out : out  STD_LOGIC_VECTOR (8 downto 0);
           prev_location : out  STD_LOGIC_VECTOR (1 downto 0);
			  activate_adj : out STD_LOGIC);
			  
end UnitCell;

architecture Behavioral of UnitCell is

Component parallel_load_reg

	 Generic (
			  bit_width : Natural := 8);
			  
    Port ( data_in : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           clk : in  STD_LOGIC;
           load : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (bit_width-1 downto 0));

end Component;

Component generic_comparator 

	 Generic (
			  bit_width : Natural := 8);
	 
	 Port ( A : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           B : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
			  en : in STD_LOGIC;
			  equal : out  STD_LOGIC);
			  
end Component;

Component generic_sub

	Generic ( bit_width : Natural := 8);
	
	Port ( A : in STD_LOGIC_VECTOR(bit_width-1 downto 0);
			 B : in STD_LOGIC_VECTOR(bit_width-1 downto 0);
			 output : out STD_LOGIC_VECTOR(bit_width-1 downto 0));

end Component;

Component small_mux

	 Generic ( bit_width : Natural := 8);
	 
    Port ( A : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           B : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           en : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (bit_width-1 downto 0));

end Component;

Component FlipFlop

    Port ( data_in : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           load : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           data_out : out  STD_LOGIC;
			  not_data_out : out STD_LOGIC);
			  
end Component;

signal active_load, active, active_in, count_done, delay_en : STD_LOGIC := '0';

signal delay_data, dec_data, dec_reg, mux_data : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

signal prev_location_in : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');

begin

-- Encodes the incoming directional previous location favoring N over E, E over S, and S over W
prev_location_process: process(N,E,S,W)
begin

if N = '1' then
	prev_location_in <= "00";
elsif E = '1' then
	prev_location_in <= "01";
elsif S = '1' then
	prev_location_in <= "10";
elsif W = '1' then
	prev_location_in <= "11";
else prev_location_in <= "00";
end if;

end process;

-- Determines when to output the count_done signal
activate_process: process(delay_data, active, clk)
begin
count_done <= '0';
if active = '1' then
	if delay_data = "00000000" then
		count_done <= '1'; -- When the decrementer reaches 0, output count_done
	end if;
end if;

end process;


-- Connect output values to their corresponding signals within the cell
activate_adj <= count_done;

active_in <= (N or E or S or W or start);

delay_en <= ((active and slow_clk and (not count_done)) or prgm);

data_out(7 downto 0) <= delay_data;

-- Used to hold both the delay and the decrementing value
DelayReg : parallel_load_reg
	
	 Generic Map (
			  bit_width => 8)
			  
    Port Map ( data_in => mux_data,
           clk => clk,
           load => delay_en,
           clr => stop,
           data_out => delay_data);


-- Subtracts 1 from the value held in the DelayReg			  
Decrementer : generic_sub

	 Generic Map (
			  bit_width => 8)
	 
	 Port Map ( A => delay_data,
					B => "00000001",
					output => dec_data);

-- When the top level controller is trying to program this cell, this mux
-- sends the delay to the register, otherwise sends the decrementing value
DataMux : small_mux

	 Generic Map( bit_width => 8)
	 
    Port Map( A => delay,
           B => dec_data,
           en => prgm,
           data_out => mux_data);

-- Holds the location of the first neighbor to activate this cell,
-- as encoded by the above process, and enabled only when this cell isn't active
PrevLocationReg : parallel_load_reg

	Generic Map (
			  bit_width => 2)
			  
    Port Map ( data_in => prev_location_in,
           clk => clk,
           load => active_load,
           clr => reset,
           data_out => prev_location);


-- Holds a bit telling whether this cell is on the shortest path
PathFlop : FlipFlop

    Port Map( data_in => '1',
           clk => clk,
           load => on_path,
           clr => reset,
           data_out => data_out(8),
			  not_data_out => open);

-- Holds a bit telling whether this cell has been activated,
-- a value which is used for decrementing and loading the prev-location
ActiveFlop : FlipFlop

    Port Map( data_in => active_in,
           clk => clk,
           load => active_load,
           clr => reset,
           data_out => active,
			  not_data_out => active_load);

end Behavioral;

