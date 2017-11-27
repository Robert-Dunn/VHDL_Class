library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SAR_top_module is
    Generic ( width : integer := 8);
	Port(
		 clk : in std_logic;
		 reset : in std_logic;
		 comparator_output : in std_logic;
         pwm_out : out STD_LOGIC;
		 done: out STD_LOGIC;
		 voltage_3_3 : out STD_LOGIC;
		 voltage_0: out STD_LOGIC
	);
end SAR_top_module;	

architecture Behavioral of SAR_top_module is
-- Components:
component SAR is
    Generic ( width : integer := 8);
    Port( 
	     clk : in std_logic;
		reset : in std_logic;
		comparator_output : in std_logic;
		duty_cycle : out std_logic_vector (width-1 downto 0):="10000000";  
		done : out std_logic
		);
end component;

component PWM_DAC is 
    Port ( 
		   reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           duty_cycle : in STD_LOGIC_VECTOR (width-1 downto 0):= "10000000";
           pwm_out : out STD_LOGIC
          );
end component;

signal duty_cycle_i : std_logic_vector(7 downto 0);
signal pwm_out_i: STD_LOGIC;
signal done_i:STD_LOGIC;
--constant width: integer := 8;

begin
SAR_1: SAR
	Port Map
			(
			 clk => clk,
			 reset=> reset,
			 comparator_output=>comparator_output,
			 duty_cycle=>duty_cycle_i,
			 done=>done_i
			);
PWM_DAC_1:PWM_DAC
	Port Map	
			(
			 reset=>reset,
			 clk=>clk,
			 duty_cycle=>duty_cycle_i,
			 pwm_out=>pwm_out_i
			);
			
pwm_out<=pwm_out_i;
done<=done_i;
voltage_3_3 <= '1';
voltage_0 <= '0';
end Behavioral;


