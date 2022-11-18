library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity teclado is

	port( 
		clk: in std_logic;
		columna: in std_logic_vector(3 downto 0);
		
		fila_Out: out std_logic_vector(3 downto 0); -- Enable 4 digit
		Siete_Seg_Out: out std_logic_vector(7 downto 0) -- 7 Segments and Dot LEDs
		); 

end teclado;

architecture Behavioral of teclado is

signal fila: std_logic_vector(3 downto 0) := "1110";
signal codigo: std_logic_vector(3 downto 0);
signal Siete_Seg: std_logic_vector(7 downto 0);
-- signal codigo0,codigo1,codigo2,codigo3: std_logic_vector(3 downto 0);

begin

process(clk,codigo,fila,columna)
begin

	if rising_edge(clk) then
		fila <= fila(2 downto 0) & fila(3);
	end if;
		
	-- if columna /= "1111" then
		case fila is

			when "1110" =>
				case columna is
					when "1110" => codigo <= X"1";
					when "1101" => codigo <= X"2";
					when "1011" => codigo <= X"3";
					when "0111" => codigo <= X"A";
					when others => codigo <= codigo;
				end case;
			
			when "1101" =>
				case columna is
					when "1110" => codigo <= X"4";
					when "1101" => codigo <= X"5";
					when "1011" => codigo <= X"6";
					when "0111" => codigo <= X"B";
					when others => codigo <= codigo;
				end case;
			
			when "1011" =>
				case columna is
					when "1110" => codigo <= X"7";
					when "1101" => codigo <= X"8";
					when "1011" => codigo <= X"9";
					when "0111" => codigo <= X"C";
					when others => codigo <= codigo;
				end case;
			
			when others =>
				case columna is
					when "1110" => codigo <= X"E";
					when "1101" => codigo <= X"0";
					when "1011" => codigo <= X"F";
					when "0111" => codigo <= X"D";
					when others => codigo <= codigo;
				end case;
		end case;
		
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
	-- end if;
			
			end process;

Fila_Out <= fila;
Siete_Seg_Out <= Siete_Seg;

end Behavioral;