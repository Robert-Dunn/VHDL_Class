----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/15/2017 03:33:45 PM
-- Design Name: 
-- Module Name: tb_sequential_logic - Behavioral
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

entity tb_sequential_logic is
end tb_sequential_logic;



architecture Behavioral of tb_sequential_logic is
--Clock period definitions
constant clk_period : time := 10ns;
-- Component Declaration for the UUT
COMPONENT Switch_logic
PORT(
switches_inputs : IN std_logic_vector(2 downto 0);
outputs : OUT std_logic_vector(2 downto 0);
 clk : in STD_LOGIC;
 reset : in STD_LOGIC
);
END COMPONENT;
--Inputs
signal switches_inputs : std_logic_vector(2 downto 0) := (others =>
'0');
--Outputs
signal outputs : std_logic_vector(2 downto 0); 
signal clk, reset :std_logic;
begin

--clock process definitions
clk_process : process 
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

-- reset process definitions
reset_process : process
begin
    reset <= '0';
    wait for 50ns;
    reset <= '1';
    wait for 10ns;
    reset <= '0';
end process;

-- Instantiate the Unit Under Test (UUT)
uut: switch_logic PORT MAP (
switches_inputs => switches_inputs,
outputs => outputs,
 clk => clk,
 reset => reset
);

A_process: process
        begin
            switches_inputs(0) <='0';
            wait for 50ns;
            switches_inputs(0) <= '1';
            wait for 50ns;
        end process;
    
B_process: process
        begin
            switches_inputs(1) <='0';
            wait for 100ns;
            switches_inputs(1) <= '1';
            wait for 100ns;
        end process;
        
C_process: process
        begin
            switches_inputs(2) <='0';
            wait for 200ns;
            switches_inputs(2) <= '1';
            wait for 200ns;
         end process;            
--Stimulusprocesshere
-- Stimulus process
stim_proc: process
begin
---- hold resetstatefor 100 ns.
--wait for 100ns;
---- Set all inputs to 0
--switches_inputs(0)<='0'; --A
--switches_inputs(1)<='0'; --B
--switches_inputs(2)<='0'; --C
--wait for 50 ns;
---- Test an input combination
--switches_inputs(0)<='1'; --A
--switches_inputs(1)<='0'; --B
--switches_inputs(2)<='1'; --C
--wait for 100ns;
--wait; -- Keeps it from restarting
end process;

end Behavioral;
