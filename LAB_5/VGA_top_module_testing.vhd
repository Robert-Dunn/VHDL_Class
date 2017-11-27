library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity VGA_top_module is
    Port ( 
            clk: in STD_LOGIC;
            --pixel_clk : in  STD_LOGIC; --25MHz
            --reset : in STD_LOGIC;
            --switches: in STD_LOGIC_VECTOR(1 downto 0);
            hsync: out STD_LOGIC;
            vsync: out STD_LOGIC;
            box_red: out STD_LOGIC_VECTOR (3 downto 0);
            box_green: out STD_LOGIC_VECTOR (3 downto 0);
            box_blue: out STD_LOGIC_VECTOR (3 downto 0)
	 );
end VGA_top_module;

architecture Behavioral of vga_top_module is
-- Components:
component sync_signals_generator is
    Port ( 
           pixel_clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           hor_sync: out STD_LOGIC;
           ver_sync: out STD_LOGIC;
           blank: out STD_LOGIC;
           scan_line_x: out STD_LOGIC_VECTOR(10 downto 0);
           scan_line_y: out STD_LOGIC_VECTOR(10 downto 0)
		  );
end component;

component print_num is
	Port (
		scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
		scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
        unit: in std_logic_vector(1 downto 0); --state in binary
        output_1: in integer;
		output_2: in integer;
		output_3: in integer;
		output_4: in integer;
		box_color: in  std_logic_vector(11 downto 0);
		red: out std_logic_vector(3 downto 0);
		blue: out STD_LOGIC_VECTOR(3 downto 0);
		green: out std_logic_vector(3 downto 0)
	);
end component;

component clock_divider_lab5
   generic (N_25M : natural := 4
             );
    port(  
            CLK, RST: in std_logic;
            CLK_25M: out std_logic
            );
end component;


-- Signals:
signal reset: std_logic := '0';
signal disp_blue: std_logic_vector(3 downto 0);
signal disp_red: std_logic_vector(3 downto 0);
signal disp_green: std_logic_vector(3 downto 0);
signal color: std_logic_vector(11 downto 0):="000000000000";
signal switches:std_logic_vector(1 downto 0):="01";
-- Clock divider signals:
signal i_pixel_clk: std_logic;
-- Sync module signals:
signal vga_blank : std_logic;
signal scan_line_x, scan_line_y: STD_LOGIC_VECTOR(10 downto 0);

constant output1: integer :=7;
constant output2: integer :=4;
constant output3: integer :=8;
constant output4: integer :=6;
constant N_25M: natural :=4;

begin

VGA_SYNC: sync_signals_generator
    Port map( 	pixel_clk   => i_pixel_clk,
                reset       => reset,
                hor_sync    => hsync,
                ver_sync    => vsync,
                blank       => vga_blank,
                scan_line_x => scan_line_x,
                scan_line_y => scan_line_y
			  );

BOX: print_num
    Port map (
               scan_line_x => scan_line_x,
               scan_line_y => scan_line_y,
			   unit		   => switches,
			   output_1    => output1,
			   output_2    => output2,
			   box_color   => color,
			   output_3    => output3,
			   output_4    => output4,
               red         => disp_red,
               blue        => disp_blue,
               green       => disp_green
           );
DIVIDER: clock_divider_lab5
    Port map ( CLK              => clk,
               RST              =>  reset,
               CLK_25M          => i_pixel_clk

		  );
-- BLANKING:
box_red <= "0000" when (vga_blank = '1') else disp_red;
box_blue  <= "0000" when (vga_blank = '1') else disp_blue;
box_green <= "0000" when (vga_blank = '1') else disp_green;

--box_red    <=  disp_red;
--box_blue   <=  disp_blue;
--box_green  <=  disp_green;



end Behavioral;