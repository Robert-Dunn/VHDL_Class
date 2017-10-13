library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity debouncer is
	Port (
		asynch_in: in STD_LOGIC;
		down: in STD_LOGIC;
		clk: in std_logic;
		reset: in std_logic;
		enable: in std_logic;
        synch_out: out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end debouncer;
