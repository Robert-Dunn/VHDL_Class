-- libraries

entity DETECT is
      port( CLK, RST: in std_logic;
            Z: out std_logic);
end DETECT;

architecture Behavioral of DETECT is
  type STATETYPE is (A,B);
  signal Y_Curr, Y_Next: STATETYPE; -- two signals this time
  -- first process describes logic of next state

begin
  process(W, Y_Curr)
    begin
      case Y_Curr is
        when A =>
          if W = '0' then Y_Next <= A; Z <= '0';
                      else Y_Next <= B; Z <= '0';
        end if;
      when B =>
        if W = '0' then Y_Next <= A; Z <= '0';
                    else Y_Next <= B; Z <= '1';
        end if;
      end case;
    end process;

    process (RST, CLK)
      begin
        if RST = '1' then
          Y_Curr <= A;
        elsif rising_edge(CLK) then
          Y_Curr <= Y_Next;
        end if
      end process;
  Z <= '1' when (Y = B and W = 1)
  else Z <= '0';
end Behavioral;
