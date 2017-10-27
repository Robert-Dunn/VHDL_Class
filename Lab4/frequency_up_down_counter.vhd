library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity frequency_up_down_counter is
	Port (
		reset: in STD_LOGIC;
		clk: in std_logic;
		up_freq: in std_logic;
		down_freq: in std_logic;
		square_frequency: out STD_LOGIC_VECTOR(17 downto 0);
		triangle_frequency : out STD_LOGIC_VECTOR (17 downto 0);
		sawtooth_frequency : out STD_LOGIC_VECTOR (17 downto 0)
	);
end frequency_up_down_counter;

architecture Behavioral of frequency_up_down_counter is

type frequencies is (one_KHz, five_hundred_Hz, one_hundred_Hz, fifty_Hz, ten_Hz, one_Hz);
signal State_frequency : frequencies;




signal frequency_bits : STD_LOGIC_VECTOR(17 downto 0);
signal State : std_logic_vector (2 downto 0):= "001";
constant max : std_logic_vector (2 downto 0):= "110";
constant min : std_logic_vector (2 downto 0):= "001";
constant zeros: std_logic_vector(17 downto 0) := (others => '0');

begin
	Frequency: process(State_frequency, clk)
	begin
		if rising_edge(clk) then
			if(reset = '1') then
				State_frequency <= one_KHz;
			end if;
			case State_frequency is
				when one_KHz =>
					square_frequency   <= "000000000001100100";
					triangle_frequency <= "000000000001100100";
					sawtooth_frequency <= "000000000011001000";
					if(down_freq = '1') then
						State_frequency <= five_hundred_Hz;
					end if;
					when five_hundred_Hz =>
					square_frequency   <= "000000000011001000";
					triangle_frequency <= "000000000011001000";
					sawtooth_frequency <= "000000000110010000";
					if(down_freq = '1') then
						State_frequency <= one_hundred_Hz;
					elsif(up_freq = '1') then
						State_frequency <= one_KHz;
					end if;
					when one_hundred_Hz =>
					square_frequency   <= "000000001111101000";
					triangle_frequency <= "000000001111101000";
					sawtooth_frequency <= "000000011111010000";
					if(down_freq = '1') then
						State_frequency <= fifty_Hz;
					elsif(up_freq = '1') then
						State_frequency <= five_hundred_Hz;
					end if;
					when fifty_Hz =>
					square_frequency   <= "000000011111010000";
					triangle_frequency <= "000000011111010000";
					sawtooth_frequency <= "000000111110100000";
					if(down_freq = '1') then
						State_frequency <= ten_Hz;
					elsif(up_freq = '1') then
						State_frequency <= one_hundred_Hz;
					end if;
					when ten_Hz =>
					square_frequency   <= "000010011100010000";
					triangle_frequency <= "000010011100010000";
					sawtooth_frequency <= "000100111000100000";
					if(down_freq = '1') then
						State_frequency <= one_Hz;
					elsif(up_freq = '1') then
						State_frequency <= fifty_Hz;
					end if;
					when one_Hz =>
					square_frequency <= "011000011010100000";
					triangle_frequency <= "011000011010100000";
					sawtooth_frequency <= "110000110101000000";
					if(up_freq = '1') then
						State_frequency <= ten_Hz;
					end if;
			end if;
		end case;
	end process Frequency;
end Behavioral;


--if freq = 1; count1_maxs =  100 ; 1khz frequency
--if freq = 2; count1_maxs = 200 ; 500Hz frequency
--if freq = 3; count1_maxs = 1000 ; 100Hz frequency
--if freq = 4; count1_maxs = 2000 ; 50Hz frequency
--count1_maxs = 10000 ; 10Hz frequency
--count1_maxs = 100000 ; 1Hz frequency
--sawtooth  = 2x
