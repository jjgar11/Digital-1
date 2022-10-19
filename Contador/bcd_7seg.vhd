library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity bcd_7seg is

	port( 
		clk: in std_logic;
		code0,code1: in std_logic_vector(3 downto 0); -- Slide Switch
		
		digit: out std_logic_vector(1 downto 0); -- Enable 4 digit
		Siete_Seg: out std_logic_vector(7 downto 0) -- 7 Segments and Dot LEDs
		); 

end bcd_7seg;

architecture Behavioral of bcd_7seg is

signal digitin: std_logic_vector(1 downto 0) := "01";
signal ind: integer range 0 to 1 := 0;
signal BCDin: std_logic_vector(3 downto 0);

begin

process(clk)
begin

	if rising_edge(clk) then
		digitin <= not digitin;
		if ind < 1 then
				BCDin <= code0;
				ind <= 1;
			elsif ind > 0 then
				BCDin <= code1;
				ind <= 0;
			end if;
	end if;

	digit <= digitin;
	
end process;

process(BCDin) 
begin

case BCDin is

when "0000" =>
Siete_Seg <= "00000011"; --0

when "0001" =>
Siete_Seg <= "10011111"; --1

when "0010" =>
Siete_Seg <= "00100101"; --2

when "0011" =>
Siete_Seg <= "00001101"; --3

when "0100" =>
Siete_Seg <= "10011001"; --4

when "0101" =>
Siete_Seg <= "01001001"; --5

when "0110" =>
Siete_Seg <= "01000001"; --6

when "0111" =>
Siete_Seg <= "00011111"; --7

when "1000" =>
Siete_Seg <= "00000001"; --8

when "1001" =>
Siete_Seg <= "00001001"; --9

when others => Siete_Seg <= "11111111"; --null

end case;

end process;

end Behavioral;