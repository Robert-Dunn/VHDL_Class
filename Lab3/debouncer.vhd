----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/10/2017 06:17:15 AM
-- Design Name: 
-- Module Name: debouncer - behavioral
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

entity debouncer is
    generic(mtimes: natural := 10);
    port ( clk : in STD_LOGIC;
           x : in STD_LOGIC;
           y : out STD_LOGIC);
end debouncer;

architecture behavioral of debouncer is
signal scounter: natural range 0 to mtimes-1;
signal sx: std_logic_vector(1 downto 0);
begin
deb: process(clk)
begin
if(rising_edge(clk)) then
    sx <= sx(0) & x;
    if((sx(0) and sx(1)) = '1') then
        if(scounter = mtimes-1) then
            y <= '1';
            scounter <= 0;
        else
            y <= '0';
            scounter <= scounter+1;
        end if;
    else
        y <= '0';
        scounter <= 0;
    end if;
end if;
end process;
end behavioral;
