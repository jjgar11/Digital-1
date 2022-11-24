library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity teclado is

	port( 
		clk: in std_logic;
		clk_ar: in std_logic;
		columnas: in std_logic_vector(3 downto 0);
		
		filas: out std_logic_vector(3 downto 0);
		Siete_Seg_Out: out std_logic_vector(7 downto 0)
		); 

end teclado;

architecture Behavioral of teclado is

	component anti_rebote
		port(
			clk : in std_logic;
			Button : in std_logic;
			isOn : out std_logic
		);
	end component;

	signal fila: std_logic_vector(3 downto 0) := "0001";
	signal columna: std_logic_vector(3 downto 0) := "0000";
	signal codigo: std_logic_vector(3 downto 0);
	signal Siete_Seg: std_logic_vector(7 downto 0);
	signal nColumnas: std_logic_vector(3 downto 0) := "0000";

begin

nColumnas <= columnas;

process(clk)
	begin

	if rising_edge(clk) then
		fila <= fila(2 downto 0) & fila(3);
	end if;
	
end process;

ar0 : anti_rebote
port map(clk_ar,nColumnas(0),columna(0));
ar1 : anti_rebote
port map(clk_ar,nColumnas(1),columna(1));
ar2 : anti_rebote
port map(clk_ar,nColumnas(2),columna(2));
ar3 : anti_rebote
port map(clk_ar,nColumnas(3),columna(3));

process(columna)
	begin
	
	case fila is
		when "0001" =>
			case columna is
				when "0001" => codigo <= X"1";
				when "0010" => codigo <= X"2";
				when "0100" => codigo <= X"3";
				when "1000" => codigo <= X"A";
				when others => codigo <= codigo;
			end case;
		when "0010" =>
			case columna is
				when "0001" => codigo <= X"4";
				when "0010" => codigo <= X"5";
				when "0100" => codigo <= X"6";
				when "1000" => codigo <= X"B";
				when others => codigo <= codigo;
			end case;
		when "0100" =>
			case columna is
				when "0001" => codigo <= X"7";
				when "0010" => codigo <= X"8";
				when "0100" => codigo <= X"9";
				when "1000" => codigo <= X"C";
				when others => codigo <= codigo;
			end case;
		when others =>
			case columna is
				when "0001" => codigo <= X"E";
				when "0010" => codigo <= X"0";
				when "0100" => codigo <= X"F";
				when "1000" => codigo <= X"D";
				when others => codigo <= codigo;
			end case;
	end case;

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

filas <= fila;
Siete_Seg_Out <= Siete_Seg;

end Behavioral;