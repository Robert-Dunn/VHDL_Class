library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity amplitude_up_down_counter is
	Port (
		reset: in STD_LOGIC;
		clk: in std_logic;
		up_amplitude: in std_logic := '0';
		down_amplitude: in std_logic:= '0';
		amplitude: out STD_LOGIC_VECTOR(7 downto 0)
	);
end amplitude_up_down_counter;

architecture Behavioral of amplitude_up_down_counter is

signal current_val: std_logic_vector(7 downto 0) := (others => '0');
constant max : std_logic_vector (7 downto 0):= "11111001";
constant min : std_logic_vector (7 downto 0):= "00000000";

-- Create a logic vector of proper length filled with zeros (also done during synthesis)
constant zeros: std_logic_vector(7 downto 0) := (others => '0');

begin
	Count: process(clk, reset)
	begin
        -- Asynchronous reset
	    if (reset = '1') then
	       current_val <= zeros; -- Set output to 0
		elsif (rising_edge(clk)) then
	        if((up_amplitude = '1') and current_val = max) then
	           current_val<=current_val;   	
			elsif ((up_amplitude = '1') and (current_val < max)) then
				current_val <= current_val + "1010";
			elsif((up_amplitude = '0') and current_val = max) then 
				current_val<=current_val;  
		    elsif ((down_amplitude = '1') and current_val = min) then
		      current_val <= current_val;
			elsif ((down_amplitude = '1') and current_val >= min) then
				current_val <= current_val - "1010";
			elsif((down_amplitude = '0') and current_val = min) then 
				current_val<=current_val;  
			end if;
		end if;
	end process Count;

amplitude <= current_val;

end Behavioral;
