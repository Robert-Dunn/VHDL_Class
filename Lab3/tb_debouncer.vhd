----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 02/10/2017 06:25:33 AM
-- Design Name:
-- Module Name: tb_debouncer - behavioral
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

entity tb_debouncer is
--  Port ( );
end tb_debouncer;

architecture behavioral of tb_debouncer is
component debouncer is
    generic(mtimes: natural := 10);
    port ( clk : in STD_LOGIC;
           asynch_in : in STD_LOGIC;
           synch_debounced : out STD_LOGIC);
end component;
constant mtimes: natural := 10;
constant clk_period: time:= 10 ns;
signal sx, sclk, sy: std_logic;
begin
uut: debouncer
    generic map(mtimes => mtimes)
    port map ( clk => sclk,
               asynch_in => sx,
               synch_debounced => sy);

deb: process
begin
    sx <= '1';
    wait for 11*clk_period;
    sx <= '1';
    wait for 3*clk_period;
    sx <= '0';
    wait for clk_period;
    sx <= '1';
    wait for 7*clk_period;
    sx <= '0';
    wait for clk_period;

end process;

clk_process: process
begin
    sclk <= '1';
    wait for clk_period/2;
    sclk <= '0';
    wait for clk_period/2;
end process;

end behavioral;
