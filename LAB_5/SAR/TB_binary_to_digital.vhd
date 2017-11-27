library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity TB_digital_to_distance is
end TB_digital_to_distance;

architecture Behavioral of TB_digital_to_distance is
  component digital_to_distance is
	Port (
		reset: in STD_LOGIC;
		clk: in std_logic;
		done: in std_logic;
		switches: in std_logic_vector(1 downto 0);
		binary_input: in STD_LOGIC_VECTOR(7 downto 0);
		tens: out integer;
		ones: out integer;
		tenths: out integer;
		hundredths: out integer
	);
end component;

signal clk, reset, done: std_logic;
signal switches: std_logic_vector(1 downto 0);
signal binary_input: std_logic_vector(7 downto 0);
signal ones,tens,tenths,hundredths: integer;
constant ClkPeriod: time := 10 ns;

begin
    UUT: digital_to_distance port map(
        clk => clk,
        reset => reset,
        switches => switches,
        done => done,
        binary_input => binary_input,
        ones=>ones,
        tens=>tens,
        tenths=>tenths,
        hundredths=>hundredths
    );

        clk_process : process
            begin
              clk <= '0';
              wait for ClkPeriod/2;
              clk <= '1';
              wait for ClkPeriod/2;
        end process;
		
        rst_process: process
            begin
              reset <= '1';
              wait for 4*ClkPeriod;
              reset <= '0';
			  wait;
        end process;

        done_process: process
          begin
              done <= '0';
			  wait for 10*ClkPeriod;
			  done <= '1';
			  wait;
          end process;
		  
		 switches_process: process
			begin
			switches <= "00";
			wait for 50*ClkPeriod;
			switches <= "11";
			wait for 50*ClkPeriod;
			end process;
		binary_input_process: process
			begin
			binary_input <= "00000000";
			wait for 25*ClkPeriod;
			binary_input<="11111111";
			wait for 25*ClkPeriod;
			binary_input <= "00000000";
			wait for 25*ClkPeriod;
			binary_input<="11111111";
			wait for 25*ClkPeriod;
			end process;
end Behavioral;
