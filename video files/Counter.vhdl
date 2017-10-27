library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Counter is
      generic (WIDTH: integer:= 4);
      port (clk: in std_logic;
            reset: in std_logic;
            enable: in std_logic;
            Val: out std_logic_vector(WIDTH-1 downto 0)
            );
end Counter;
architecture Behavioral of Counter is

signal Current_val: std_logic_vector(WIDTH-1 downto 0) := (others => '0');
constant Zeros: std_logic_vector(WIDTH-1 downto 0) := (others => '0');
  begin
      Count: Process(clk, reset)
              begin
                if (reset ='1') then
                  current_val <= Zeros;
                elsif (rising_edge(clk)) then
                  current_val <= current_val + '1';
                end if;
              end process Count;
        Val <= current_val;
end architecture;
