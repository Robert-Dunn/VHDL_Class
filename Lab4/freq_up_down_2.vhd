library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity frequency_up_down_counter is
	Port (
		reset: in STD_LOGIC;
		clk: in std_logic;
		up_freq: in std_logic ;
		down_freq: in std_logic ;
		square_frequency: out STD_LOGIC_VECTOR(17 downto 0);
		triangle_frequency : out STD_LOGIC_VECTOR (17 downto 0);
		sawtooth_frequency : out STD_LOGIC_VECTOR (17 downto 0)
	);
end frequency_up_down_counter;

architecture Behavioral of frequency_up_down_counter is
  signal up_enable, down_enable: std_logic := '1';
  signal turn_up, turn_down: std_logic := '0';


type frequencies is (one_KHz, five_hundred_Hz, one_hundred_Hz, fifty_Hz, ten_Hz, one_Hz);
signal State_frequency : frequencies := one_KHz;
signal CHECK_STATE : std_logic := '0';
constant zeros: std_logic_vector(17 downto 0) := (others => '0');

begin
	Frequency_State: process(reset, clk)
	begin

	   if(reset = '1') then
       up_enable = '0';
       down_enable = '0';
       up_freq = '0';
       down_freq = '0';
    else
    if rising_edge(clk) then
      if down_freq = '0' then
        down_enable = '1';
      end if;
      if up_freq = '0' then
        up_enable = '1';
      end if;
      if up_freq = '1' and up_enable = '1' then
        up_enable = '0';
        turn_up = '1';
      elsif down_freq = '1' and down_enable = '1' then
        turn_down = '1';
      end if;
    end if;
  end if;
end process Frequency_State;
end Behavioral;
