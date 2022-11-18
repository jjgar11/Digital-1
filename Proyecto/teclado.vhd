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

					when "1110" =>
					codigo <= "0001";
					
					when "1101" =>
					codigo <= "0010";
					
					when "1011" =>
					codigo <= "0011";
					
					when "0111" =>
					codigo <= "1010";
			
					when others =>
					codigo <= codigo;

				end case;
			
			when "1101" =>

				case columna is

					when "1110" =>
					codigo <= "0100";
					
					when "1101" =>
					codigo <= "0101";
					
					when "1011" =>
					codigo <= "0110";
					
					when "0111" =>
					codigo <= "1011";
			
					when others =>
					codigo <= codigo;

				end case;
			
			when "1011" =>

				case columna is

					when "1110" =>
					codigo <= "0111";
					
					when "1101" =>
					codigo <= "1000";
					
					when "1011" =>
					codigo <= "1001";
					
					when "0111" =>
					codigo <= "1100";
					
					when others =>
					codigo <= codigo;
			
				end case;
			
			when others =>

				case columna is

					when "1110" =>
					codigo <= "1110";
					
					when "1101" =>
					codigo <= "0000";
					
					when "1011" =>
					codigo <= "1111";
					
					when "0111" =>
					codigo <= "1101";
				
					when others =>
					codigo <= codigo;
		
				end case;
		end case;
		
		case codigo is

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
			
			when "1010" =>
			Siete_Seg <= "00010001"; --A
			
			when "1011" =>
			Siete_Seg <= "11000001"; --B
			
			when "1100" =>
			Siete_Seg <= "01100011"; --C
			
			when "1101" =>
			Siete_Seg <= "10000101"; --D
			
			when "1110" =>
			Siete_Seg <= "11111110"; --*
			
			when others =>
			Siete_Seg <= "10010000"; --H
			
		end case;
	-- end if;
			
			end process;

Fila_Out <= fila;
Siete_Seg_Out <= Siete_Seg;

end Behavioral;