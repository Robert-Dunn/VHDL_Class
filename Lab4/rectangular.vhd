library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PWM is
	Port (
		 clk: in std_logic;
		 reset: in std_logic;
		 amplitude: in STD_LOGIC_VECTOR(7 downto 0);
		 square_frequency: in STD_LOGIC_VECTOR(2 downto 0);
		 PWM_out: out STD_LOGIC

	);
end PWM;


architecture Behavioral of PWM is

signal amplitude_count:  STD_LOGIC_VECTOR( 7 downto 0) = "000000000";
signal Output_State : std_logic:= '0';
signal i_pwm std_logic;
signal count_maxs :  std_logic = '0';
signal MHz_50 : std_logic:='0';
constant max_value : STD_LOGIC := "11111001" ; --249
constant zeros: std_logic_vector(7 downto 0) := (others => '0');
signal out_on: std_logic;


begin
	Internal_PWM: process(clk, reset)
	begin
        -- Asynchronous reset
	    if (reset = '1') then
	       amplitude_count <= zeros; -- Set output to 0
		elsif (rising_edge(clk)) then
			if (MHz_50 = '1') then
			  MHz_50 <= '0';
				if(amplitude_count <= amplitude) then
					i_pwm <= 1;
				else i_pwm <= 0 ;
				end if;
				if (amplitude_count < max_value) then
					amplitude_count <= amplitude_count + '1';
				elsif (amplitude_count >= max_value) then
					amplitude_count <= zeros;
					if(count_maxs >= frequency) then
						count_maxs <= zeros;
						Output_State <= ~Output_State;
					else
						count_maxs <= count_maxs + 1;
					end if;
				end if;
		    else
				MHz_50 <= '1';
			end if;
		end if;
end process Internal_PWM;

Waveform : process (Output_State, i_pwm)
begin
	if(Output_State= '1') then
		PWM_out <= i_pwm;
	elsif(Output_State = '0') then
		PWM_out <= '0';
	end if;
end process Waveform;

end Behavioral;
