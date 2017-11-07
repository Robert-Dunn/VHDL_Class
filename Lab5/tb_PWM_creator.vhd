library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity PWM_TB is
end PWM_TB;
architecture Behavioral of PWM_TB is
  component PWM is
    Port (
       clk: in std_logic;
       reset: in std_logic;
       amplitude: in STD_LOGIC_VECTOR(7 downto 0);
       square_frequency: in STD_LOGIC_VECTOR(17 downto 0);
       PWM_out: out STD_LOGIC
       );
  end component;
   signal clk, reset: std_logic := '0';
   signal amplitude: std_logic_vector(7 downto 0);
   signal square_frequency: std_logic_vector(17 downto 0);
   signal PWM_out: std_logic;
   constant ClkPeriod: time := 10 ns;
begin
    UUT: PWM port map(
        clk => clk,
        reset => reset,
        amplitude => amplitude,
        square_frequency => square_frequency,
        PWM_out => PWM_out
    );

    clk_process : process
        begin
          clk <= '0';
          wait for clk_period/2;
          clk <= '1';
          wait for clk_period/2;
    end process;
    rst_process: process
        begin
          reset <= '1';
          wait for 4*ClkPeriod;
          reset <= '0';
          wait;
    end process;

    amplitude_process: process
      begin
        amplitude <= "00001010";
        wait for 500*ClkPeriod;
        amplitude <= amplitude + 10;
        wait for 500*ClkPeriod;
        amplitude <= amplitude + 10;
        wait for 500*ClkPeriod;
        amplitude <= amplitude + 10;
        wait for 500*ClkPeriod;
        amplitude <= amplitude + 10;
        wait for 500*ClkPeriod;
        amplitude <= amplitude + 10;
        wait for 500*ClkPeriod;
        amplitude <= amplitude + 10;
    end process;

    square_frequency_process: process
      begin
        square_frequency <= "000000000001100100"; -- 1kHz
        wait for 1000000*ClkPeriod;
        square_frequency <= "000000000011001000"; -- 500 Hz
        wait for 1000000*ClkPeriod;
        square_frequency <= "000000001111101000"; -- 100 Hz
        wait for 1000000*ClkPeriod;
        square_frequency <= "000000011111010000"; -- 50 Hz
        wait for 1000000*ClkPeriod;
        square_frequency <= "000010011100010000"; -- 10 Hz
        wait for 1000000*ClkPeriod;
        square_frequency <= "011000011010100000"; -- 1 Hz
    end process;
end architecture
