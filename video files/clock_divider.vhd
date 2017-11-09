library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CLOCK_DIVIDER is
      generic (N : natural := 10);
      port( CLK, RST: in std_logic;
            CLK_OUT : out std_logic);
end CLOCK_DIVIDER;
architecture Behavioral of CLOCK_DIVIDER is
          signal CLOCK_DIV: std_logic;
          signal COUNT: std_logic_vector(3 downto 0);
      begin
        process(CLK, RST)
          begin
              if RST = '1' then
                  COUNT <= (others => '0');
                  CLOCK_DIV <= '0';
              elsif rising_edge(CLK) then
                  COUNT <= COUNT + 1;
                  if COUNT = N-1 then
                    COUNT <= (others => '0');
                    CLOCK_DIV <= '1';
                  else
                    CLOCK_DIV <= '0';
                end if;
              end if;
            end process;
          CLK_OUT <= CLOCK_DIV;
end Behavioral;
