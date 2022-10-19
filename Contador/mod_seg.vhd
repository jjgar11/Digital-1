library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity mod_seg is

	port(
		-- Input ports
		clk: in  std_logic;
		code0, code1: in std_logic_vector(3 downto 0);
		
		-- Output ports
		dig: std_logic_vector(1 downto 0);
		SieteSegment: out std_logic_vector(7 downto 0)
	);
		
end mod_seg;


architecture Behavioral of mod_seg is

	signal ena_led: std_logic_vector(1 downto 0) := "01";
	signal ind: integer range 0 to 1 := 0;

	component bcd_7seg
		port( 
			BCDin: in std_logic_vector(3 downto 0); -- Slide Switch
			digitin: in std_logic_vector(1 downto 0);
		
			digit: out std_logic_vector(1 downto 0); -- Enable 4 digit
			Siete_Seg: out std_logic_vector(7 downto 0) -- 7 Segments and Dot LEDs
			);
	end component;	

	
begin

	process(clk) 
	begin
		
		if rising_edge(clk) then 
			
			ena_led <= not ena_led;
			
			if ind<1 then
				port map(code0,ena_led,dig,SieteSegment);
			elsif ind > 0 then
				port map(code1,ena_led,dig,SieteSegment);
			end if;
			
		end if;

	end process;
	
end Behavioral;