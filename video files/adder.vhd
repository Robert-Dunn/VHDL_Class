-- ch4 problems video
entity SerialADD is
  port (CLK, N: std_logic;
        XI, YI: in std_logic_vector(31 downto 0);
        SUM: out std_logic_vector(31 downto 0)
        );
end SerialADD;
architecture SADD1 of SADD is
  signal K, SI, CI, CIplus, LOAD, SHIFT: std_logic;
  signal ACC, REGB: std_logic_vector(31 downto 0);
  signal STATE, NEXTSTATE: integer range 0 to 2;
  signal COUNTER: integer range 0 to 31;

begin
    K <= '1' when COUNTER = 31 else '0';
    SI <= ACC(0) and REGB(0) xor CI;
    CIplus <= (ACC(0) and REGB(0)) or (ACC(0) and CI) or (REGB(0) and CI);
    SUM <= CI & ACC; -- this is a shift

process(STATE, N, K)
  begin
    LOAD <= '0';
    SHIFT <= '0';
    case STATE is
      when 0 =>
        if N='1' then
          LOAD <= '1';
          NEXTSTATE <= 1;
        else
          NEXTSTATE <= 0;
        end if;
      when 1 =>
        if K='1' then
          SHIFT <= '1';
          NEXTSTATE <= 2;
        else
          SHIFT <= '1';
          NEXTSTATE <= 1;
        end if;
      when 2 =>
        if N = '0' then
          NEXTSTATE <= 0;
        else
          NEXTSTATE <= 2;
        end if;
      end case;
    end process;

  process (CLK)
    begin
      if rising_edge(CLK) then
        STATE <= NEXTSTATE;
        if LOAD = '1' then
          ACC <= XI;
          REGB <= YI;
        end if;
        if SHIFT = '1' then
          ACC <= SI & ACC(31 downto 0); -- shift right
          REGB < REGB ror 1; -- rotate right
          CI <= CIplus;
          if K= ''0' then
            COUNTER <= COUNTER + 1;
          else
            COUNTER <= '0';
          end if;
        end if;
      end if;
    end process;
  end SADD1;
