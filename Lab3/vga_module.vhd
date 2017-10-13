library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vga_module is
    Port (  clk : in  STD_LOGIC;
            buttons: in STD_LOGIC_VECTOR(2 downto 0);
            switches: in STD_LOGIC_VECTOR(13 downto 0);
            red: out STD_LOGIC_VECTOR(3 downto 0);
            green: out STD_LOGIC_VECTOR(3 downto 0);
            blue: out STD_LOGIC_VECTOR(3 downto 0);
            hsync: out STD_LOGIC;
            vsync: out STD_LOGIC
	 );
end vga_module;

architecture Behavioral of vga_module is
-- Components:
component sync_signals_generator is
    Port ( pixel_clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           hor_sync: out STD_LOGIC;
           ver_sync: out STD_LOGIC;
           blank: out STD_LOGIC;
           scan_line_x: out STD_LOGIC_VECTOR(10 downto 0);
           scan_line_y: out STD_LOGIC_VECTOR(10 downto 0)
		  );
end component;

component debouncer is
  generic(tenTimes: natural := 10);
  Port (
    asynch_in: in STD_LOGIC;
    clk: in std_logic;
    synch_debounced: out std_logic
  );
end component;

component up_down_counter is
	Generic ( WIDTH: integer:= 6);
	Port (
		up: in STD_LOGIC;
		down: in STD_LOGIC;
        clk: in std_logic;
		reset: in std_logic;
		enable: in std_logic;
        val: out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end component;

-- ADDED
component clock_divider is
Port (  clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        enable: in STD_LOGIC;
        kHz: out STD_LOGIC;
        seconds_port: out STD_LOGIC_VECTOR(4-1 downto 0);     -- unused
        ten_seconds_port: out STD_LOGIC_VECTOR(3-1 downto 0); -- unused
        minutes_port: out STD_LOGIC_VECTOR(4-1 downto 0);     -- unused
        ten_minutes_port: out STD_LOGIC_VECTOR(3-1 downto 0); -- unused
        twentyfive_MHz: out STD_LOGIC;
        hHz: out STD_LOGIC
	  );
end component;

component vga_stripes_dff is
    Port ( pixel_clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           next_pixel : in  STD_LOGIC;
		   mode: in STD_LOGIC;
           B : out  STD_LOGIC_VECTOR (3 downto 0);
           G : out  STD_LOGIC_VECTOR (3 downto 0);
           R : out  STD_LOGIC_VECTOR (3 downto 0)
         );
 end component;

 component bouncing_box is
 Port (  clk : in  STD_LOGIC;
         reset : in  STD_LOGIC;
         scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
         scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
         box_color: in STD_LOGIC_VECTOR(11 downto 0);
         box_width: in STD_LOGIC_VECTOR(8 downto 0);
         kHz: in STD_LOGIC;
         red: out STD_LOGIC_VECTOR(3 downto 0);
         blue: out STD_LOGIC_VECTOR(3 downto 0);
         green: out std_logic_vector(3 downto 0)
      );
end component;
-- END ADDED

-- Signals:
signal reset: std_logic;
signal vga_select: std_logic;

signal disp_blue: std_logic_vector(3 downto 0);
signal disp_red: std_logic_vector(3 downto 0);
signal disp_green: std_logic_vector(3 downto 0);

-- debounced signals
signal switches_deb: std_logic_vector(13 downto 0);
signal buttons_deb: std_logic_vector(1 downto 0); -- not debouncing reset

-- Stripe block signals:
signal show_stripe: std_logic;

-- Clock divider signals:
signal i_kHz, i_hHz, i_pixel_clk: std_logic;

-- Sync module signals:
signal vga_blank : std_logic;
signal scan_line_x, scan_line_y: STD_LOGIC_VECTOR(10 downto 0);

-- Box size signals:
signal inc_box, dec_box: std_logic;
signal box_size: std_logic_vector(8 downto 0);

-- Bouncing box signals:
signal box_color: std_logic_vector(11 downto 0);
signal box_red: std_logic_vector(3 downto 0);
signal box_green: std_logic_vector(3 downto 0);
signal box_blue: std_logic_vector(3 downto 0);

-- ADDED
signal stripe_red: std_logic_vector(3 downto 0);
signal stripe_green: std_logic_vector(3 downto 0);
signal stripe_blue: std_logic_vector(3 downto 0);

begin

DEB_Sw0: debouncer
    Generic map( tenTimes => 10)
    Port map(
          clk => clk,
          asynch_in => switches(0),
          synch_debounced => switches_deb(0)
    );

DEB_Sw1: debouncer
    Generic map( tenTimes => 10)
    Port map(
          clk => clk,
          asynch_in => switches(1),
          synch_debounced => switches_deb(1)
    );

DEB_Sw2: debouncer
    Generic map( tenTimes => 10)
    Port map(
          clk => clk,
          asynch_in => switches(2),
          synch_debounced => switches_deb(2)
    );

DEB_Sw3: debouncer
    Generic map( tenTimes => 10)
    Port map(
          clk => clk,
          asynch_in => switches(3),
          synch_debounced => switches_deb(3)
    );

DEB_Sw4: debouncer
    Generic map( tenTimes => 10)
    Port map(
         clk => clk,
          asynch_in => switches(4),
          synch_debounced => switches_deb(4)
    );

DEB_Sw5: debouncer
    Generic map( tenTimes => 10)
    Port map(
          clk => clk,
          asynch_in => switches(5),
          synch_debounced => switches_deb(5)
    );

DEB_Sw6: debouncer
    Generic map( tenTimes => 10)
    Port map(
          clk => clk,
          asynch_in => switches(6),
          synch_debounced => switches_deb(6)
    );

DEB_Sw7: debouncer
    Generic map( tenTimes => 10)
    Port map(
          clk => clk,
          asynch_in => switches(7),
          synch_debounced => switches_deb(7)
    );

DEB_Sw8: debouncer
    Generic map( tenTimes => 10)
    Port map(
          clk => clk,
          asynch_in => switches(8),
          synch_debounced => switches_deb(8)
    );

DEB_Sw9: debouncer
    Generic map( tenTimes => 10)
    Port map(
          clk => clk,
          asynch_in => switches(9),
          synch_debounced => switches_deb(9)
    );

DEB_Sw10: debouncer
    Generic map( tenTimes => 10)
    Port map(
         clk => clk,
          asynch_in => switches(10),
          synch_debounced => switches_deb(10)
    );

DEB_Sw11: debouncer
    Generic map( tenTimes => 10)
    Port map(
          clk => clk,
          asynch_in => switches(11),
          synch_debounced => switches_deb(11)
    );

DEB_Sw12: debouncer
    Generic map( tenTimes => 10)
    Port map(
          clk => clk,
          asynch_in => switches(12),
          synch_debounced => switches_deb(12)
    );

DEB_Sw13: debouncer
    Generic map( tenTimes => 10)
    Port map(
          clk => clk,
          asynch_in => switches(13),
          synch_debounced => switches_deb(13)
    );

DEB_But1: debouncer
    Generic map( tenTimes => 10)
    Port map(
          clk => clk,
          asynch_in => buttons(1),
          synch_debounced => buttons_deb(0)
    );

DEB_But2: debouncer
    Generic map( tenTimes => 10)
    Port map(
          clk => clk,
          asynch_in => buttons(2),
          synch_debounced => buttons_deb(1)
    );

VGA_SYNC: sync_signals_generator
    Port map( 	pixel_clk   => i_pixel_clk,
                reset       => reset,
                hor_sync    => hsync,
                ver_sync    => vsync,
                blank       => vga_blank,
                scan_line_x => scan_line_x,
                scan_line_y => scan_line_y
			  );

CHANGE_BOX_SIZE: up_down_counter
	Generic map( 	WIDTH => 9)
	Port map(
					up 	   => inc_box,
					down   => dec_box,
					clk	   => clk,
					reset  => reset,
					enable => i_hHz,
          val    => box_size
	);

-- ADDED
DIVIDER: clock_divider
    Port map (  clk              => clk,
                reset            => reset,
                kHz              => i_kHz,
                twentyfive_MHz   => i_pixel_clk,
                enable           => '1',
                seconds_port     => open,
                ten_seconds_port => open,
                minutes_port     => open,
                ten_minutes_port => open,
                hHz              => i_hHz
		  );

STRIPES_DFF: vga_stripes_dff
	Port map ( pixel_clk  => i_pixel_clk,
               reset      => reset,
               next_pixel => show_stripe,
               mode       => switches(0), -- can be a different switch
               B          => stripe_blue,
               G          => stripe_green,
               R          => stripe_red
             );

BOX: bouncing_box
    Port map ( clk         => clk,
               reset       => reset,
               scan_line_x => scan_line_x,
               scan_line_y => scan_line_y,
               box_color   => box_color,
               box_width   => box_size,
               kHz         => i_kHz,
               red         => box_red,
               blue        => box_blue,
               green       => box_green
           );
-- END ADDED

show_stripe <= not vga_blank;

-- BLANKING:
-- Follow this syntax to assign other colors when they are not being blanked
red <= "0000" when (vga_blank = '1') else disp_red;
-- ADDED:
blue  <= "0000" when (vga_blank = '1') else disp_blue;
green <= "0000" when (vga_blank = '1') else disp_green;

-- Connect input buttons and switches:
-- ADDED
-- These can be assigned to different switches/buttons
reset <= buttons(0);
box_color <= switches_deb(13 downto 2);
vga_select <= switches_deb(1);
inc_box <= buttons_deb(0);
dec_box <= buttons_deb(1);

-----------------------------------------------------------------------------
-- OUTPUT SELECTOR:
-- Select which component to display - stripes or bouncing box
selectOutput: process(box_red, box_blue, box_green, stripe_blue, stripe_red, stripe_green)
begin
	case (vga_select) is
		-- Select which input gets written to disp_red, disp_blue and disp_green
		-- ADDED
		when '0' => disp_red <= box_red; disp_blue <= box_blue; disp_green <= box_green;
		when '1' => disp_red <= stripe_red; disp_blue <= stripe_blue; disp_green <= stripe_green;
		when others => disp_red <= "0000"; disp_blue <= "0000"; disp_green <= "0000";
	end case;
end process selectOutput;
-----------------------------------------------------------------------------

end Behavioral;
