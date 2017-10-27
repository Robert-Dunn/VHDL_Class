-- libraries

entity DETECT is
      port( CLK, RST: in std_logic;
            Z: out std_logic);
end DETECT;

architecture Behavioral of DETECT is
  type STATETYPE is (A,B,C);
  signal Y_Curr, Y_Next: STATETYPE; -- two signals this time
  -- first process describes logic of next state
-- no z defining within process now
begin
  process(W, Y_Curr)
    begin
      case Y_Curr is
        when A =>
          if W = '0' then Y_Next <= A;
                      else Y_Next <= B;
        end if;
      when B =>
        if W = '0' then Y_Next <= A;
                    else Y_Next <= B;
        end if;
      end case;
    end process;

    process (RST, CLK)
      begin
        if RST = '1' then
          Y_Curr <= A;
        elsif rising_edge(CLK) then
          Y_Curr <= Y_Next;
        end if;
      end process;

  Z <= '1' when Y_Curr = C else '0';

end Behavioral;
