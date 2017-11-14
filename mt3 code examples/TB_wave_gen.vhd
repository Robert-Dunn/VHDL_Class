library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity TB_wave_gen is
end TB_wave_gen;

architecture Behavioral of TB_wave_gen is
      component clock_divider is
        port( reset : in STD_LOGIC;
               clk : in STD_LOGIC; -- clk is >> than 1 kHz, i.e. 100kHz and above
               clk_1kHz_pulse :  in STD_LOGIC;
               PWM_OUT : out STD_LOGIC
              );
      end component;

      signal reset : STD_LOGIC;
      signal clk : STD_LOGIC; -- clk is >> than 1 kHz, i.e. 100kHz and above
      signal clk_1kHz_pulse : STD_LOGIC;
      signal PWM_OUT : STD_LOGIC;
    constant ClkPeriod : time := 10 ns;
    constant N_1k : natural := 100000;
    signal COUNT_1k : std_logic_vector(16 downto 0);

begin
      UUT: clock_divider
          port map (
              reset => reset,
              clk => clk,
              clk_1kHz_pulse => clk_1kHz_pulse,
              PWM_OUT => PWM_OUT
      );
    clk_process : process
        begin
          CLK <= '0';
          wait for ClkPeriod/2;
          CLK <= '1';
          wait for ClkPeriod/2;
        end process;

    clk_1k_process : process
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                COUNT_1k <= (others => '0');
                clk_1kHz_pulse <= '0';
            else
                COUNT_1k <= COUNT_1k +1;
                if COUNT_1k = N_1k -1 then
                    COUNT_1k <= (others => '0');
                    clk_1kHz_pulse <= '1';
                else
                    clk_1kHz_pulse <= '0';
                end if;
            end if;
        end if;
    end process;

    rst_process: process
        begin
          RST <= '1';
          wait for 4*ClkPeriod;
          RST <= '0';
          wait;
        end process;
end Behavioral;
