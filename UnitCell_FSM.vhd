----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:55:57 05/23/2014 
-- Design Name: 
-- Module Name:    UnitCell_FSM - Behavioral 
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

entity UnitCell_FSM is
    Port ( clk : in STD_LOGIC;
			  prgm_in : in  STD_LOGIC;
			  reset : in STD_LOGIC;
           active : in  STD_LOGIC;
			  start : in STD_LOGIC;
           stop : in  STD_LOGIC;
           ready : in  STD_LOGIC;
           clr : out  STD_LOGIC;
           delay_en : out  STD_LOGIC;
           activate_adj : out  STD_LOGIC;
           mux_en : out  STD_LOGIC;
			  prgm_en : out STD_LOGIC;
			  triggered : out STD_LOGIC);
end UnitCell_FSM;

architecture Behavioral of UnitCell_FSM is
Type state_type is (idle, prgm_state, wait_state, dec_state, done_state, reset_state);
Signal current_state, next_state : state_type := idle;

begin

combi_process: process(current_state, prgm_in, active, start, stop, ready, reset)
begin
	next_state <= current_state;
	clr <= '0';
	delay_en <= '0';
	activate_adj <= '0';
	prgm_en <= '0';
	mux_en <= '0';
	triggered <= '0';
	
	case current_state is
		
		when reset_state =>
			next_state <= idle;
			clr <= '1';
		
		when idle =>
			if prgm_in = '1' then
				next_state <= prgm_state;
			end if;
		
		when prgm_state =>
			mux_en <= '1';
			prgm_en <= '1';
			delay_en <= '1';
			next_state <= wait_state;
		
		when wait_state =>
			if start = '1' then
				next_state <= done_state;
			end if;
			if stop = '1' then
				next_state <= done_state;
			elsif active = '1' then
				next_state <= dec_state;
			end if;
		
		when dec_state =>
			delay_en <= '1';
			triggered <= '1';
			if stop = '1' then
				next_state <= done_state;
			elsif ready = '1' then
				next_state <= done_state;
			end if;
		
		when done_state =>
			activate_adj <= '1';
			if reset = '1' then
				next_state <= reset_state;
			end if;
		
		end case;

end process;

clk_process: process(clk)
begin

	if rising_edge(clk) then
		current_state <= next_state;
	end if;

end process;

end Behavioral;

