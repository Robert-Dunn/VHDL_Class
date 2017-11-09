library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity CLOCK_DIVIDER_TB is
end CLOCK_DIVIDER_TB;
architecture Behavioral of CLOCK_DIVIDER_TB is
      component CLOCK_DIVIDER is
        port(CLK, RST : in std_logic;
              CLK_OUT : out std_logic);
      end component;
    signal RST, CLK: std_logic := '0';
    signal CLK_OUT: std_logic;
    constant ClkPeriod : time := 10 ns;
begin
      UUT: CLOCK_DIVIDER port map (
              CLK => CLK,
              RST => RST,
              CLK_OUT => CLK_OUT
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
          RST <= '1';
          wait for 4*ClkPeriod;
          RST <= '0';
          wait;
        end process;
end architecture
