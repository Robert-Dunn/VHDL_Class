library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bouncing_box is
    Port ( 	clk : in  STD_LOGIC;
			reset : in  STD_LOGIC;
			scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
			scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
            box_color: in STD_LOGIC_VECTOR(11 downto 0);
            box_width: in STD_LOGIC_VECTOR(8 downto 0);
			kHz: in STD_LOGIC;
      switch_type: IN STD_LOGIC;
			red: out STD_LOGIC_VECTOR(3 downto 0);
			blue: out STD_LOGIC_VECTOR(3 downto 0);
			green: out std_logic_vector(3 downto 0)
		  );
end bouncing_box;

architecture Behavioral of bouncing_box is

signal redraw: std_logic_vector(5 downto 0):=(others=>'0');
constant box_loc_x_min: std_logic_vector(9 downto 0) := "0000000000";
constant box_loc_y_min: std_logic_vector(9 downto 0) := "0000000000";
signal box_loc_x_max: std_logic_vector(9 downto 0); -- Not constants because these dependant on box_width
signal box_loc_y_max: std_logic_vector(9 downto 0);
signal pixel_color: std_logic_vector(11 downto 0);
signal box_loc_x, box_loc_y: std_logic_vector(9 downto 0);
signal box_move_dir_x, box_move_dir_y: std_logic;


constant G_x111, G_y12 :std_logic_vector(9 downto 0) :="0000000000";
constant G_x39, G_y34 :std_logic_vector(9 downto 0) :="0000000001";
constant G_x5 :std_logic_vector(9 downto 0) :="0000000010";
constant G_x810 :std_logic_vector(9 downto 0) :="0000000011";
constant G_x24612, G_y56 :std_logic_vector(9 downto 0) :="0000000100";
constant  G_y78 :std_logic_vector(9 downto 0) :="0000000101";
constant  G_y910 :std_logic_vector(9 downto 0) :="0000000110";
constant G_y1112 :std_logic_vector(9 downto 0) :="0000001000";

constant O_x17, O_y12 :std_logic_vector(9 downto 0) :="0000000000";
constant O_x35 :std_logic_vector(9 downto 0) :="0000000001";
constant O_y34 :std_logic_vector(9 downto 0) :="0000000010";
constant O_x46 :std_logic_vector(9 downto 0) :="0000000011";
constant O_x28 :std_logic_vector(9 downto 0) :="0000000100";
constant O_y56 :std_logic_vector(9 downto 0) :="0000000110";
constant O_y78 :std_logic_vector(9 downto 0) :="0000001000";

constant D_x111, D_y12 :std_logic_vector(9 downto 0) :="0000000000";
constant D_x37, D_y3456 :std_logic_vector(9 downto 0) :="0000000001";
constant D_x48 :std_logic_vector(9 downto 0) :="0000000010";
constant D_x25912 :std_logic_vector(9 downto 0) :="0000000011";
constant D_x610 :std_logic_vector(9 downto 0) :="0000000100";
constant D_y78910 :std_logic_vector(9 downto 0) :="0000000111";
constant D_y1112 :std_logic_vector(9 downto 0) :="0000001000";



constant gap: std_logic_vector(9 downto 0) :="0000000010";

begin

MoveBox: process(clk, reset)
begin
    if (reset ='1') then
        box_loc_x <= "0111000101";
        box_loc_y <= "0001100010";
        box_move_dir_x <= '0';
        box_move_dir_y <= '0';
        redraw <= (others=>'0');
	elsif (rising_edge(clk)) then
        if (kHz = '1') then
            redraw <= redraw + 1;
            if (redraw = "10000") then 		-- Determines the box's speed
                redraw <= (others => '0');
                if box_move_dir_x <= '0' then   -- Box moving right
                    if (box_loc_x < box_loc_x_max) then -- Has not hit right wall
                        box_loc_x <= box_loc_x + 1;
                    else
                        box_move_dir_x <= '1';	-- Box is now moving left
                    end if;
                else
                    if (box_loc_x > box_loc_x_min) then
                        box_loc_x <= box_loc_x - 1; -- Has not hit left wall
                    else
                        box_move_dir_x <= '0';	-- Box is now moving right
                    end if;
                end if;

                -- Complete the Y-axis motion description here
                -- It is very similar to X-axis motion
                -- ADDED
                if box_move_dir_y <= '0' then   -- Box moving down
                    if (box_loc_y < box_loc_y_max) then -- Has not hit bottom wall
                        box_loc_y <= box_loc_y + 1;
                    else
                        box_move_dir_y <= '1';    -- Box is now moving up
                    end if;
                else
                    if (box_loc_y > box_loc_y_min) then
                        box_loc_y <= box_loc_y - 1; -- Has not hit top wall
                    else
                        box_move_dir_y <= '0';    -- Box is now moving down
                    end if;
                end if;
                -- End ADDED
            end if;
        end if;
	end if;
end process MoveBox;




SwitchType: process (clk)
begin

if (switch_type = '0')
pixel_color <= box_color when   ((scan_line_x >= box_loc_x) and
								                (scan_line_y >= box_loc_y) and
								                (scan_line_x < box_loc_x+box_width) and
								                (scan_line_y < box_loc_y+box_width))
					                else
				                "111111111111"; -- represents WHITE

else
 pixel_color <= box_color when  ((scan_line_x >= box_loc_x) and
 								                (scan_line_x <= box_loc_x + G_x24612 + box_width) and
 								                (scan_line_y >=box_loc_y) and
 								                (scan_line_y <= box_loc_y+ G_y1112 + box_width))

                              and

                             not(((scan_line_x >= box_loc_x+G_x39 + box_width) and
                              	 (scan_line_x <= box_loc_x + G_x24612 + box_width) and
                              	 (scan_line_y >=box_loc_y +G_y34 + box_width) and
                              	 (scan_line_y <= box_loc_y+ G_y56 + box_width)))

                             not (((scan_line_x >= box_loc_x+G_x39 + box_width) and
                               	 (scan_line_x <= box_loc_x + G_x57 + box_width) and
                               	 (scan_line_y >=box_loc_y +G_y56 + box_width) and
                               	 (scan_line_y <= box_loc_y+ G_y78 + box_width)))

                             not (((scan_line_x >= box_loc_x+G_x39 + box_width) and
                                 (scan_line_x <= box_loc_x + G_x810 + box_width) and
                              	 (scan_line_y >=box_loc_y +G_y78 + box_width) and
                               	 (scan_line_y <= box_loc_y+ G_y910 + box_width))) --Draws the G

                            or

                            ((scan_line_x >= box2_loc_x) and
                            (scan_line_x <= box2_loc_x + O_x28 + box_width) and
                            (scan_line_y >=box2_loc_y) and
                            (scan_line_y <= box2_loc_y+ O_y78 + box_width))

                            and

                            not(((scan_line_x >= box2_loc_x + O_x35 + box_width) and
                              (scan_line_x <= box2_loc_x + O_x46 + box_width) and
                              (scan_line_y >=box2_loc_y + O_y34 + box_width) and
                              (scan_line_y <= box2_loc_y+ O_y56 + box_width)) )  -- Draws the O


                            or
                              ((scan_line_x >= box3_loc_x) and
                              (scan_line_x <= box3_loc_x + D_x610 + box_width) and
                              (scan_line_y >=box3_loc_y) and
                              (scan_line_y <= box2_loc_y+ D_y1112 + box_width))

                            not(((scan_line_x >= box3_loc_x + D_x37 + box_width) and
                               (scan_line_x <= box3_loc_x + D_x48 + box_width) and
                               (scan_line_y >=box3_loc_y + D_y3456 + box_width) and
                               (scan_line_y <= box2_loc_y+ D_y78910 + box_width)))

                            not(((scan_line_x >= box3_loc_x + D_x25912 + box_width) and
                               (scan_line_x <= box3_loc_x + D_x610 + box_width) and
                               (scan_line_y >=box3_loc_y + D_y12 + box_width) and
                               (scan_line_y <= box2_loc_y+ D_y3456 + box_width)))

                            not(((scan_line_x >= box3_loc_x + D_x25912 + box_width) and
                               (scan_line_x <= box3_loc_x + D_x610 + box_width) and
                               (scan_line_y >=box3_loc_y + D_y78910 + box_width) and
                               (scan_line_y <= box2_loc_y+ D_y1112 + box_width))) -- Draws the D
                             else
                               "111111111111";
end if;
end process SwitchType;
box2_loc_x <= box_loc_x + G_x24612 + gap;
box2_loc_y <= box_loc_y;
box3_loc_x <= box2_loc_x + O_x28 + gap;
box3_loc_y <= box_loc_y;

red   <= pixel_color(11 downto 8);
green <= pixel_color(7 downto 4);
blue  <= pixel_color(3 downto 0);

box_loc_x_max <= "1010000000" - box_width - 1;
-- Describe the value for box_loc_y_max here:
-- Hint: In binary, 640 is 1010000000 and 480 is 0111100000
-- ADDED
box_loc_y_max <= "0111100000" - box_width - 1;

end Behavioral;
