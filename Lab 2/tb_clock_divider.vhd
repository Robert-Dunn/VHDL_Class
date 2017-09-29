LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_clock_divider IS
END tb_clock_divider;
 
ARCHITECTURE behavior OF tb_clock_divider IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT clock_divider
    PORT(
         clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable: in STD_LOGIC;
			kHz: out STD_LOGIC;
			singleSecPort: out STD_LOGIC_VECTOR(3 downto 0);
			tenSecPort: out STD_LOGIC_VECTOR(2 downto 0);
			minutePort: out STD_LOGIC_VECTOR(3 downto 0);
			tenMinutePort: out STD_LOGIC_VECTOR(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal enable : std_logic := '1';
   signal reset : std_logic := '0';
   
 	--Outputs
   signal kilohertz : std_logic;
   signal singleSecPort: STD_LOGIC_VECTOR(3 downto 0);
	signal tenSecPort: STD_LOGIC_VECTOR(2 downto 0);
	signal minutePort: STD_LOGIC_VECTOR(3 downto 0);
	signal tenMinutePort: STD_LOGIC_VECTOR (2 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: clock_divider PORT MAP (
          clk => clk,
          enable => enable,
          kHz => kilohertz,
          reset => reset,
		  singleSecPort => singleSecPort,
		  tenSecPort => tenSecPort,
		  minutePort => minutePort,
		  tenMinutePort => tenMinutePort
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
		reset <= '1';
	  wait for 100 ns;
		reset <= '0';
      wait for 100 ns;
		enable <= '0';
	  wait for 100 ns;
	    enable <= '1';
	  wait;

   end process;

END; 
