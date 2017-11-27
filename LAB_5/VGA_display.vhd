library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


--Entitiy
--architecture
--calling the function issues, how can i call this over and over

entity print_num is
    port(
		scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
		scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
        unit: in std_logic_vector(1 downto 0); --state in binary
        output_1: in integer;
		output_2: in integer;
		output_3: in integer;
		output_4: in integer;
		box_color: in std_logic_vector(11 downto 0);
		red: out std_logic_vector(3 downto 0);
		blue: out STD_LOGIC_VECTOR(3 downto 0);
		green: out std_logic_vector(3 downto 0)

    );
	end print_num;		


architecture Behavioral of print_num is

signal redraw: std_logic_vector(5 downto 0):=(others=>'0');

-- For now, assuming that the locations are fixed
-- I am going to assume a base width of ten pixels, this should be changed as needed once we test the code
constant tens_loc_x: std_logic_vector(9 downto 0) := "0000001110"; -- 14 (since max is 640 - 4 increments of 10 pixels (assumed))
constant ones_loc_x: std_logic_vector(9 downto 0) := "0010001101"; -- 141 (used a 30 pixel space and again 40 pixel number)
constant tenths_loc_x: std_logic_vector(9 downto 0) := "0100001101";-- 269 (ten for the space and 40 for the number, after the decimal)
constant hundredths_loc_x: std_logic_vector (9 downto 0) :="0110001101"; --397

signal decimal_loc_x: std_logic_vector(9 downto 0); --Changes depending on the unit
constant letter_1_x: std_logic_vector(9 downto 0) := "1000000110"; -- 518 letters are five units wide plus the space is 1 unit
constant letter_2_x: std_logic_vector(9 downto 0) := "1001000101"; --581

constant line_y : std_logic_vector(9 downto 0) := "0010001100"; -- 140 --everything on the same line
constant letter_y : std_logic_vector(9 downto 0) := "0100100010"; --290
constant decimal_y : std_logic_vector(9 downto 0) := "0101000000"; --320

-- left as a signal in case we want to change the colour
signal pixel_color: std_logic_vector(11 downto 0); 
--constant box_color: std_logic_vector(11 downto 0) := "000000000000";  --WHAT COLOUR DO WE WANT or do we want to change the colours?


--I left these as signals in case we want to change the sizes - we should change to constants otherwise
signal S1 : std_logic_vector (9 downto 0) := "0000011001"; --25
signal S2 : std_logic_vector (9 downto 0) := "0000110010"; --50
signal S3 : std_logic_vector (9 downto 0) := "0001001011"; --75
signal S4 : std_logic_vector (9 downto 0) := "0001100100"; --100
signal S5 : std_logic_vector (9 downto 0) := "0001111101"; --125
signal S6 : std_logic_vector (9 downto 0) := "0010010110"; --150
signal S7 : std_logic_vector (9 downto 0) := "0010101111"; --175
signal S8 : std_logic_vector (9 downto 0) := "0011001000"; --200

signal L1 : std_logic_vector (9 downto 0) := "0000001010"; --10
signal L2 : std_logic_vector (9 downto 0) := "0000010100"; --20
signal L3 : std_logic_vector (9 downto 0) := "0000011110"; --30
signal L4 : std_logic_vector (9 downto 0) := "0000101000"; --40
signal L5 : std_logic_vector (9 downto 0) := "0000110010"; --50



begin

choose_unit: process(unit, output_1, output_2, output_3, output_4, scan_line_x,scan_line_y,S1,S2,S3,S4,S5,S6,S7,S8,decimal_loc_x)
begin
		--if (unit = "01") then		--mm
			-- decimal_loc_x <= "0101110110"; --374
			
			
			if(( (unit = "01") and ((scan_line_x >= "0101110110") and
			(scan_line_x <= "0101110110" + L2) and 
			(scan_line_y>=decimal_y) and
			(scan_line_y <= decimal_y + L2)))--) 
			--then  pixel_color <= box_color;
			
			 OR--m
			
			((((unit = "01")and (scan_line_x >= letter_1_x) and
            (scan_line_x <= letter_1_x + L5) and
            (scan_line_y >=letter_y) and
            (scan_line_y <= letter_y+ L5)
			
			and 
			
			(not((scan_line_x >= letter_1_x + L1) and
			(scan_line_x <= letter_1_x+L2) and 
			(scan_line_y >= letter_y+L2) and 
			(scan_line_y <= letter_y + L5)))))
			
			and 
			
			(not(((scan_line_x >= letter_1_x +L3) and
			(scan_line_x <= letter_1_x+L4) and 
			(scan_line_y >= letter_y+L2) and 
			(scan_line_y <= letter_y + L5)))))
			--then  pixel_color <= box_color;	
			
			OR		--m
			(((unit = "01")and(scan_line_x >= letter_2_x) and
            (scan_line_x <= letter_2_x + L5) and
            (scan_line_y >=letter_y) and
            (scan_line_y <= letter_y+ L5))
			
			and 
			
			(not((scan_line_x >= letter_2_x + L1) and
			(scan_line_x <= letter_2_x + L2) and 
			(scan_line_y >= letter_y + L2) and 
			(scan_line_y <= letter_y + L5)))
			
			and 
			
			(not(((scan_line_x >= letter_2_x +L3) and
			(scan_line_x <= letter_2_x + L4) and 
			(scan_line_y >= letter_y + L2) and 
			(scan_line_y <= letter_y + L5)))))
			--then  pixel_color <= box_color;	
			
			--else pixel_color <= "111111111111";
			--end if;
			
			
		--elsif (unit = "00") 	then --cm
			--decimal_loc_x <= "0011110101"; --245  		-
			
			
			OR ((unit = "00") and (scan_line_x >= "0011110101") and
                (scan_line_x <= "0011110101" + L2) and 
                (scan_line_y>=decimal_y) and
                (scan_line_y <= decimal_y + L2)) 
                --then  pixel_color <= box_color;
				
			OR  --c
			(((unit = "00") and (scan_line_x >= letter_1_x) and
            (scan_line_x <= letter_1_x + L5) and
            (scan_line_y >=letter_y) and
            (scan_line_y <= letter_y + L5))
			
			and 
			
			(not((scan_line_x >= letter_1_x +L2) and
			(scan_line_x <= letter_1_x + L5) and 
			(scan_line_y >= letter_y + L1) and 
			(scan_line_y <= letter_y + L4))))
			--then  pixel_color <= box_color;
				
			OR		--m
			(((unit = "00") and (scan_line_x >= letter_2_x) and
            (scan_line_x <= letter_2_x + L5) and
            (scan_line_y >=letter_y) and
            (scan_line_y <= letter_y+ L5))
            
            and 
            
            (not((scan_line_x >= letter_2_x + L1) and
            (scan_line_x <= letter_2_x + L2) and 
            (scan_line_y >= letter_y + L2) and 
            (scan_line_y <= letter_y + L5)))
            
            and 
            
            (not(((scan_line_x >= letter_2_x +L3) and
            (scan_line_x <= letter_2_x + L4) and 
            (scan_line_y >= letter_y + L2) and 
            (scan_line_y <= letter_y + L5)))))
            
            --then  pixel_color <= box_color;    
			
			--else pixel_color <= "111111111111";
			--end if;
			
			--write cm
			
		--elsif (unit = "10")		--meters
			--then decimal_loc_x <= "0001110110"; --118
			
			
			OR ((unit = "10")	and (scan_line_x >= "0001110110") and
                (scan_line_x <= "0001110110" + L2) and 
                (scan_line_y>=decimal_y) and
                (scan_line_y <= decimal_y + L2)) 
                --then  pixel_color <= box_color;
                
			OR--m
			(((unit = "10")	and(scan_line_x >= letter_1_x) and
            (scan_line_x <= letter_1_x + L5) and
            (scan_line_y >=letter_y) and
            (scan_line_y <= letter_y+ L5))
            
            and 
            
            (not((scan_line_x >= letter_1_x + L1) and
            (scan_line_x <= letter_1_x+L2) and 
            (scan_line_y >= letter_y) and 
            (scan_line_y <= letter_y + L2)))
            
            and 
            
            (not(((scan_line_x >= letter_1_x +L3) and
            (scan_line_x <= letter_1_x+L4) and 
            (scan_line_y >= letter_y) and 
            (scan_line_y <= letter_y + L2)))))
            --then  pixel_color <= box_color;    
            
			--else pixel_color <= "111111111111";			
			--end if;
			
			--write m
			
		--elsif(unit = "11") and		--inches
			--then decimal_loc_x <= "0011110101"; --245  
			
			
			OR ((unit = "11") and(scan_line_x >= "0011110101") and
                (scan_line_x <= "0011110101" + L2) and 
                (scan_line_y>=decimal_y) and
                (scan_line_y <= decimal_y + L2)) 
                --then  pixel_color <= box_color;	
			
			OR--i
			(((unit = "11") and(scan_line_x >= letter_1_x) and
            (scan_line_x <= letter_1_x + L5) and
            (scan_line_y >=letter_y) and
            (scan_line_y <= letter_y+ L5))
			
			and 
			
			(not((scan_line_x >= letter_1_x) and
			(scan_line_x <= letter_1_x+L2) and 
			(scan_line_y >= letter_y) and 
			(scan_line_y <= letter_y + L5)))
			
			and 
			
			(not((scan_line_x >= letter_1_x +L3) and
            (scan_line_x <= letter_1_x+L5) and 
            (scan_line_y >= letter_y) and 
            (scan_line_y <= letter_y + L5)))
            
            and
            
			(not(((scan_line_x >= letter_1_x +L2) and
			(scan_line_x <= letter_1_x+L3) and 
			(scan_line_y >= letter_y + L1) and 
			(scan_line_y <= letter_y + L2)))))
				--then  pixel_color <= box_color;	
				
			OR		--n
			(((unit = "11") and(scan_line_x >= letter_2_x) and
            (scan_line_x <= letter_2_x + L5) and
            (scan_line_y >=letter_y) and
            (scan_line_y <= letter_y + L5))
			
			and 
			
			(not(((scan_line_x >= letter_2_x + L1) and
			(scan_line_x <= letter_2_x + L4) and 
			(scan_line_y >= letter_y + L2) and 
			(scan_line_y <= letter_y + L5)))))
			--then  pixel_color <= box_color;		
			
		--else pixel_color <= "111111111111";
			--end if;
	--end if;  --END OF UNITS		
--Output 1
	--NO 0 IN TENS PLACE
		     OR ((output_1 = 0) and
            ((scan_line_x >= tens_loc_x)and
            (scan_line_x <=tens_loc_x+S4) and 
            (scan_line_y>=line_y)and
            (scan_line_y <=line_y+S8)) 
        
             and

            (not(((scan_line_x >= tens_loc_x + S1 ) and
            (scan_line_x <= tens_loc_x + S3 ) and
            (scan_line_y >=line_y + S1) and
            (scan_line_y <= line_y+ S7 )))))
        		
	        OR ((output_1 = 1) and
			((scan_line_x >= tens_loc_x+S2)and
			(scan_line_x <=tens_loc_x+S3) and 
			(scan_line_y>=line_y)and
			(scan_line_y <=line_y+S8)))
			--then  pixel_color <= box_color;	
		
            OR  (((output_1 = 2) and
			(((scan_line_x >= tens_loc_x) and
            (scan_line_x <= tens_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))))
			
			and 
			
			(not((scan_line_x >= tens_loc_x) and
			(scan_line_x <= tens_loc_x+S3) and 
			(scan_line_y >= line_y +S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= tens_loc_x + S1) and
			(scan_line_x <= tens_loc_x+ S4) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7)))))
			--then  pixel_color <= box_color;	
		
	     OR (((output_1 = 3) and
			(((scan_line_x >= tens_loc_x) and
            (scan_line_x <= tens_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))))
			
			and 
			
			(not((scan_line_x >= tens_loc_x ) and
			(scan_line_x <= tens_loc_x+S3) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= tens_loc_x) and
			(scan_line_x <= tens_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7)))))
			--then  pixel_color <= box_color;
			
	    OR  (((output_1 = 4) and
			(((scan_line_x >= tens_loc_x) and
            (scan_line_x <= tens_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))))
			
			and
			
			(not((scan_line_x >= tens_loc_x + S1) and
			(scan_line_x <= tens_loc_x+S3) and 
			(scan_line_y >= line_y) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= tens_loc_x) and
			(scan_line_x <= tens_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S8)))))
			--then  pixel_color <= box_color;

	-- Draws a five
	     OR (((output_1 = 5) and 
			(((scan_line_x >= tens_loc_x) and
            (scan_line_x <= tens_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))))
			
			and
			
			(not((scan_line_x >= tens_loc_x+S1) and
			(scan_line_x <= tens_loc_x + S4) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= tens_loc_x ) and
			(scan_line_x <= tens_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7)))))	
			--then  pixel_color <= box_color;			
			
	--Draws a six
	OR      ((((output_1 =6) and 
			(((scan_line_x >= tens_loc_x) and
            (scan_line_x <= tens_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))))
			
			and
			
			(not((scan_line_x >= tens_loc_x + S1) and
			(scan_line_x <= tens_loc_x + S4) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= tens_loc_x+ S1) and
			(scan_line_x <= tens_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7))))))	
			--then  pixel_color <= box_color;
				
	-- Draws a seven
	OR      ((((output_1 = 7) and
			(((scan_line_x >= tens_loc_x) and
            (scan_line_x <= tens_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8)))))
			
			and
			
			(not((scan_line_x >= tens_loc_x) and
			(scan_line_x <= tens_loc_x + S3) and 
			(scan_line_y >= line_y+S1) and 
			(scan_line_y <= line_y + S8))))
			--then  pixel_color <= box_color;
			
	-- Draws an eight
	OR      ((output_1 = 8) and 
			(((scan_line_x >= tens_loc_x) and
            (scan_line_x <= tens_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and
			
			(not((scan_line_x >= tens_loc_x + S1) and
			(scan_line_x <= tens_loc_x + S3) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= tens_loc_x + S1) and
			(scan_line_x <= tens_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7))))))	
			--then  pixel_color <= box_color;
			
	-- Draws a nine
	OR      ((output_1 = 9) and 
			(((scan_line_x >= tens_loc_x) and
            (scan_line_x <= tens_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and
			
			(not((scan_line_x >= tens_loc_x + S1) and
			(scan_line_x <= tens_loc_x + S3) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= tens_loc_x ) and
			(scan_line_x <= tens_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S8))))))		
			
			--then  pixel_color <= box_color;	
			
			
		--else pixel_color <= "111111111111";
		--end if;

		OR ((output_2 = 0) and
			((scan_line_x >= ones_loc_x)and
			(scan_line_x <=ones_loc_x+S4) and 
			(scan_line_y>=line_y)and
			(scan_line_y <=line_y+S8)) 
			
			and

            (not(((scan_line_x >= ones_loc_x + S1 ) and
            (scan_line_x <= ones_loc_x + S3 ) and
            (scan_line_y >=line_y + S1) and
            (scan_line_y <= line_y+ S7 )))))
			
			--then pixel_color <= box_color;
		
		OR  ((output_2 = 1) and
			((scan_line_x >= ones_loc_x+S2)and
			(scan_line_x <=ones_loc_x+S3) and 
			(scan_line_y>=line_y)and
			(scan_line_y <=line_y+S8)))
			--then  pixel_color <= box_color;	
		
		
		OR	((output_2 = 2) and
			((scan_line_x >= ones_loc_x) and
            (scan_line_x <= ones_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and 
			
			(not((scan_line_x >= ones_loc_x ) and
			(scan_line_x <= ones_loc_x+S3) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= ones_loc_x+ S1) and
			(scan_line_x <= ones_loc_x+S4) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7)))))
			--then  pixel_color <= box_color;	
		
		OR((output_2 = 3) and
			((scan_line_x >= ones_loc_x) and
            (scan_line_x <= ones_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and 
			
			(not((scan_line_x >= ones_loc_x ) and
			(scan_line_x <= ones_loc_x+S3) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= ones_loc_x) and
			(scan_line_x <= ones_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7)))))
			--then  pixel_color <= box_color;	
			
			--Draws a 4
			
			OR((output_2 = 4) and
			 		(((scan_line_x >= ones_loc_x) and
            (scan_line_x <= ones_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and
			
			(not((scan_line_x >= ones_loc_x + S1) and
			(scan_line_x <= ones_loc_x+S3) and 
			(scan_line_y >= line_y) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= ones_loc_x) and
			(scan_line_x <= ones_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S8))))))		
		--then  pixel_color <= box_color;	
	-- Draws a five
		OR((output_2 = 5) and
			(((scan_line_x >= ones_loc_x) and
            (scan_line_x <= ones_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and
			
			(not((scan_line_x >= ones_loc_x +S1) and
			(scan_line_x <= ones_loc_x + S4) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= ones_loc_x) and
			(scan_line_x <= ones_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7))))))		
			--then  pixel_color <= box_color;	
	--Draws a six
		OR  ((output_2 = 6) and
			(((scan_line_x >= ones_loc_x) and
            (scan_line_x <= ones_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and
			
			(not((scan_line_x >= ones_loc_x + S1) and
			(scan_line_x <= ones_loc_x + S4) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= ones_loc_x +S1) and
			(scan_line_x <= ones_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7))))))	
			--then  pixel_color <= box_color;	
	-- Draws a seven
		OR  ((output_2 = 7) and
			(((scan_line_x >= ones_loc_x) and
            (scan_line_x <= ones_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and
			
			(not((scan_line_x >= ones_loc_x) and
			(scan_line_x <= ones_loc_x + S3) and 
			(scan_line_y >= line_y+ S1) and 
			(scan_line_y <= line_y + S8)))))
		--then  pixel_color <= box_color;		
	-- Draws an eight
		OR  ((output_2 = 8) and
			(((scan_line_x >= ones_loc_x) and
            (scan_line_x <= ones_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and
			
			(not((scan_line_x >= ones_loc_x + S1) and
			(scan_line_x <= ones_loc_x + S3) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= ones_loc_x + S1) and
			(scan_line_x <= ones_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7))))))	
		--then  pixel_color <= box_color;		
	-- Draws a nine
		OR  (((output_2 = 9) and
			(((scan_line_x >= ones_loc_x) and
            (scan_line_x <= ones_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))))
			
			and
			
			(not((scan_line_x >= ones_loc_x + S1) and
			(scan_line_x <= ones_loc_x + S3) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= ones_loc_x) and
			(scan_line_x <= ones_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S8)))))
			--then  pixel_color <= box_color;	
						
			
		--else pixel_color <= "111111111111";
		--end if;

		OR  (((output_3 = 0) and
			(scan_line_x >= tenths_loc_x)and
			(scan_line_x <=tenths_loc_x+S4) and 
			(scan_line_y>=line_y)and
			(scan_line_y <=line_y+S8)) 
			
			and

            (not(((scan_line_x >= tenths_loc_x + S1 ) and
            (scan_line_x <= tenths_loc_x + S3 ) and
            (scan_line_y >=line_y + S1) and
            (scan_line_y <= line_y+ S7 )))))
			
			--then pixel_color <= box_color;
		
		OR  ((output_3 = 1) and
			((scan_line_x >= tenths_loc_x+S2)and
			(scan_line_x <=tenths_loc_x+S3) and 
			(scan_line_y>=line_y)and
			(scan_line_y <=line_y+S8)))
		--then  pixel_color <= box_color;	
		
		OR	((output_3 = 2) and
			((scan_line_x >= tenths_loc_x) and
            (scan_line_x <= tenths_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and 
			
			(not((scan_line_x >= tenths_loc_x ) and
			(scan_line_x <= tenths_loc_x+S3) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= tenths_loc_x + S1) and
			(scan_line_x <= tenths_loc_x+S4) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7)))))
			--then  pixel_color <= box_color;	
		
		OR((output_3 = 3) and
-- Draws a three

			((scan_line_x >= tenths_loc_x) and
            (scan_line_x <= tenths_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and 
			
			(not((scan_line_x >= tenths_loc_x ) and
			(scan_line_x <= tenths_loc_x+S3) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= tenths_loc_x ) and
			(scan_line_x <= tenths_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7)))))
			-- pixel_color <= box_color;

			
			--Draws the 4
			OR((output_3 = 4) and
			
			((scan_line_x >= tenths_loc_x) and
            (scan_line_x <= tenths_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
            
            and
            
			(not(scan_line_x >= tenths_loc_x + S1) and
			(scan_line_x <= tenths_loc_x+S3) and 
			(scan_line_y >= line_y) and 
			(scan_line_y <= line_y + S3))
			
			and 
			
			(not(scan_line_x >= tenths_loc_x ) and
			(scan_line_x <= tenths_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S8)))		
		--then  pixel_color <= box_color;	
	-- Draws a five
		OR ((output_3 = 5) and
			(((scan_line_x >= tenths_loc_x) and
            (scan_line_x <= tenths_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and
			
			(not((scan_line_x >= tenths_loc_x +S1) and
			(scan_line_x <= tenths_loc_x + S4) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= tenths_loc_x ) and
			(scan_line_x <= tenths_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7))))))		
			--then  pixel_color <= box_color;	
	--Draws a six
		OR((output_3 = 6) and
			(((scan_line_x >= tenths_loc_x) and
            (scan_line_x <= tenths_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and
			
			(not((scan_line_x >= tenths_loc_x + S1) and
			(scan_line_x <= tenths_loc_x + S4) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= tenths_loc_x+ S1) and
			(scan_line_x <= tenths_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7))))))	
			--then  pixel_color <= box_color;	
	-- Draws a seven
		OR((output_3 = 7) and
			(((scan_line_x >= tenths_loc_x) and
            (scan_line_x <= tenths_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and
			
			(not((scan_line_x >= tenths_loc_x) and
			(scan_line_x <= tenths_loc_x + S3) and 
			(scan_line_y >= line_y+ S1) and 
			(scan_line_y <= line_y + S8)))))
			--then  pixel_color <= box_color;	
			
	-- Draws an eight
		OR((output_3 = 8) and
			(((scan_line_x >= tenths_loc_x) and
            (scan_line_x <= tenths_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and
			
			(not((scan_line_x >= tenths_loc_x + S1) and
			(scan_line_x <= tenths_loc_x + S3) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= tenths_loc_x + S1) and
			(scan_line_x <= tenths_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7))))))	
			--then  pixel_color <= box_color;	
			
	-- Draws a nine
		OR((output_3 = 9) and
			(((scan_line_x >= tenths_loc_x) and
            (scan_line_x <= tenths_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and
			
			(not((scan_line_x >= tenths_loc_x + S1) and
			(scan_line_x <= tenths_loc_x + S3) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= tenths_loc_x) and
			(scan_line_x <= tenths_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S8))))))			 
			--then  pixel_color <= box_color;	
						

			
		--else pixel_color <= "111111111111";
		--end if;

	OR     ((output_4 = 0) and
			((scan_line_x >= hundredths_loc_x)and
			(scan_line_x <=hundredths_loc_x+S4) and 
			(scan_line_y>=line_y)and
			(scan_line_y <=line_y+S8)) 
			
			and

            (not(((scan_line_x >= hundredths_loc_x + S1 ) and
            (scan_line_x <= hundredths_loc_x + S3 ) and
            (scan_line_y >=line_y + S1) and
            (scan_line_y <= line_y+ S7 )))))
			
			--then pixel_color <= box_color;
		
	OR      ((output_4 = 1) and
			((scan_line_x >= hundredths_loc_x+S2)and
			(scan_line_x <=hundredths_loc_x+S3) and 
			(scan_line_y>=line_y)and
			(scan_line_y <=line_y+S8)))
			--then  pixel_color <= box_color;	
		
		
	OR   	((output_4 = 2) and
			((scan_line_x >= hundredths_loc_x) and
            (scan_line_x <= hundredths_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and 
			
			(not((scan_line_x >= hundredths_loc_x) and
			(scan_line_x <= hundredths_loc_x+S3) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= hundredths_loc_x +S1) and
			(scan_line_x <= hundredths_loc_x+S4) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7)))))
			--then  pixel_color <= box_color;	
		
	OR     ((output_4 = 3) and
-- Draws a three

			((scan_line_x >= hundredths_loc_x) and
            (scan_line_x <= hundredths_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and 
			
			(not((scan_line_x >= hundredths_loc_x ) and
			(scan_line_x <= hundredths_loc_x+S3) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= hundredths_loc_x) and
			(scan_line_x <= hundredths_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7)))))
			--then  pixel_color <= box_color;	
--Draws a 4		
	OR      ((output_4 = 4) and
		    (((scan_line_x >= hundredths_loc_x) and
            (scan_line_x <= hundredths_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and
			
			(not((scan_line_x >= hundredths_loc_x + S1) and
			(scan_line_x <= hundredths_loc_x+S3) and 
			(scan_line_y >= line_y) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= hundredths_loc_x) and
			(scan_line_x <= hundredths_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S8))))))		
			--then pixel_color <= box_color;
	-- Draws a five
	OR      ((output_4 = 5) and
			(((scan_line_x >= hundredths_loc_x) and
            (scan_line_x <= hundredths_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and
			
			(not((scan_line_x >= hundredths_loc_x +S1) and
			(scan_line_x <= hundredths_loc_x + S4) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= hundredths_loc_x) and
			(scan_line_x <= hundredths_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7))))))		
			--then pixel_color <= box_color;
	--Draws a six
	OR      ((output_4 = 6) and
			(((scan_line_x >= hundredths_loc_x) and
            (scan_line_x <= hundredths_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and
			
			(not((scan_line_x >= hundredths_loc_x + S1) and
			(scan_line_x <= hundredths_loc_x + S4) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= hundredths_loc_x + S1) and
			(scan_line_x <= hundredths_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7))))))	
			--then pixel_color <= box_color;	
				
	-- Draws a seven
	  OR    ((output_4 = 7) and
			(((scan_line_x >= hundredths_loc_x) and
            (scan_line_x <= hundredths_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and
			
			(not((scan_line_x >= hundredths_loc_x) and
			(scan_line_x <= hundredths_loc_x + S3) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S8)))))
			--then pixel_color <= box_color;
	-- Draws an eight
	OR      ((output_4 = 8) and
			(((scan_line_x >= hundredths_loc_x) and
            (scan_line_x <= hundredths_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and
			
			(not((scan_line_x >= hundredths_loc_x + S1) and
			(scan_line_x <= hundredths_loc_x + S3) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= hundredths_loc_x + S1) and
			(scan_line_x <= hundredths_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S7))))))	
			--then pixel_color <= box_color;
	-- Draws a nine
	OR      ((output_4 = 9) and
			(((scan_line_x >= hundredths_loc_x) and
            (scan_line_x <= hundredths_loc_x + S4) and
            (scan_line_y >=line_y) and
            (scan_line_y <= line_y+ S8))
			
			and
			
			(not((scan_line_x >= hundredths_loc_x + S1) and
			(scan_line_x <= hundredths_loc_x + S3) and 
			(scan_line_y >= line_y + S1) and 
			(scan_line_y <= line_y + S3)))
			
			and 
			
			(not(((scan_line_x >= hundredths_loc_x ) and
			(scan_line_x <= hundredths_loc_x+S3) and 
			(scan_line_y >= line_y + S4) and 
			(scan_line_y <= line_y + S8)))))))
	then pixel_color <= box_color;
			
	else pixel_color <= "111111111111";
	
end if;
end process;			

red   <= pixel_color(11 downto 8);
green <= pixel_color(7 downto 4);
blue  <= pixel_color(3 downto 0);

end Behavioral;