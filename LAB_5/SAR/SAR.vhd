library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SAR is
Generic ( width : integer := 8);
Port(
     clk : in std_logic;
     reset : in std_logic;
	 comparator_output : in std_logic;
	 duty_cycle : out std_logic_vector (width-1 downto 0):="10000000";  
	 done : out std_logic
	 );
end entity;

architecture Behavioural of SAR is

signal done_count : std_logic_vector(2 downto 0):="000";
signal bit_count : std_logic_vector (2 downto 0) := "001";

begin
comparing : process (clk, reset)
	begin
		if( reset = '1') then
            duty_cycle <= ("10000000");
			bit_count <= "111";
			done_count <= "000";
        elsif (rising_edge(clk)) then 
			done_count <= done_count + '1';
			bit_count <=bit_count + '1';
			if (comparator_output = '1' and bit_count <="111")then 
				duty_cycle(8 - (to_integer(unsigned(bit_count)))) <= '1';
				duty_cycle(7 - (to_integer(unsigned(bit_count)))) <= '1';
			elsif(comparator_output = '0' and bit_count <="111") then
				duty_cycle(8 - (to_integer(unsigned(bit_count)))) <= '0';
				duty_cycle(7 - (to_integer(unsigned(bit_count)))) <= '1';
			elsif(done_count = "111") then
				done <= '0';
				done_count <= "000";
				bit_count <= "111";
				duty_cycle <= "10000000";
			end if;
        end if;
    end process;

end Behavioural;
