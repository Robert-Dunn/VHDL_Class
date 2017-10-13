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
signal box2_loc_x, box2_loc_y: std_logic_vector(9 downto 0);
signal box3_loc_x, box3_loc_y: std_logic_vector(9 downto 0);
signal box_move_dir_x, box_move_dir_y: std_logic;
signal initals_xmax, initals_ymax: std_logic_vector(9 downto 0);

signal S1 : std_logic_vector (9 downto 0);
signal S2 : std_logic_vector (9 downto 0);
signal S3 : std_logic_vector (9 downto 0);
signal S4 : std_logic_vector (9 downto 0);
signal S5 : std_logic_vector (9 downto 0);
signal S6 : std_logic_vector (9 downto 0);
signal S7 : std_logic_vector (9 downto 0);
signal S8 : std_logic_vector (9 downto 0);

 
constant C1 : std_logic_vector (9 downto 0):= "0000000001";
constant C2 : std_logic_vector (9 downto 0):= "0000000010";
constant C3 : std_logic_vector (9 downto 0):= "0000000011";
constant C4 : std_logic_vector (9 downto 0):= "0000000100";
constant C5 : std_logic_vector (9 downto 0):= "0000000101";
constant C6 : std_logic_vector (9 downto 0):= "0000000110";
constant C7 : std_logic_vector (9 downto 0):= "0000000111";
constant C8 : std_logic_vector (9 downto 0):= "0000001000";
constant gap: std_logic_vector(9 downto 0) :="0000000010";


signal M1 : std_logic_vector (18 downto 0);
signal M2 : std_logic_vector (18 downto 0);
signal M3 : std_logic_vector (18 downto 0);
signal M4 : std_logic_vector (18 downto 0);
signal M5 : std_logic_vector (18 downto 0);
signal M6 : std_logic_vector (18 downto 0);
signal M7 : std_logic_vector (18 downto 0);
signal M8 : std_logic_vector (18 downto 0);



begin

M1 <= box_width * C1;
S1 <= M1(9 downto 0);

M2 <= box_width * C2;
S2 <= M2 (9 downto 0);

M3 <= box_width * C3;
S3 <= M3 (9 downto 0);

M4 <= box_width * C4;
S4 <= M4 (9 downto 0);

M5 <= box_width * C5;
S5 <= M5 (9 downto 0);

M6 <= box_width * C6;
S6 <= M6 (9 downto 0);

M7 <= box_width * C7;
S7 <= M7 (9 downto 0);

M8 <= box_width * C8;
S8 <= M8 (9 downto 0);




  box2_loc_x <= box_loc_x + S4 + gap;
  box2_loc_y <= box_loc_y;
  box3_loc_x <= box2_loc_x + S4 + gap;
  box3_loc_y <= box_loc_y;
  initals_xmax <= "1010000000"- ((box3_loc_x + S4) - box_loc_x)  
  initals_ymax <= "0111100000" - ((box3_loc_y + S4) - box_loc_y)
  
MoveLetters: process(clk, reset)
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
                    if (box_loc_x < initals_xmax) then -- Has not hit right wall
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
                    if (box_loc_y < initals_ymax) then -- Has not hit bottom wall
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
end process MoveLetters;
  
  
  
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




SwitchType: process (switch_type,box_width,scan_line_x,scan_line_y, box_loc_x,box_loc_y,box_color,S1,S2,S3,S4,S5,S6,S7,S8)
begin

if (switch_type = '0') then
     if   ((scan_line_x >= box_loc_x) and
								                (scan_line_y >= box_loc_y) and
			      (scan_line_x < box_loc_x+box_width) and
            (scan_line_y < box_loc_y+box_width)) then
       pixel_color <= box_color;
	   else
      pixel_color <= "111111111111"; -- represents WHITE
     end if;
else
       if 	(	 ((((scan_line_x >= box_loc_x) and
 				 (scan_line_x <= box_loc_x + S4) and
 				 (scan_line_y >=box_loc_y) and
				 (scan_line_y <= box_loc_y+ S8))

                 and

                 (not(((scan_line_x >= box_loc_x+S1  ) and
                 (scan_line_x <= box_loc_x + S4  ) and
                 (scan_line_y >=box_loc_y +S1  ) and
                 (scan_line_y <= box_loc_y+ S4  ))))

                 and

                 (not(((scan_line_x >= box_loc_x+S1  ) and
                 (scan_line_x <= box_loc_x + S2  ) and
                 (scan_line_y >=box_loc_y +S4  ) and
                 (scan_line_y <= box_loc_y+ S5 ))))

                 and

                 (not (((scan_line_x >= box_loc_x+S1  ) and
                 (scan_line_x <= box_loc_x + S3  ) and
                 (scan_line_y >=box_loc_y +S5  ) and
                 (scan_line_y <= box_loc_y+ S6  )))))) --Draws the G

                 or

                 ((((scan_line_x >= box2_loc_x) and
                 (scan_line_x <= box2_loc_x + S4) and
                 (scan_line_y >=box2_loc_y) and
                 (scan_line_y <= box2_loc_y+ S8))

                 and

                 (not(((scan_line_x >= box2_loc_x + S1 ) and
                 (scan_line_x <= box2_loc_x + S3 ) and
                 (scan_line_y >=box2_loc_y + S2) and
                 (scan_line_y <= box2_loc_y+ S6 ))))))  -- Draws the O

                  or

                 ((((scan_line_x >= box3_loc_x) and
                 (scan_line_x <= box3_loc_x + S4 ) and
                 (scan_line_y >=box3_loc_y) and
                 (scan_line_y <= box2_loc_y+ S8))

                  and

                  (not(((scan_line_x >= box3_loc_x + S1 ) and
                  (scan_line_x <= box3_loc_x + S2 ) and
                  (scan_line_y >=box3_loc_y + S1 ) and
                  (scan_line_y <= box2_loc_y+ S7 ))))

                  and

                  (not(((scan_line_x >= box3_loc_x + S3 ) and
                  (scan_line_x <= box3_loc_x + S4) and
                  (scan_line_y >=box3_loc_y) and
                  (scan_line_y <= box2_loc_y+ S1))))

                  and

                  (not(((scan_line_x >= box3_loc_x + S3) and
                  (scan_line_x <= box3_loc_x + S4) and
                  (scan_line_y >=box3_loc_y + S7) and
                  (scan_line_y <= box2_loc_y+ S8))))))) then -- Draws the D
               pixel_color <= box_color;
            else
               pixel_color <= "111111111111";
            end if;
end if;
end process SwitchType;

red   <= pixel_color(11 downto 8);
green <= pixel_color(7 downto 4);
blue  <= pixel_color(3 downto 0);

box_loc_x_max <= "1010000000" - box_width - 1;  
-- Describe the value for box_loc_y_max here:
-- Hint: In binary, 640 is 1010000000 and 480 is 0111100000
-- ADDED
box_loc_y_max <= "0111100000" - box_width - 1;

end Behavioral;
