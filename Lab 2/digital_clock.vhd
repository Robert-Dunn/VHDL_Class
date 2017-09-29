----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/29/2017 02:48:32 PM
-- Design Name: 
-- Module Name: digital_clock - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity digital_clock is
    Port ( 
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           AN1 : out STD_LOGIC;
           AN2 : out STD_LOGIC;
           AN3 : out STD_LOGIC;
           AN4 : out STD_LOGIC);
           
end digital_clock;

architecture Behavioral of digital_clock is
signal i_dp: STD_LOGIC;
signal i_an: STD_LOGIC_VECTOR(3 downto 0);
signal i_kHz: STD_LOGIC;
signal digit_to_display: STD_LOGIC_VECTOR(3 downto 0);

signal sec1, min1:  STD_LOGIC_VECTOR(3 downto 0);
signal sec2, min2:  STD_LOGIC_VECTOR(2 downto 0);

component sevensegment_selector is
Port(  
       clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       output : out  STD_LOGIC_VECTOR(3 downto 0);
       switch : in STD_LOGIC
);
end component;

component clock_divider is
Port( clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       kHz : out  STD_LOGIC;
       singleSecPort : out  STD_LOGIC_VECTOR(3 downto 0);
       tenSecPort : out  STD_LOGIC_VECTOR(2 downto 0);
       minuteSecPort : out  STD_LOGIC_VECTOR(3 downto 0);
       tenminutePort : out  STD_LOGIC_VECTOR(2 downto 0);
       enable: in STD_LOGIC);

end component;

component sevensegment is     
Port(  
          CA : out STD_LOGIC;
          CB : out STD_LOGIC;
          CC : out STD_LOGIC;
          CD : out STD_LOGIC;
          CE : out STD_LOGIC;
          CF : out STD_LOGIC;
          CG : out STD_LOGIC;
          DP : out STD_LOGIC;
          dp_in: in STD_LOGIC;
          data : STD_LOGIC_vector (3 downto 0)
);
end component;
begin
SELECTOR: sevensegment_selector
port map(clk=>clk,
            switch=>i_kHz,
            output=>i_an,
            reset=>reset);
DIVIDER : clock_divider
port map(
       clk=>clk,
       reset => reset,
       enable=> enable,
       kHz =>i_kHz,
       singleSecPort=>  sec1,
       tenSecPort =>  sec2,
       minuteSecPort =>  min1,
       tenminutePort =>  min2);
DISPLAY :sevensegment
Port map(
         CA => CA,
         CB => CB,
         CC => CC,
         CD => CD,
         CE => CE,
         CF => CF,
         CG => CG,
         DP => DP,
         dp_in => i_dp,
         data => digit_to_display);
         
digit_mux:process(i_an,sec1,sec2,min1,min2)
begin
   case(i_an) is
    when "0001"=> digit_to_display <= sec1;
    when "0010"=> digit_to_display <= '0' & sec2;
    when "0100"=> digit_to_display <= min1;
    when "1000"=> digit_to_display <= '0' & min2;
    when others => digit_to_display <="1111";
    end case;
  end process;
  
 AN1<=not i_an(0);
 AN2<=not i_an(1);
 AN3<=not i_an(2);
 AN4<=not i_an(3);
 
 i_dp <= i_an(2);
 
end Behavioral;
