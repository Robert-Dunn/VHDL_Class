library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_divider is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable: in STD_LOGIC;
			     kHz: out STD_LOGIC;
			singleSecPort: out STD_LOGIC_VECTOR(3 downto 0);
			tenSecPort: out STD_LOGIC_VECTOR(2 downto 0);
			minutePort: out STD_LOGIC_VECTOR(3 downto 0);
			tenMinutePort: out STD_LOGIC_VECTOR(2 downto 0)	
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
signal  onehertz: STD_LOGIC;
signal  onetenthhertz: STD_LOGIC;
signal tensec: STD_LOGIC;
signal onemin: STD_LOGIC;
signal tenmin: STD_LOGIC;

signal singleSecValue: STD_LOGIC_VECTOR(3 downto 0);
signal tenSecValue: STD_LOGIC_VECTOR(2 downto 0);
signal minuteValue: STD_LOGIC_VECTOR(3 downto 0);
signal tenMinuteValue: STD_LOGIC_VECTOR (2 downto 0);
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
oneHzClk: downcounter
generic map(
				period => (10-1),
				WIDTH => 4
)
port map(
				clk => clk,
				reset => reset,
				enable => tenhertz,
				zero => onehertz,
				value => open
);
singleSecClk: downcounter
generic map(
				period => (10-1),
				WIDTH => 4
)
port map(
				clk => clk,
				reset => reset,
				enable => onehertz,
				zero => tensec,
				value => singleSecValue
);
tenSecondsClock: downcounter
generic map(
				period => (6-1),
				WIDTH => 3
)
port map(
				clk => clk,
				reset => reset,
				enable => tensec,
				zero => onemin,
				value => tenSecValue
);
singleMinuteClock: downcounter
generic map(
				period => (10-1),
				WIDTH => 4
)
port map(
				clk => clk,
				reset => reset,
				enable => onemin,
				zero => tenmin,
				value => minuteValue
);
tensMinuteClock: downcounter
generic map(
				period => (6-1),
				WIDTH => 3
)
port map(
				clk => clk,
				reset => reset,
				enable => tenmin,
				zero => open,
				value => tenMinuteValue
);


-- Connect internal signals to outputs

kHz <= kilohertz;
i_enable <= kilohertz and enable;

singleSecPort <= singleSecValue;
tenSecPort <= tenSecValue;
minutePort <= minuteValue;
tenMinutePort <= tenMinuteValue;

end Behavioral;