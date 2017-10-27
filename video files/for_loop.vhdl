entity parity is
port (DATA: in std_logic_vector(3 downto 0);
      ODD : std_logic);
end parity;
architecture RTL of parity is
  shared variable global; integer := 0;
  begin
    process (DATA)
      variable TMP : std_logic;
        begin TMP := '0';
        for I in 0 to 3 loop
            TMP := TMP xor DATA(I);
        end loop;
      ODD <= TMP;
    end process;
end RTL;
