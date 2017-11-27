library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity clock_divider is
    port(   CLK, RST: in std_logic;
            CLK_50hz: out std_logic
            );
end clock_divider;

architecture Behavioral of clock_divider is

    signal CLK_DIV_50hz: std_logic;
	constant N_50hz: std_logic_vector(20 downto 0):= "111101000010010000000";
    signal COUNT_50hz: std_logic_vector(21 downto 0);
  begin
  
    CLK_50hz_proc: process(CLK, RST)
      begin
          if rising_edge(CLK) then
              if RST = '1' then
                  COUNT_50hz <= (others => '0');
                  CLK_DIV_50hz <= '0';
              else
                  COUNT_50hz <= COUNT_50hz +1;
                  if COUNT_50hz = N_50hz -1 then
                      COUNT_50hz <= (others => '0');
                      CLK_DIV_50hz <= '1';
                  else
                      CLK_DIV_50hz <= '0';
                  end if;
              end if;
          end if;
      end process CLK_50hz_proc;
    CLK_50hz <= CLK_DIV_50hz;
end Behavioral;
