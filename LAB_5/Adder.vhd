library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Adder is
  port (
    clk: in std_logic;
    reset: in std_logic;
    CLK_50Hz: in std_logic;
    MSB: in std_logic_vector (2 downto 0);
    LSB: in std_logic_vector (2 downto 0);
    Six_Bits: out std_logic_vector (5 downto 0)
  );
end Adder;

architecture Behavioral of Adder is

--signals
signal Six_Bits_i: std_logic_vector (5 downto 0) := "000000";
constant Delay_Oh1_Max: std_logic_vector(19 downto 0) := "11110100001001000000"; --one mil
signal Count_Oh1_Delay: std_logic_vector(19 downto 0) := "00000000000000000000";
signal Start_Count_Oh1: std_logic;

begin

  Adder: process (CLK_50Hz, clk, reset)
  begin
    if reset = '1' then
      Six_Bits_i <= "000000";
    elsif rising_edge(clk) then
      if (CLK_50Hz='1') then
		Start_Count_Oh1 <= '1';
	
	  elsif Start_Count_Oh1 = '1' then
        if Count_Oh1_Delay = Delay_Oh1_Max then
          Six_Bits_i <= (MSB(2), MSB(1), MSB(0), LSB(2), LSB(1), LSB(0));
          Count_Oh1_Delay <= "00000000000000000000";
		  Start_Count_Oh1 <= '0';
        else
          Count_Oh1_Delay <= Count_Oh1_Delay + 1;
        end if;
      end if;
    end if;
  end process Adder;

  Six_Bits <= Six_Bits_i;

end Behavioral;
