library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_divider is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable: in STD_LOGIC;
			  MHz: out STD_LOGIC
		  );
end clock_divider;

architecture Behavioral of clock_divider is
-- Signals:
signal  i_enable: STD_LOGIC;
signal 	kilohertz: STD_LOGIC;
signal 	hundredhertz: STD_LOGIC;
signal	tenhertz: STD_LOGIC;
signal onehertz: STD_LOGIC;
signal tensec: STD_LOGIC;
signal onemin: STD_LOGIC;
signal tenmin: STD_LOGIC;

signal seconds_value: STD_LOGIC_VECTOR(4-1 downto 0);
signal ten_seconds_value: STD_LOGIC_VECTOR(3-1 downto 0);
signal minutes_value: STD_LOGIC_VECTOR(4-1 downto 0);
signal ten_minutes_value: STD_LOGIC_VECTOR(3-1 downto 0);

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

-- ADDED
megaHzClock_MHz: downcounter
generic map(
				period => (100-1), -- divide by 100
				WIDTH => 7
			)
port map (
				clk => clk,
				reset => reset,
				enable => '1',
				value => MHz			-- Leave open since we won't display this value
);


i_enable <= kilohertz and enable;

-- Connect internal signals to outputs
MHz <= kilohertz;



end Behavioral;
