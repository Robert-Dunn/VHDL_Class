LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_sevensegment IS
END tb_sevensegment;
 
ARCHITECTURE behavior OF tb_sevensegment IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sevensegment
    PORT(
         CA : OUT  std_logic;
         CB : OUT  std_logic;
         CC : OUT  std_logic;
         CD : OUT  std_logic;
         CE : OUT  std_logic;
         CF : OUT  std_logic;
         CG : OUT  std_logic;
         DP : OUT  std_logic;
         dp_in : IN  std_logic;
         data : IN  std_logic_vector(3 downto 0)
        );
    END COMPONENT;   

   --Inputs
   signal dp_in : std_logic := '0';
   signal data : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal CA : std_logic;
   signal CB : std_logic;
   signal CC : std_logic;
   signal CD : std_logic;
   signal CE : std_logic;
   signal CF : std_logic;
   signal CG : std_logic;
   signal DP : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sevensegment PORT MAP (
          CA => CA,
          CB => CB,
          CC => CC,
          CD => CD,
          CE => CE,
          CF => CF,
          CG => CG,
          DP => DP,
          dp_in => dp_in,
          data => data
        );


   -- Stimulus process
   stim_proc: process
   begin		
		  wait for 100 ns;

      wait;
   end process;

END;