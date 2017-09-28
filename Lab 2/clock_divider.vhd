library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_divider is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable: in STD_LOGIC;
			     kHz: out STD_LOGIC
		   -- Add output buses (STD_LOGIC_VECTOR(x downto y))
		   -- here to hold values of single seconds, tens of seconds,
		   -- minutes, and tens of minutes. Consult Lab 1 intructions
		   -- if you are not sure of syntax.	  
			   );
end clock_divider;

architecture Behavioral of clock_divider is
-- Signals:
signal 	i_enable: STD_LOGIC;
signal 	kilohertz: STD_LOGIC;
signal 	hundredhertz: STD_LOGIC;
signal	tenhertz: STD_LOGIC;
-- Add signals here

-- Components:
-- This is kind of like a function prototype in C/C++
component downcounter is
	Generic ( period: integer:= 4;
				    WIDTH: integer:= 3);
		Port ( clk : in  STD_LOGIC;
				   reset : in  STD_LOGIC;
				   enable : in  STD_LOGIC;
				   zero : out  STD_LOGIC;
				   value: out STD_LOGIC_VECTOR(WIDTH-1 downto 0));
end component;

begin
kiloHzClock: downcounter
generic map(
				period => (100000-1), -- "1 1000 0110 1010 0000" in binary
				WIDTH => 17
			)
port map (
				clk => clk,
				reset => reset,
				enable => '1',
				zero => kilohertz,
				value => open			-- Leave open since we won't display this value
);

hundredHzClock: downcounter
generic map(
				period => (10-1),	-- Counts numbers between 0 and 9 -> that's 10 values!
				WIDTH => 4
			)
port map (
				clk => clk,
				reset => reset,
				enable => i_enable,
				zero => hundredhertz,
				value => open			-- Leave open since we won't display this value
);

tenHzClock: downcounter
generic map(
				period => (10-1),	-- Counts numbers between 0 and 9 -> that's 10 values!
				WIDTH => 4
			)
port map (
				clk => clk,
				reset => reset,
				enable => hundredhertz,
				zero => tenhertz,
				value => open			-- Leave open since we won't display this value
);

-- Connect internal signals to outputs
kHz <= kilohertz;
i_enable <= kilohertz and enable;

end Behavioral;