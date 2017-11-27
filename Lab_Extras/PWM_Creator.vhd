library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PWM is
	Port (
		 clk: in std_logic;
		 Pwm_clk: in std_logic;
		 Saw_clk: in std_logic;
		 reset: in std_logic;
		 -- 001 = square, 010 = triangle, 100 = sawtooth
		 sawtooth_frequency : in STD_LOGIC_VECTOR (17 downto 0);
		 wave_out: out STD_LOGIC

	);
end PWM;


architecture Behavioral of PWM is

signal amplitude_count:  STD_LOGIC_VECTOR( 7 downto 0) := "00000000"; --main counter
signal amplitude_sawtooth: STD_LOGIC_VECTOR( 7 downto 0) := "00000000";
signal sawtooth_out: std_logic;
signal saw_pwm:  std_logic;
constant max_value : STD_LOGIC_VECTOR := "11111001"; --main counter max: 249
constant amp_zeros : std_logic_vector(7 downto 0) := (others => '0');
constant freq_zeros : std_logic_vector(17 downto 0) := (others => '0');

begin

	SAW_AMP: process (clk, Saw_clk)
	begin
		if reset = '1'
		elsif(rising_edge(Saw_clk)) then
			amplitude_sawtooth <= amplitude_sawtooth +1;
		end if;
	end process SAW_AMP;

	Internal_PWM: process(clk, reset)
	begin
			 if reset = '1' then
	       amplitude_count <= amp_zeros; -- Set output to 0
				 saw_pwm <='0';
			elsif (rising_edge(clk)) then

					if(amplitude_count <= amplitude_sawtooth) then
						saw_pwm <= '1';
					else
						saw_pwm <= '0';
					end if;

					if (amplitude_count < max_value) then -- restart pwm cycle
						amplitude_count <= amplitude_count + '1';
					elsif (amplitude_count >= max_value) then
						amplitude_count <= amp_zeros;
					end if;
		end if;
end process Internal_PWM;

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
			wave_out <= sawtooth_out;
		end if;
end process Wave;

end Behavioral;
