----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/14/2017 08:33:14 AM
-- Design Name: 
-- Module Name: Switch_logic - Behavioral
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
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Switch_logic is
Port (switches_inputs : in STD_LOGIC_VECTOR (2 downto 0);
outputs : out STD_LOGIC_VECTOR (2 downto 0);
 clk : in STD_LOGIC;
 reset : in STD_LOGIC
);
end switch_logic;

architecture Behavioral of Switch_logic is
-- Internal signals:
signal W_int: std_logic;
signal W, V, V_del: std_logic;
signal A, B, C: std_logic;
begin
--logic of switches
logic_of_switches: process(clk, reset) begin
    if (reset = '1') then
        V_del <= '0';
        V <= '0';
    elsif (rising_edge(clk)) then
        V <= (C and W_int);
        V_del <= V;
    end if;
    
end process;
-- Combinational logic! Note that "<=" is an assignment operator
W_int <= ((not B) and A) or ((not A) and B); -- models XOR
-- ADD logic for signals (W and V)
W <= W_int;

-- Assign the outputs. We only have one signal for now
outputs(0) <= W;
outputs(1) <= V;
outputs(2) <= V_del; -- We will connect this later
-- Get the inputs from the slide switches on the FPGA board
A <= switches_inputs(0);
B <= switches_inputs(1);
C <= switches_inputs(2);
end Behavioral;