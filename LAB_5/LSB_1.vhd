library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity LSB_Encoder is
  port (
    clk: in std_logic;
    reset: in std_logic;
    CLK_50Hz: in std_logic;
    Bottom_eight: in std_logic_vector (7 downto 0);
    LSB: out std_logic_vector (2 downto 0)
  );
end LSB_Encoder;

architecture Behavioral of LSB_Encoder is

--signals
signal LSB_i: std_logic_vector (2 downto 0);
constant Delay_5us_Max: std_logic_vector(8 downto 0) := "111110100"; -- 500 in decimal 
signal Count_5us_Delay: std_logic_vector(8 downto 0) := "000000000";
signal Start_Count_5us: std_logic := '0';

begin

  encode: process (CLK_50Hz, clk, reset)
  begin
    if reset = '1' then
      LSB_i <= "000";
    elsif rising_edge(clk) then
    
      if (CLK_50Hz='1') then
        Start_Count_5us <= '1';   
      
      elsif Start_Count_5us = '1' then 
        if (Count_5us_Delay = Delay_5us_Max) then
            if Bottom_eight = "00000000" then
              LSB_i <= "000";
            elsif Bottom_eight = "00000010" then
              LSB_i <= "001";
            elsif Bottom_eight = "00000110" then
              LSB_i <= "010";
            elsif Bottom_eight = "00001110" then
              LSB_i <= "011";
            elsif Bottom_eight = "00011110" then
              LSB_i <= "100";
            elsif Bottom_eight = "00111110" then
              LSB_i <= "101";
            elsif Bottom_eight = "01111110" then
              LSB_i <= "110";
            elsif Bottom_eight = "11111110" then
              LSB_i <= "111";
            else
              LSB_i <= "000";
            end if;
            Count_5us_Delay <= "000000000";
            Start_Count_5us <= '0';
        else
            Count_5us_Delay <= Count_5us_Delay + 1;
        end if;
      end if; 
      
      
    end if;

  end process encode;

  LSB <= LSB_i;

end Behavioral;