library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity clock_divider is
    generic (N_250k : natural := 400;
             N_125k : natural := 800;
             N_25k : natural := 4000;
             N_12p5k : natural := 8000;
             N_2p5k : natural := 40000;
             N_250hz : natural := 400000
             );
    port(   CLK, RST: in std_logic;
            CLK_250k: out std_logic;
            CLK_125k: out std_logic;
            CLK_25k: out std_logic;
            CLK_12p5k: out std_logic;
            CLK_2p5k: out  std_logic;
            CLK_250hz: out std_logic
            );
end clock_divider;

architecture Behavioral of clock_divider is
    signal CLK_DIV_250k: std_logic;
    signal CLK_DIV_125k: std_logic;
    signal CLK_DIV_25k: std_logic;
    signal CLK_DIV_12p5k: std_logic;
    signal CLK_DIV_2p5k: std_logic;
    signal CLK_DIV_250hz: std_logic;
    signal COUNT_250k: std_logic_vector(8 downto 0);
    signal COUNT_125k: std_logic_vector(9 downto 0);
    signal COUNT_25k: std_logic_vector(11 downto 0);
    signal COUNT_12p5k: std_logic_vector(12 downto 0);
    signal COUNT_2p5k: std_logic_vector(15 downto 0);
    signal COUNT_250hz: std_logic_vector(18 downto 0);
  begin
    CLK_250k_proc: process(CLK, RST)
      begin
          if rising_edge(CLK) then
              if RST = '1' then
                  COUNT_250k <= (others => '0');
                  CLK_DIV_250k <= '0';
              else
                  COUNT_250k <= COUNT_250k +1;
                  if COUNT_250k = N_250k -1 then
                      COUNT_250k <= (others => '0');
                      CLK_DIV_250k <= '1';
                  else
                      CLK_DIV_250k <= '0';
                  end if;
              end if;
          end if;
      end process CLK_250k_proc;
    CLK_250k <= CLK_DIV_250k;

    CLK_125k_proc: process(CLK, RST)
      begin
          if rising_edge(CLK) then
              if RST = '1' then
                  COUNT_125k <= (others => '0');
                  CLK_DIV_125k <= '0';
              else
                  COUNT_125k <= COUNT_125k +1;
                  if COUNT_125k = N_125k -1 then
                      COUNT_125k <= (others => '0');
                      CLK_DIV_125k <= '1';
                  else
                      CLK_DIV_125k <= '0';
                  end if;
              end if;
          end if;
      end process CLK_125k_proc;
    CLK_125k <= CLK_DIV_125k;

    CLK_25k_proc: process(CLK, RST)
      begin
          if rising_edge(CLK) then
              if RST = '1' then
                  COUNT_25k <= (others => '0');
                  CLK_DIV_25k <= '0';
              else
                  COUNT_25k <= COUNT_25k +1;
                  if COUNT_25k = N_25k -1 then
                      COUNT_25k <= (others => '0');
                      CLK_DIV_25k <= '1';
                  else
                      CLK_DIV_25k <= '0';
                  end if;
              end if;
          end if;
      end process CLK_25k_proc;
    CLK_25k <= CLK_DIV_25k;

    CLK_12p5k_proc: process(CLK, RST)
      begin
          if rising_edge(CLK) then
              if RST = '1' then
                  COUNT_12p5k <= (others => '0');
                  CLK_DIV_12p5k <= '0';
              else
                  COUNT_12p5k <= COUNT_12p5k +1;
                  if COUNT_12p5k = N_12p5k -1 then
                      COUNT_12p5k <= (others => '0');
                      CLK_DIV_12p5k <= '1';
                  else
                      CLK_DIV_12p5k <= '0';
                  end if;
              end if;
          end if;
      end process CLK_12p5k_proc;
    CLK_12p5k <= CLK_DIV_12p5k;

    CLK_2p5k_proc: process(CLK, RST)
      begin
          if rising_edge(CLK) then
              if RST = '1' then
                  COUNT_2p5k <= (others => '0');
                  CLK_DIV_2p5k <= '0';
              else
                  COUNT_2p5k <= COUNT_2p5k +1;
                  if COUNT_2p5k = N_2p5k -1 then
                      COUNT_2p5k <= (others => '0');
                      CLK_DIV_2p5k <= '1';
                  else
                      CLK_DIV_2p5k <= '0';
                  end if;
              end if;
          end if;
      end process CLK_2p5k_proc;
    CLK_2p5k <= CLK_DIV_2p5k;

    CLK_250hz_proc: process(CLK, RST)
      begin
          if rising_edge(CLK) then
              if RST = '1' then
                  COUNT_250hz <= (others => '0');
                  CLK_DIV_250hz <= '0';
              else
                  COUNT_250hz <= COUNT_250hz +1;
                  if COUNT_250hz = N_250hz -1 then
                      COUNT_250hz <= (others => '0');
                      CLK_DIV_250hz <= '1';
                  else
                      CLK_DIV_250hz <= '0';
                  end if;
              end if;
          end if;
      end process CLK_250hz_proc;
    CLK_250hz <= CLK_DIV_250hz;
end Behavioral;
