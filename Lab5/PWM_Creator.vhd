library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PWM is
	Port (
		 clk: in std_logic;
		 reset: in std_logic;
		 wave_switches: in std_logic_vector(2 downto 0);
		 -- 001 = square, 010 = triangle, 100 = sawtooth
		 amplitude_square: in STD_LOGIC_VECTOR(7 downto 0);
		 square_frequency: in STD_LOGIC_VECTOR(17 downto 0);
		 triangle_frequency : in STD_LOGIC_VECTOR (17 downto 0);
		 sawtooth_frequency : in STD_LOGIC_VECTOR (17 downto 0);
		 wave_out: out STD_LOGIC

	);
end PWM;


architecture Behavioral of PWM is

signal amplitude_count:  STD_LOGIC_VECTOR( 7 downto 0) := "00000000"; --main counter
signal amplitude_triangle: STD_LOGIC_VECTOR( 7 downto 0) := "00000000";
signal amplitude_sawtooth: STD_LOGIC_VECTOR( 7 downto 0) := "00000000";
signal Output_Square : std_logic := '1';
signal Output_Triangle : std_logic := '0';
signal square_out: std_logic;
signal triangle_out: std_logic;
signal sawtooth_out: std_logic;
signal square_pwm:  std_logic;
signal tr_pwm:  std_logic;
signal saw_pwm:  std_logic;
signal saw_count: std_logic_vector(2 downto 0) := "000";
signal tri_count: std_logic := '0';
signal count_maxs_square :  std_logic_vector(17 downto 0) := "000000000000000000";
signal count_maxs_sawtooth :  std_logic_vector(17 downto 0) := "000000000000000000";
signal count_maxs_triangle :  std_logic_vector(17 downto 0) := "000000000000000000";
signal MHz_50: std_logic := '0';
constant max_value : STD_LOGIC_VECTOR := "11111001" ; --main counter max: 249
constant amp_zeros : std_logic_vector(7 downto 0) := (others => '0');
constant freq_zeros : std_logic_vector(17 downto 0) := (others => '0');
signal hover_250 : std_logic := '0';

begin
	Internal_PWM: process(clk, reset)
	begin


			 if reset = '1' then
	       amplitude_count <= amp_zeros; -- Set output to 0
				 square_pwm <= '0';
				 tr_pwm <= '0';
				 saw_pwm <='0';
			elsif (rising_edge(clk)) then
				if (MHz_50 = '1') then
					-- sqaure part
			  	MHz_50 <= '0';

					if(amplitude_count <= amplitude_square) then -- turn pwm on or off
						square_pwm <= '1';
					else square_pwm <= '0';
					end if;

					if(amplitude_count <= amplitude_sawtooth) then
						saw_pwm <= '1';
					else
						saw_pwm <= '0';
					end if;

					if(amplitude_count < (amplitude_triangle)) then
						tr_pwm <= '1';
					else
						tr_pwm <= '0';
					end if;

					if (amplitude_count < max_value) then -- restart pwm cycle
						amplitude_count <= amplitude_count + '1';
					elsif (amplitude_count >= max_value) then
															amplitude_count <= amp_zeros;

															if(count_maxs_triangle >= triangle_frequency) then
																count_maxs_triangle <= freq_zeros;
																if Output_triangle = '0' then
																	Output_triangle <= '1';
																else
																	Output_triangle <= '0';
																	hover_250 <= '0';
																end if;
															else
																count_maxs_triangle <= count_maxs_triangle + 1;
															end if;


															-- triangle set
															if tri_count = '1' then
																if Output_Triangle = '0' then
																		amplitude_triangle <= amplitude_triangle + 5;
																	tri_count <= '0';
																else
																	if hover_250 = '0' then
																		amplitude_triangle <= amplitude_triangle;
																		hover_250 <= '1';
																	elsif (hover_250 = '1') then
																		amplitude_triangle <= amplitude_triangle - 5;
																	end if;
																	tri_count <= '0';
																end if;
															else
																tri_count <= '1';
															end if;
																-- end triangle

															if(count_maxs_square >= square_frequency) then
																count_maxs_square <= freq_zeros;
																if Output_Square = '0' then
																	Output_Square <= '1';
																else
																	Output_Square <= '0';
																end if;
															else
																count_maxs_square <= count_maxs_square + 1;
															end if;
															-- end square part

															-- sawtooth part
															if saw_count = "011" then -- every fourth amp max
																amplitude_sawtooth <= amplitude_sawtooth + 5;
																saw_count <= "000";
															else
																saw_count <= saw_count +1;
															end if;

															if(count_maxs_sawtooth > sawtooth_frequency) then
															  count_maxs_sawtooth <= freq_zeros;
																amplitude_sawtooth <= amp_zeros;
															else
															  count_maxs_sawtooth <= count_maxs_sawtooth + 1;
															end if;
															-- end sawtooth part

					end if;
		    else
				MHz_50 <= '1';
			end if;
		end if;
end process Internal_PWM;

Square_Wave : process (Output_Square, square_pwm, clk, reset)
begin
		if reset = '1' then
			square_out <= '0';
		elsif rising_edge(clk) then
			if(Output_Square= '1') then
				square_out <= square_pwm;
			elsif(Output_Square = '0') then
				square_out <= '0';
			end if;
		end if;
end process Square_Wave;

triangle_Wave : process ( tr_pwm, clk, reset)
begin
		if reset = '1' then
			triangle_out <= '0';
		elsif rising_edge(clk) then
			triangle_out <= tr_pwm;
		end if;
end process triangle_Wave;

sawtooth_Wave : process ( saw_pwm, clk, reset)
begin

		if reset = '1' then
			sawtooth_out <= '0';
		elsif rising_edge(clk) then
			sawtooth_out <= saw_pwm;
		end if;
end process sawtooth_Wave;

Wave : process ( wave_switches, clk, reset)
begin
		if reset = '1' then
			wave_out <= '0';
		elsif rising_edge(clk) then
			if wave_switches = "001" then
				wave_out <= square_out;
			elsif wave_switches = "010" then
				wave_out <= triangle_out;
			elsif wave_switches = "100" then
				wave_out <= sawtooth_out;
			else
				wave_out <= '0';
			end if;
		end if;
end process Wave;

end Behavioral;
