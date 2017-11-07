library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_Clock_divider_lab4 is
end TB_Clock_divider_lab4;

architecture Behavioral of TB_Clock_divider_lab4 is
      component clock_divider is
        generic ( N_250k : natural := 400;
                 N_125k : natural := 800;
                 N_25k : natural := 4000;
                 N_12p5k : natural := 8000;
                 N_2p5k : natural := 40000;
                 N_250hz : natural := 400000
                 );
        port( CLK: in std_logic;
              RST: in std_logic;
              CLK_250k : out std_logic;
              CLK_125k : out std_logic;
              CLK_25k : out std_logic;
              CLK_12p5k : out std_logic;
              CLK_2p5k : out std_logic;
              CLK_250hz : out std_logic
              );
      end component;
    constant N_250k : natural := 400;
    constant N_125k : natural := 800;
    constant N_25k : natural := 4000;
    constant N_12p5k : natural := 8000;
    constant N_2p5k : natural := 40000;
    constant N_250hz : natural := 400000;
    signal CLK: std_logic;
    signal RST: std_logic;
    signal CLK_250k: std_logic;
    signal CLK_125k: std_logic;
    signal CLK_25k: std_logic;
    signal CLK_12p5k: std_logic;
    signal CLK_2p5k: std_logic;
    signal CLK_250hz: std_logic;
    constant ClkPeriod : time := 10 ns;
begin
      UUT: clock_divider
          generic map(
              N_250k => N_250k,
              N_125k => N_125k,
              N_25k => N_25k,
              N_12p5k => N_12p5k,
              N_2p5k => N_2p5k,
              N_250hz => N_250hz
          )
          port map (
              CLK => CLK,
              RST => RST,
              CLK_250k => CLK_250k,
              CLK_125k => CLK_125k,
              CLK_25k => CLK_25k,
              CLK_12p5k => CLK_12p5k,
              CLK_2p5k => CLK_2p5k,
              CLK_250hz => CLK_250hz
      );
    clk_process : process
        begin
          CLK <= '0';
          wait for ClkPeriod/2;
          CLK <= '1';
          wait for ClkPeriod/2;
        end process;
    rst_process: process
        begin
          RST <= '1';
          wait for 4*ClkPeriod;
          RST <= '0';
          wait;
        end process;
end Behavioral;
