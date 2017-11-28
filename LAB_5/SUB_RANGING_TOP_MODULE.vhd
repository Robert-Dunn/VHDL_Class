library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SUB_RANGING_TOP_MODULE is
	Port (
			clk: in STD_LOGIC;
			reset: in STD_LOGIC;
			TOP_8: in STD_LOGIC_VECTOR(7 downto 0);
			BOTTOM_8: in STD_LOGIC_VECTOR(7 downto 0);
			MSB_out: out STD_LOGIC_VECTOR(2 downto 0);
			LSB_LEDS: out STD_LOGIC_VECTOR(2 downto 0);
			MSB_LEDS: out STD_LOGIC_VECTOR(2 downto 0);
			ADDER_OUTPUT: out STD_LOGIC_VECTOR(5 downto 0)
	);
end entity;
	
	
architecture Behavioural of SUB_RANGING_TOP_MODULE is
--components

component clock_divider is 
    port(   CLK, RST: in std_logic;
            CLK_50hz: out std_logic
            );
end component;


component MSB_Encoder is
	port (
		clk: in std_logic;
		reset: in std_logic;
		CLK_50Hz: in std_logic;
		Top_eight: in std_logic_vector (7 downto 0);
		MSB_Out: out std_logic_vector (2 downto 0);
		MSB: out std_logic_vector (2 downto 0)
  );

end component;


component LSB_Encoder is
  port (
    clk: in std_logic;
    reset: in std_logic;
    CLK_50Hz: in std_logic;
    Bottom_eight: in std_logic_vector (7 downto 0);
    LSB: out std_logic_vector (2 downto 0)
  );
end component;

component Adder is
 port (
    clk: in std_logic;
    reset: in std_logic;
    CLK_50Hz: in std_logic;
    MSB: in std_logic_vector (2 downto 0);
    LSB: in std_logic_vector (2 downto 0);
    Six_Bits: out std_logic_vector (5 downto 0)
  );
end component;



signal MSB,LSB : STD_LOGIC_VECTOR(2 downto 0);
signal CLK_50hz : STD_LOGIC;
signal Adder_LEDS: STD_LOGIC_VECTOR(5 downto 0);



begin
CLOCK_DIV :clock_divider
	Port Map 
			(
			CLK	=>clk,
			RST=>reset,
			CLK_50hz =>CLK_50hz
			);
			
MSB_E: MSB_Encoder 
	Port Map 
			(
			clk => clk,
			reset=> reset,
			CLK_50Hz => CLK_50Hz,
			Top_eight=>TOP_8,
			MSB_Out => MSB_out,
			MSB => MSB
			);
LSB_E: LSB_Encoder 
	Port Map 
			(
			clk => clk,
			reset=> reset,
			CLK_50Hz => CLK_50Hz,			
			Bottom_eight => BOTTOM_8,
			LSB=>LSB
			
			);
ADDER_I: Adder
	Port Map 
			(
			clk => clk,
			reset=> reset,
			CLK_50Hz => CLK_50Hz,
			MSB => MSB,
			LSB => LSB,
			Six_Bits => Adder_LEDS
			);
LSB_LEDS<= LSB;
MSB_LEDS<= MSB;		
ADDER_OUTPUT <= Adder_LEDS;

end Behavioural;
