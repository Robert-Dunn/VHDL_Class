----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/29/2017 03:42:15 PM
-- Design Name: 
-- Module Name: tb_digital_clock - Behavioral
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

entity tb_digital_clock is
end tb_digital_clock;

architecture Behavioral of tb_digital_clock is

COMPONENT digital_clock
    PORT(
         clk : in  STD_LOGIC;
         reset : in  STD_LOGIC;
         enable: in STD_LOGIC;
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
          AN4 : out STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal enable : std_logic := '1';
   signal reset : std_logic := '0';
   
 	--Outputs
  
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: digital_clock PORT MAP (
          clk => clk,
          enable => enable,
          reset => reset,
 
          CA => CA,
          CB => CB,
          CC => CC,
          CD => CD,
          CE => CE,
          CF => CF,
          CG => CG,
          DP => DP,
          AN1=> AN1,
          AN2=> AN2,
          AN3=> AN3,
          AN4=> AN4 
          );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      reset<= '0';
      wait for 100ns;
		reset <= '1';
	  wait for 100 ns;
		reset <= '0';
      wait for 100 ns;
		enable <= '0';
	  wait for 100 ns;
	    enable <= '1';
	  wait;

   end process;