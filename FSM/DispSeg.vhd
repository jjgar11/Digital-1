library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity DispSeg is

	port( 
		clk: in std_logic;
		code0,code1,code2,code3: in std_logic_vector(2 downto 0); -- Slide Switch
		
		digit: out std_logic_vector(3 downto 0); -- Enable 4 digit
		Siete_Seg: out std_logic_vector(7 downto 0) -- 7 Segments and Dot LEDs
		); 

end DispSeg;

architecture Behavioral of DispSeg is

signal digitin: std_logic_vector(3 downto 0) := "1110";
signal BCDin: std_logic_vector(3 downto 0);
signal codigo0,codigo1,codigo2,codigo3: std_logic_vector(3 downto 0);

begin

codigo0 <= '0' & code0;
codigo1 <= '0' & code1;
codigo2 <= '0' & code2;
codigo3 <= '0' & code3;

process(clk)
begin

	if rising_edge(clk) then
		digitin <= digitin(2 downto 0) & '1';
		
		case digitin is
			
			when "1110" =>
			BCDin <= codigo3;
			
			when "1101" =>
			BCDin <= codigo2;
			
			when "1011" =>
			BCDin <= codigo1;
			
			when "0111" =>
			BCDin <= codigo0;
			
			when others => BCDin <= "1111"; --null
		
		end case;
		
	end if;
	
	if digitin = 15 then
		digitin <= "1110";
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

--when "1000" =>
--Siete_Seg <= "00000001"; --8

--when "1001" =>
--Siete_Seg <= "00001001"; --9

when others => Siete_Seg <= "11111111"; --null

end case;

end process;

end Behavioral;