library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity debouncer is
	generic(tenTimes: natural := 10);
	Port (
		asynch_in: in STD_LOGIC;
		clk: in std_logic;
        synch_debounced: out std_logic
	);
end debouncer;

architecture behavioral of debouncer is
signal synch_counter: natural range 0 to tenTimes-1;
signal asynch: std_logic_vector(1 downto 0):= "00";


begin
deb: process(clk)
begin
	if(rising_edge(clk)) then
	    asynch <= asynch(0) & asynch_in;
			if((asynch(0) = asynch(1))) then
	        if(synch_counter = tenTimes-1) then
	            synch_debounced <= asynch(1);
	            synch_counter <= 0;
	        else
	            synch_counter <= synch_counter+1;
	        end if;
	    else
	        synch_debounced <= '0';
	        synch_counter <= 0;
	    end if;
	end if;
	end process;
	end behavioral;
