CLK_250hz: process
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
  end process CLK_250hz;
CLK_250hz <= CLK_DIV_250hz;
