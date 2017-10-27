architecture Behavioral of Simple is

signal Y_Curr, Y_Next : std_logic_vector(1 downto 0);
constant A: std_logic_vector (1 downto 0) := "00";
constant B: std_logic_vector (1 downto 0) := "01";
constant C: std_logic_vector (1 downto 0) := "10";
end Behavioral;
-- or, using three bits aka one hot method

architecture Behavioral of OneHot is

signal Y_Curr, Y_Next : std_logic_vector(1 downto 0);
constant A: std_logic_vector (1 downto 0) := "100";
constant B: std_logic_vector (1 downto 0) := "010";
constant C: std_logic_vector (1 downto 0) := "001";

end Behavioral;
