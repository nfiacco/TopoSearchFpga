----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nicholas Fiacco
-- 
-- Create Date:    15:47:17 05/23/2014 
-- Design Name: 
-- Module Name:    top_controller - Behavioral 
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

entity top_controller is
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
			  command : in STD_LOGIC_VECTOR(7 downto 0);
			  command_ld : out STD_LOGIC;
           stop_bit_ld : out  STD_LOGIC;
           start_bit_ld : out  STD_LOGIC;
           path_decode_en : out  STD_LOGIC;
			  header_ld : out STD_LOGIC;
           addr_ld : out  STD_LOGIC;
           current_bit_ld : out  STD_LOGIC;
			  reset : out  STD_LOGIC
			  );
			  
end top_controller;

architecture Behavioral of top_controller is

Type state_type is (reset_state, idle, header_check, receive_command, cost_write, wait_finish, trace_state, done_state);

signal current_state, next_state : state_type := reset_state;

begin

-- Next state loaded on rising clock edge
clock_process: process(clk)
begin
if rising_edge(clk) then

	current_state <= next_state;

end if;

end process;


-- Combination processes for next state and outputs
combi_process: process(done, check_positive, rx_done_tick, trace_done, command, clk, current_state)
begin

-- Initialize all signals/outputs
next_state <= current_state;
start <= '0';
stop <= '0';
stop_mux <= '0';
prgm_decode_en <= '0';
stop_bit_ld <= '0';
start_bit_ld <= '0';
path_decode_en <= '0';
command_ld <= '0';
header_ld <= '0';
addr_ld <= '0';
current_bit_ld <= '0';
reset <= '0';

case current_state is
	
	-- Send out reset signal
	when reset_state =>
		reset <= '1';
		next_state <= idle;
	
	-- Wait for the receiver to signal it has finished receiving a message
	when idle =>
		if rx_done_tick = '1' then
			next_state <= header_check;
			header_ld <= '1';
		end if;
	
	-- Check whether the header matches, and if so load the command
	-- after the next message has been received
	when header_check =>
		if check_positive = '0' then
			next_state <= idle;
		elsif rx_done_tick = '1' then
			next_state <= receive_command;
			command_ld <= '1';
		end if;
	
	-- Based on the value of the command, load one of various registers with
	-- the receivers output value once the next rx_done_tick is received
	when receive_command =>
		if rx_done_tick = '1' then
			if command = "00000001" then
				next_state <= cost_write; -- Load the address and wait for the cost in the next state
				addr_ld <= '1';
			elsif command = "00000010" then
				next_state <= idle; -- Load the start bit address
				start_bit_ld <= '1';
			elsif command = "00000011" then
				next_state <= idle; -- Load the stop bit address and make sure the correct mux sel is sent
				stop_mux <= '1';
				stop_bit_ld <= '1';
				current_bit_ld <= '1'; -- Also load the current cell address, to be used in the traceback
			elsif command = "00000100" then
				next_state <= wait_finish; -- Signal all the cells to start,
				start <= '1';					-- and move to a state to wait until they finish
			else next_state <= reset_state;
			end if;
		end if;
	
	-- When the next message is received, route the cost to the appropriate cell
	when cost_write =>
		if rx_done_tick = '1' then
			next_state <= idle;
			prgm_decode_en <= '1';
		end if;
	
	-- Wait for the stop bit to be reached
	when wait_finish =>
		if done = '1' then
			next_state <= trace_state;
			stop <= '1';
		end if;
	
	-- On each clock edge load a new current bit and signal to that cell its on the path
	when trace_state =>
		stop <= '1';
		path_decode_en <= '1';
		current_bit_ld <= '1';
		if trace_done = '1' then
			next_state <= done_state;
		end if;
	
	-- Wait until the user sends a button signal
	when done_state =>
		if button = '1' then
			next_state <= reset_state;
		end if;
	
end case;

end process;

end Behavioral;

