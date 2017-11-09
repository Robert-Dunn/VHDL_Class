architecture beh of equations is
signal Q1, Q0: std_logic;
  begin
    process(RST, CLK)
      begin
        if RST = '1' then
            Q1 <= '0'; Q0 <= '0';
          elsif rising_edge(CLK) then
            Q1 <= Q0 and W;
            Q0 <= ((not Q1)and W) or ((not Q1) and Q0) or (Q0 and W);
          end if;
        end process;
      Z <= Q1 and Q0;
end beh;
