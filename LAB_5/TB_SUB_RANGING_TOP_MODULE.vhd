library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_SUB_RANGING_TOP_MODULE is 

end TB_SUB_RANGING_TOP_MODULE;

architecture behavioral of TB_SUB_RANGING_TOP_MODULE is 
	component SUB_RANGING_TOP_MODULE is 
			Port (
			clk: in STD_LOGIC;
			reset: in STD_LOGIC;
			TOP_8: in STD_LOGIC_VECTOR(7 downto 0);
			BOTTOM_8: in STD_LOGIC_VECTOR(7 downto 0);
			MSB_out: out STD_LOGIC_VECTOR(2 downto 0);
			ADDER_OUTPUT: out STD_LOGIC_VECTOR(5 downto 0)
	);
	end component; 
	constant clk_period: time := 10 ns;
	signal tclk, treset: std_logic;
	signal tTOP_8, tBOTTOM_8: STD_LOGIC_VECTOR(7 downto 0);
	signal tMSB_out: STD_LOGIC_VECTOR(2 downto 0);
	signal tADDER_OUTPUT: STD_LOGIC_VECTOR(5 downto 0);
	
	BEGIN
	
	uut: SUB_RANGING_TOP_MODULE
		port map ( clk => tclk,
					reset => treset,
					TOP_8 => tTOP_8,
					BOTTOM_8 => tBOTTOM_8,
					MSB_out => tMSB_out,
					ADDER_OUTPUT => tADDER_OUTPUT);
					
	reset: process 
		begin 
			treset <= '1';
			wait for 5* clk_period;
			treset <= '0';
			wait;
		end process;
	
	clk_process: process
		begin 
			tclk <= '1';
			wait for clk_period/2;
			tclk <= '0';
			wait for clk_period/2;
		end process;
	
	adder_test: process
		begin
			tTOP_8 <= "00000010";
			tBOTTOM_8 <= "00000010";
			wait for 21 ms;
			tTOP_8 <= "00000110";
			tBOTTOM_8 <= "00000110";
			wait for 20 ms;			
			tTOP_8 <= "00001110";
			tBOTTOM_8 <= "00001110";
			wait for 20 ms;			
			tTOP_8 <= "00011110";
			tBOTTOM_8 <= "00011110";
			wait for 20 ms;
			tTOP_8 <= "00011111"; -- invalid
            tBOTTOM_8 <= "00011111";
            wait for 20 ms;
		end process;
		
END;
