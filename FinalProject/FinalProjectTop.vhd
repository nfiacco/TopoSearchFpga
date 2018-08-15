----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nicholas Fiacco
-- 
-- Create Date:    19:55:24 05/25/2014 
-- Design Name: 
-- Module Name:    FinalProjectTop - Behavioral 
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

entity FinalProjectTop is

    Port ( clk 			: in  STD_LOGIC;
           serial_in 	: in  STD_LOGIC;
			  button			: in  STD_LOGIC;
			  red				: out std_logic_vector(2 downto 0);
			  green			: out std_logic_vector(2 downto 0);
			  blue			: out std_logic_vector(1 downto 0);
			  hs,vs			: out std_logic);
			  
end FinalProjectTop;

architecture Behavioral of FinalProjectTop is

Component CellGridTop

	 Port ( clk : in  STD_LOGIC;
           rxd : in  STD_LOGIC_VECTOR (7 downto 0);
			  button : in STD_LOGIC;
           rx_done_tick : in  STD_LOGIC;
			  vga_data : out  STD_LOGIC_VECTOR (8 downto 0);
			  start_stop : out STD_LOGIC;
           vga_addr : in  STD_LOGIC_VECTOR (7 downto 0));
			  
end Component;

Component clock25div
	 
    Port ( 
			  clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           output : out  STD_LOGIC
	 );
	 
end Component;

Component SerialRX

	 Port ( 
			  clk25 : in  STD_LOGIC;
           TXD : in  STD_LOGIC;
           br_tick16 : in  STD_LOGIC;
           rx_data : out  STD_LOGIC_VECTOR (7 downto 0);
           rx_done_tick : out  STD_LOGIC
	 );
	 
end Component;

Component BaudRateGen

	 Generic (
	 BAUDRATE : Natural := 115200
	 );
	 
    Port ( 
			  clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           output : out  STD_LOGIC
	 );
	 
end Component;

Component VGA_controller

	Port(clk_px			: in std_logic;
        clk_en        : in std_logic;
		  color			: in std_logic_vector(7 downto 0);
		  red				: out std_logic_vector(2 downto 0);
		  green			: out std_logic_vector(2 downto 0);
		  blue			: out std_logic_vector(1 downto 0);
		  hs,vs			: out std_logic;
		  row,column	: out INTEGER);
		  
end Component;

Component VGA_color

	Port (row,column	    : in INTEGER;
         cell_address    : out std_logic_vector(7 downto 0);
         cell_data       : in std_logic_vector(8 downto 0);
			start_stop		 : in std_logic;
         color           : out std_logic_vector(7 downto 0));
			
end Component;

signal rxd, vga_addr, color : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal cell_data : STD_LOGIC_VECTOR(8 downto 0) := (others => '0');
signal rx_done_tick, clk25, br_tick, start_stop : STD_LOGIC := '0';
signal row, column : Integer := 0;

begin

-- Holds the grid of cells, various routing components,
-- and the controller to route signals to and from them.
-- Also handles trace back once the shortest path has been found
CellGrid : CellGridTop

	 Port Map(
			  clk => clk,
           rxd => rxd,
			  button => button,
           rx_done_tick => rx_done_tick,
			  start_stop => start_stop,
			  vga_data => cell_data,
           vga_addr => vga_addr
			  );

-- Receives information transmitted serially from the computer
Receiver : SerialRX

	 Port Map( 
			  clk25 => clk,
           TXD => serial_in,
           br_tick16 => br_tick,
           rx_data => rxd,
           rx_done_tick => rx_done_tick
	 );

-- Generates the bauderate signal used by the receiver
BaudGenerator : BaudRateGen

	 Generic Map(
	 BAUDRATE => 115200
	 )
	 
    Port Map( 
			  clk => clk,
           en => '1',
           output => br_tick
	 );

-- Generates the quarter speed clock used by the vga controller
clock25gen : clock25div
	 
    Port Map( 
			  clk => clk,
           en => '1',
           output => clk25
	 );

-- Generates the output color used by the vga controller
ColorGen : VGA_Color
	
	Port Map(
			row => row,
			column => column,
         cell_address => vga_addr,
         cell_data => cell_data,
			start_stop => start_stop,
         color => color
			);

-- Displays colors to a vga monitor based on inputs from the cell grid
ColorControl : VGA_Controller

	Port Map(
		  clk_px => clk,
        clk_en => clk25,
		  color => color,
		  red => red,
		  green => green,
		  blue => blue,
		  hs => hs,
		  vs => vs,
		  row => row,
		  column => column
		  );

end Behavioral;

