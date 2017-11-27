library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity clock_divider_lab5 is
    generic (N_25M : natural := 4
             );
    port(   CLK, RST: in std_logic;
            CLK_25M: out std_logic
            );
end clock_divider_lab5;

architecture Behavioral of clock_divider_lab5 is
    signal CLK_DIV_25M: std_logic;
    
    signal COUNT_25M: std_logic_vector(2 downto 0);

  begin
    CLK_25M_proc: process(CLK, RST)
      begin
          if rising_edge(CLK) then
              if RST = '1' then
                  COUNT_25M <= (others => '0');
                  CLK_DIV_25M <= '0';
              else
                  COUNT_25M <= COUNT_25M +1;
                  if COUNT_25M = N_25M - 1 then
                      COUNT_25M <= (others => '0');
                      CLK_DIV_25M <= '1';
                  else
                      CLK_DIV_25M <= '0';
                  end if;
              end if;
          end if;
      end process CLK_25M_proc;
    CLK_25M <= CLK_DIV_25M;

end Behavioral;
