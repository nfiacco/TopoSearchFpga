----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nicholas Fiacco
-- 
-- Create Date:    15:51:59 05/23/2014 
-- Design Name: 
-- Module Name:    CellGridTop - Behavioral 
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
use work.data_bus9bit.all;
use work.short_bus8bit.all;

entity CellGridTop is

	 Port ( clk : in  STD_LOGIC;
           rxd : in  STD_LOGIC_VECTOR (7 downto 0);
           rx_done_tick : in  STD_LOGIC;
			  button : in STD_LOGIC;
			  vga_data : out  STD_LOGIC_VECTOR (8 downto 0);
			  start_stop : out STD_LOGIC;
           vga_addr : in  STD_LOGIC_VECTOR (7 downto 0));
			  
end CellGridTop;

architecture Behavioral of CellGridTop is

Component UnitCell
    
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

end Component;

Component SlowClkGen

	 Generic (
	 RATE : Natural := 10
	 );
	 
    Port ( 
			  clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           output : out  STD_LOGIC
	 );
	 
end Component;

Component top_controller

    Port ( clk : in  STD_LOGIC;
			  rx_done_tick : in STD_LOGIC;
			  button : in STD_LOGIC;
			  done : in  STD_LOGIC;
			  trace_done : in STD_LOGIC;
			  check_positive : in STD_LOGIC;
			  start : out STD_LOGIC;
			  stop : out STD_LOGIC;
			  stop_mux : out STD_LOGIC;
			  prgm_decode_en : out STD_LOGIC;
           stop_bit_ld : out  STD_LOGIC;
           start_bit_ld : out  STD_LOGIC;
           path_decode_en : out  STD_LOGIC;
			  command : in STD_LOGIC_VECTOR(7 downto 0);
			  command_ld : out STD_LOGIC;
			  header_ld : out STD_LOGIC;
           addr_ld : out  STD_LOGIC;
           current_bit_ld : out  STD_LOGIC;
			  reset : out  STD_LOGIC
			  );
			  
end Component;

Component generic_comparator
	
	Generic (
			  bit_width : Natural := 8);
	 
	 Port ( A : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           B : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
			  en : in STD_LOGIC;
			  equal : out  STD_LOGIC);
			  
end Component;

Component small_mux

	 Generic ( bit_width : Natural := 8);
	 
    Port ( A : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           B : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           en : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (bit_width-1 downto 0));

end Component;

Component mux_4x2

    Port ( data_in : in  short_array8bit;
           sel : in  STD_LOGIC_VECTOR (1 downto 0);
           data_out : out  STD_LOGIC_VECTOR (7 downto 0));
			  
end Component;

Component location_mux

    Port ( data_in : in  data_array2bit;
			  addr : in STD_LOGIC_VECTOR(7 downto 0);
           data_out : out  STD_LOGIC_VECTOR (1 downto 0));
			  
end Component;

Component data_mux

    Port ( data_in : in  STD_LOGIC_VECTOR(255 downto 0);
			  addr : in STD_LOGIC_VECTOR(7 downto 0);
           data_out : out  STD_LOGIC);
			  
end Component;

Component address_mux

    Port ( data_in : in  data_array9bit;
			  addr : in STD_LOGIC_VECTOR(7 downto 0);
           data_out : out  STD_LOGIC_VECTOR (8 downto 0));

end Component;

Component generic_add_sub

	 Generic ( bit_width : Natural := 8);

    Port ( A : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           B : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
			  add : in STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (bit_width-1 downto 0));
			  
end Component;

Component parallel_load_reg

	 Generic (
			  bit_width : Natural := 8);
			  
    Port ( data_in : in  STD_LOGIC_VECTOR (bit_width-1 downto 0);
           clk : in  STD_LOGIC;
           load : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (bit_width-1 downto 0));

end Component;

Component address_decoder

    Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
			  en : in STD_LOGIC;
           decoded_out : out  STD_LOGIC_VECTOR (255 downto 0));
			  
end Component;

constant check_value : STD_LOGIC_VECTOR := "01010111";

signal start_decode, prgm_decode, path_decode, activate_sig : STD_LOGIC_VECTOR(255 downto 0) := (others => '0');

signal current_bit_in, current_bit_out, bit_update_muxed, start_bit_out, stop_bit_out,
prgm_decode_addr, header_sig, command_sig : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

signal loc_muxed : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
signal location_mux_sig : data_array2bit := (others => "00");
signal data_mux_sig : data_array9bit := (others => "000000000");
signal bit_update_data : short_array8bit := (others => "00000000");

signal stop, done, trace_done, reset, check_positive, start_bit_ld, stop_bit_ld, start_decode_en, command_ld,
stop_mux, prgm_decode_en, path_decode_en, current_bit_ld, header_ld, addr_ld, start_color, stop_color, slow_clk : STD_LOGIC := '0';

begin

-- Used for vga_color determination, both start and stop receive a special color
start_stop <= (start_color or stop_color);

-- FSM controller for the top level, wiring control signals to muxes and encoders
Controller : top_controller

    Port Map( clk => clk,
			  rx_done_tick => rx_done_tick,
			  button => button,
			  done => done,
			  trace_done => trace_done,
			  check_positive => check_positive,
			  start => start_decode_en,
			  stop => stop,
			  stop_mux => stop_mux,
			  prgm_decode_en => prgm_decode_en,
           stop_bit_ld => stop_bit_ld,
           start_bit_ld => start_bit_ld,
           path_decode_en => path_decode_en,
			  command => command_sig,
			  command_ld => command_ld,
			  header_ld => header_ld,
           addr_ld => addr_ld,
           current_bit_ld => current_bit_ld,
			  reset => reset);

-- Generates a slow clock signal to be used by the unit cell's decrementer
SlowGenerator : SlowClkGen

	 Generic Map(
	 RATE => 50
	 )
	 
    Port Map( 
			  clk => clk,
           en => '1',
           output => slow_clk
	 );

-- Loads the header upon signal from the controller
HeaderReg : parallel_load_reg

	Generic Map (
			  bit_width => 8)
			  
    Port Map ( data_in => rxd,
           clk => clk,
           load => header_ld,
           clr => reset,
           data_out => header_sig);

-- Loads the command upon signal from the controller
CommandReg : parallel_load_reg

	Generic Map (
			  bit_width => 8)
			  
    Port Map ( data_in => rxd,
           clk => clk,
           load => command_ld,
           clr => reset,
           data_out => command_sig);

-- Loads the start bit address upon signal from the controller
StartBitReg : parallel_load_reg

	 Generic Map (
			  bit_width => 8)
			  
    Port Map ( data_in => rxd,
           clk => clk,
           load => start_bit_ld,
           clr => reset,
           data_out => start_bit_out);

-- Loads the stop bit address upon signal from the controller
StopBitReg : parallel_load_reg

	 Generic Map (
			  bit_width => 8)
			  
    Port Map ( data_in => rxd,
           clk => clk,
           load => stop_bit_ld,
           clr => reset,
           data_out => stop_bit_out);

-- Loads the current cell address upon signal from the controller
CurrentBitReg : parallel_load_reg

	 Generic Map (
			  bit_width => 8)
			  
    Port Map ( data_in => current_bit_in,
           clk => clk,
           load => current_bit_ld,
           clr => reset,
           data_out => current_bit_out);

-- Loads the address from the receiver upon signal from the controller
AddressReg : parallel_load_reg

	 Generic Map (
			  bit_width => 8)
			  
    Port Map ( data_in => rxd,
           clk => clk,
           load => addr_ld,
           clr => reset,
           data_out => prgm_decode_addr);

-- Outputs an program signal to only one cell based on an input address, enabled by the controller
PrgmDecoder : address_decoder
    
	 Port Map( addr => prgm_decode_addr,
			  en => prgm_decode_en,
           decoded_out => prgm_decode);

-- Outputs a path prgm signal to only one cell based on an input address, enabled by the controller
PathDecoder : address_decoder
    
	 Port Map( addr => current_bit_out,
			  en => path_decode_en,
           decoded_out => path_decode);

-- Outputs a start signal to the start cell, enabled by the controller
StartSignalDecoder : address_decoder
    
	 Port Map( addr => start_bit_out,
			  en => start_decode_en,
           decoded_out => start_decode);

-- Generates the address of the cell north of the current cell
NorthSub : generic_add_sub
	 
	 Generic Map( bit_width => 8)

    Port Map( A => current_bit_out,
           B => std_logic_vector(to_unsigned(16,8)),
			  add => '0',
           output => bit_update_data(0));

-- Generates the address of the cell west of the current cell
WestSub : generic_add_sub
	 
	 Generic Map( bit_width => 8)

    Port Map( A => current_bit_out,
           B => std_logic_vector(to_unsigned(1,8)),
			  add => '0',
           output => bit_update_data(3));

-- Generates the address of the cell south of the current cell
SouthAdd : generic_add_sub
	 
	 Generic Map( bit_width => 8)

    Port Map( A => current_bit_out,
           B => std_logic_vector(to_unsigned(16,8)),
			  add => '1',
           output => bit_update_data(2));

-- Generates the address of the cell east of the current cell 
EastAdd : generic_add_sub
	 
	 Generic Map( bit_width => 8)

    Port Map( A => current_bit_out,
           B => std_logic_vector(to_unsigned(1,8)),
			  add => '1',
           output => bit_update_data(1));

-- Routes the prev_location information of the current cell to the top level
location_muxer : location_mux

    Port Map ( data_in => location_mux_sig,
			  addr => current_bit_out,
           data_out => loc_muxed);

-- Routes the delay data of the cell designated by the vga_addr to the vga_controller
data_muxer : address_mux

    Port Map( data_in => data_mux_sig,
			  addr => vga_addr,
           data_out => vga_data);

-- Routes the done signal from the stop bit to the top level
done_muxer : data_mux

    Port Map( data_in => activate_sig,
			  addr => stop_bit_out,
           data_out => done);

-- Routes one of NESW to the current cell mux based on its prev_location data
bit_update_mux : mux_4x2

    Port Map ( data_in => bit_update_data,
           sel => loc_muxed,
           data_out => bit_update_muxed);

-- Routes either the receiver data or the current cells prev_location data to the current cell reg
current_bit_prgm_mux : small_mux

    Port Map( A => rxd,
           B => bit_update_muxed,
           en => stop_mux,
           data_out => current_bit_in);

-- Compares the stored header to the correct value
header_compare : generic_comparator

	 Generic Map (
			  bit_width => 8)
	 
	 Port Map ( A => header_sig,
           B => check_value,
			  en => '1',
			  equal => check_positive);

-- Checks whether trace back is done by comparing the current cell with the start cell
trace_checker: generic_comparator
	 
	 Generic Map (
			  bit_width => 8)
	 
	 Port Map ( A => current_bit_out,
           B => start_bit_out,
			  en => '1',
			  equal => trace_done);

-- Checks whether the cell designated by the vga_addr is the start cell
start_checker: generic_comparator
	 
	 Generic Map (
			  bit_width => 8)
	 
	 Port Map ( A => start_bit_out,
           B => vga_addr,
			  en => '1',
			  equal => start_color);

-- Checks whether the cell designated by the vga_addr is the stop cell
stop_checker: generic_comparator
	 
	 Generic Map (
			  bit_width => 8)
	 
	 Port Map ( A => stop_bit_out,
           B => vga_addr,
			  en => '1',
			  equal => stop_color);

-- Creates the cell grid using a variety of generate statements, being careful to handle boundary cases
rows : for r in 0 to 15 generate
begin
	
	columns : for c in 0 to 15 generate
	begin
	
		toprow : if r = 0 generate
		begin
			
			topleft : if c = 0 generate
			begin
				UnitCellX : UnitCell
				Port Map (
				  clk => clk,
				  slow_clk => slow_clk,
				  prgm => prgm_decode(r*16+c),
				  reset => reset,
				  N => '0',
				  E => activate_sig(r*16+c+1),
				  S => activate_sig((r+1)*16+c),
				  W => '0',
				  delay => rxd,
				  start => start_decode(r*16+c),
				  stop => stop,
				  on_path => path_decode(r*16+c),
				  data_out => data_mux_sig(r*16+c),
				  prev_location => location_mux_sig(r*16+c),
				  activate_adj => activate_sig(r*16+c));
				  
			end generate;
			
			topmiddle : if c > 0 and c < 15 generate
			begin
			
				UnitCellX : UnitCell
				Port Map (
				  clk => clk,
				  slow_clk => slow_clk,
				  prgm => prgm_decode(r*16+c),
				  reset => reset,
				  N => '0',
				  E => activate_sig(r*16+c+1),
				  S => activate_sig((r+1)*16+c),
				  W => activate_sig(r*16+c-1),
				  delay => rxd,
				  start => start_decode(r*16+c),
				  stop => stop,
				  on_path => path_decode(r*16+c),
				  data_out => data_mux_sig(r*16+c),
				  prev_location => location_mux_sig(r*16+c),
				  activate_adj => activate_sig(r*16+c)); 
				  
			end generate;
			
			topright : if c = 15 generate
			begin
			
				UnitCellX : UnitCell
				Port Map (
				  clk => clk,
				  slow_clk => slow_clk,
				  prgm => prgm_decode(r*16+c),
				  reset => reset,
				  N => '0',
				  E => '0',
				  S => activate_sig((r+1)*16+c),
				  W => activate_sig(r*16+c-1),
				  delay => rxd,
				  start => start_decode(r*16+c),
				  stop => stop,
				  on_path => path_decode(r*16+c),
				  data_out => data_mux_sig(r*16+c),
				  prev_location => location_mux_sig(r*16+c),
				  activate_adj => activate_sig(r*16+c)); 
				  
			end generate;
		
		end generate;
		
		middlerows : if r > 0 and r < 15 generate
		
			middleleft : if c = 0 generate
			begin
				
					UnitCellX : UnitCell
					Port Map (
					  clk => clk,
					  slow_clk => slow_clk,
					  prgm => prgm_decode(r*16+c),
					  reset => reset,
					  N => activate_sig((r-1)*16+c),
					  E => activate_sig(r*16+c+1),
					  S => activate_sig((r+1)*16+c),
					  W => '0',
					  delay => rxd,
					  start => start_decode(r*16+c),
					  stop => stop,
					  on_path => path_decode(r*16+c),
					  data_out => data_mux_sig(r*16+c),
					  prev_location => location_mux_sig(r*16+c),
					  activate_adj => activate_sig(r*16+c)); 
					  
			end generate;
			
			middlemiddle : if c > 0 and c < 15 generate
			begin
			
				UnitCellX : UnitCell
				Port Map (
				  clk => clk,
				  slow_clk => slow_clk,
				  prgm => prgm_decode(r*16+c),
				  reset => reset,
				  N => activate_sig((r-1)*16+c),
				  E => activate_sig(r*16+c+1),
				  S => activate_sig((r+1)*16+c),
				  W => activate_sig(r*16+c-1),
				  delay => rxd,
				  start => start_decode(r*16+c),
				  stop => stop,
				  on_path => path_decode(r*16+c),
				  data_out => data_mux_sig(r*16+c),
				  prev_location => location_mux_sig(r*16+c),
				  activate_adj => activate_sig(r*16+c)); 
				  
			end generate;
			
			middleright : if c = 15 generate
			begin
			
				UnitCellX : UnitCell
				Port Map (
				  clk => clk,
				  slow_clk => slow_clk,
				  prgm => prgm_decode(r*16+c),
				  reset => reset,
				  N => activate_sig((r-1)*16+c),
				  E => '0',
				  S => activate_sig((r+1)*16+c),
				  W => activate_sig(r*16+c-1),
				  delay => rxd,
				  start => start_decode(r*16+c),
				  stop => stop,
				  on_path => path_decode(r*16+c),
				  data_out => data_mux_sig(r*16+c),
				  prev_location => location_mux_sig(r*16+c),
				  activate_adj => activate_sig(r*16+c)); 
				  
			end generate;
			
		end generate;
		
		bottomrow : if r = 15 generate
		
			bottomleft : if c = 0 generate
			begin
		
			UnitCellX : UnitCell
			Port Map (
			  clk => clk,
			  slow_clk => slow_clk,
			  prgm => prgm_decode(r*16+c),
			  reset => reset,
			  N => activate_sig((r-1)*16+c),
			  E => activate_sig(r*16+c+1),
			  S => '0',
			  W => '0',
			  delay => rxd,
			  start => start_decode(r*16+c),
			  stop => stop,
			  on_path => path_decode(r*16+c),
			  data_out => data_mux_sig(r*16+c),
			  prev_location => location_mux_sig(r*16+c),
			  activate_adj => activate_sig(r*16+c)); 
			  
			end generate;
			
			bottommiddle : if c > 0 and c < 15 generate
			begin
		
			UnitCellX : UnitCell
			Port Map (
			  clk => clk,
			  slow_clk => slow_clk,
			  prgm => prgm_decode(r*16+c),
			  reset => reset,
			  N => activate_sig((r-1)*16+c),
			  E => activate_sig(r*16+c+1),
			  S => '0',
			  W => activate_sig(r*16+c-1),
			  delay => rxd,
			  start => start_decode(r*16+c),
			  stop => stop,
			  on_path => path_decode(r*16+c),
			  data_out => data_mux_sig(r*16+c),
			  prev_location => location_mux_sig(r*16+c),
			  activate_adj => activate_sig(r*16+c)); 
			  
			end generate;
			
			bottomright : if c = 15 generate
			begin
		
			UnitCellX : UnitCell
			Port Map (
			  clk => clk,
			  slow_clk => slow_clk,
			  prgm => prgm_decode(r*16+c),
			  reset => reset,
			  N => activate_sig((r-1)*16+c),
			  E => '0',
			  S => '0',
			  W => activate_sig(r*16+c-1),
			  delay => rxd,
			  start => start_decode(r*16+c),
			  stop => stop,
			  on_path => path_decode(r*16+c),
			  data_out => data_mux_sig(r*16+c),
			  prev_location => location_mux_sig(r*16+c),
			  activate_adj => activate_sig(r*16+c)); 
			  
			end generate;
		
		end generate;
		
	end generate;
	
end generate;

end Behavioral;

