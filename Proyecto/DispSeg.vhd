library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity DispSeg is

	port( 
		clk: in std_logic;
		VecTiempos: in std_logic_vector(15 downto 0); -- Slide Switch
		btn : in std_logic_vector(3 downto 0);
		
		digit: out std_logic_vector(4 downto 0); -- Enable 4 digit
		Siete_Seg: out std_logic_vector(7 downto 0) -- 7 Segments and Dot LEDs
		); 

end DispSeg;

architecture Behavioral of DispSeg is

signal digitin: std_logic_vector(4 downto 0) := "11110";
signal codigo: std_logic_vector(3 downto 0);
--signal codigo0,codigo1,codigo2,codigo3: std_logic_vector(3 downto 0);

begin

process(clk)
begin

	if rising_edge(clk) then
		digitin <= digitin(3 downto 0) & digitin(4);
		
		case digitin is
			
			when "11110" =>
			codigo <= VecTiempos(15  downto 12);
			
			when "11101" =>
			codigo <= VecTiempos(11  downto 8);
			
			when "11011" =>
			codigo <= VecTiempos(7  downto 4);
			
			when "10111" =>
			codigo <= VecTiempos(3  downto 0);
			
			when "01111" =>
			codigo <= btn;
			
			when others => codigo <= "1111"; --null
		
		end case;
		
	end if;
	
	digit <= digitin;
	
end process;

process(codigo)
	begin
	
	case codigo is
		when X"0" => Siete_Seg <= "00000011"; --0
		when X"1" => Siete_Seg <= "10011111"; --1
		when X"2" => Siete_Seg <= "00100101"; --2
		when X"3" => Siete_Seg <= "00001101"; --3
		when X"4" => Siete_Seg <= "10011001"; --4
		when X"5" => Siete_Seg <= "01001001"; --5
		when X"6" => Siete_Seg <= "01000001"; --6
		when X"7" => Siete_Seg <= "00011111"; --7
		when X"8" => Siete_Seg <= "00000001"; --8
		when X"9" => Siete_Seg <= "00001001"; --9
		when X"A" => Siete_Seg <= "00010001"; --A
		when X"B" => Siete_Seg <= "11000001"; --B
		when X"C" => Siete_Seg <= "01100011"; --C
		when X"D" => Siete_Seg <= "10000101"; --D
		when X"E" => Siete_Seg <= "11111110"; --*
		when others => Siete_Seg <= "10010000"; --H
	end case;

end process;


end Behavioral;