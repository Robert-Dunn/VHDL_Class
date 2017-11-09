-- libraries

entity DETECT is
      port( CLK, RST: in std_logic;
            Z: out std_logic);
end DETECT;

architecture Behavioral of DETECT is
  type STATETYPE is (A,B);
  signal Y: STATETYPE;

begin
  process(RST, CLK)
    begin
      if RST = '1' then
          Y <= A;
      elsif rising_edge(CLK) then
          case Y is
            when A =>
              if W = '0' then Y <= A;
            else Y <= B;
              end if;
            when B =>
              if W = '0' then Y <= A;
                else Y <= B;
              end if;
            end case;
          end if;
    end process;
  Z <= '1' when (Y = B and W = 1)
  else Z <= '0';
end Behavioral;
