library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_LSB_Encoder is 

end TB_LSB_Encoder;

architecture behavioral of TB_LSB_Encoder is 
	component LSB_Encoder is 
			Port (
				clk: in std_logic;
				reset: in std_logic;
				CLK_50Hz: in std_logic;
				Bottom_eight: in std_logic_vector (7 downto 0);
				LSB: out std_logic_vector (2 downto 0)
	);
	end component; 
	constant clk_period: time := 10 ns;
	constant N_50hz: std_logic_vector(20 downto 0):= "111101000010010000000";
	signal tclk, treset: std_logic;
	signal tCLK_50Hz: std_logic;
	signal tBottom_eight: STD_LOGIC_VECTOR(7 downto 0);
	signal tLSB: STD_LOGIC_VECTOR(2 downto 0);
	
	BEGIN
	
	uut: LSB_Encoder
		port map ( clk => tclk,
					reset => treset,
					CLK_50Hz => tCLK_50Hz,
					Bottom_eight => tBottom_eight,
					LSB => tLSB);
					
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
		
	CLK_50hz_proc: process
      begin
		tCLK_50Hz <= '0';
		wait for 2000000*clk_period; 
		tCLK_50Hz <= '1';
		wait for clk_period;
    end process; 
	
	LSB_test: process
		begin
			tBottom_eight <= "00000010";
			wait for 100 ms;
			tBottom_eight <= "00000110";
			wait for 100 ms;			
			tBottom_eight <= "00001110";
			wait for 100 ms;			
			tBottom_eight <= "00011110";
			wait for 100 ms;
            tBottom_eight <= "00011111"; -- invalid
            wait for 100 ms;
		end process;
		
END;
