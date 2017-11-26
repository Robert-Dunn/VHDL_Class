library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MSB_Encoder is
  port (
    clk: in std_logic;
    reset: in std_logic;
    CLK_50Hz: in std_logic;
    Top_eight: in std_logic_vector (7 downt0 0);

    MSB_Out: out std_logic_vector (2 downto 0);
    MSB: out std_logic_vector (2 downto 0)
  );
end MSB_Encoder;

architecture Behavioral of MSB_Encoder is

--signals
signal MSB_i; std_logic_vector (2 downto 0);
constant Delay_5us_Max: std_logic_vector(8 downto 0) := "111110100";
signal Count_5us_Delay: std_logic_vector(8 downto 0) := "000000000";

begin

  encode: process (encode_clk_pulse, clk, reset)
  begin
    if reset = '1' then
      MSB_i <= "000";
    elsif rising_edge(clk) then
      if rising_edge(CLK_50Hz) then
        if Top_eight = "00000000" then
          MSB_i <= "000";
        elsif Top_eight = "00000010" then
          MSB_i <= "001";
        elsif Top_eight = "00000110" then
          MSB_i <= "010";
        elsif Top_eight = "00001110" then
          MSB_i <= "011";
        elsif Top_eight = "00011110" then
          MSB_i <= "100";
        elsif Top_eight = "00111110" then
          MSB_i <= "101";
        elsif Top_eight = "01111110" then
          MSB_i <= "110";
        elsif Top_eight = "11111110" then
          MSB_i <= "111";
        end if;
      end if;
    end if;

  end process encode;

  MSB <= MSB_i;
  MSB_Out <= MSB_i;

end Behavioral;
