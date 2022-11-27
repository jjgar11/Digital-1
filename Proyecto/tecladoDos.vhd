library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tecladoDos is

port(
	clk 		  : in  std_logic; 						  --reloj fpga
	columnas   : in  std_logic_vector(3 downto 0); --puerto conectado a las columnas del teclado
	filas 	  : out std_logic_vector(3 downto 0); --puerto conectado a la filas del teclado
	boton_pres : out std_logic_vector(3 downto 0); --puerto que indica la tecla que se presion�
	ind		  : out std_logic;							  --bandera que indica cuando se presion� una tecla (s�lo dura un ciclo de reloj)
	siete_seg : out std_logic_vector(7 downto 0) := "11111111"
);

end tecladoDos;


architecture Behavioral of tecladoDos is

constant delay_1ms  : integer := (50e6/1000)-1;
constant delay_10ms : integer := (50e6/100)-1;

signal conta_1ms 	: integer range 0 to delay_1ms := 0;
signal bandera 	: std_logic := '0';
signal conta_10ms : integer range 0 to delay_10ms := 0;
signal bandera2 	: std_logic := '0';

signal reg_b1  : std_logic_vector(7 downto 0) := (others=>'0');
signal reg_b2  : std_logic_vector(7 downto 0) := (others=>'0');
signal reg_b3  : std_logic_vector(7 downto 0) := (others=>'0');
signal reg_b4  : std_logic_vector(7 downto 0) := (others=>'0');
signal reg_b5  : std_logic_vector(7 downto 0) := (others=>'0');
signal reg_b6  : std_logic_vector(7 downto 0) := (others=>'0');
signal reg_b7  : std_logic_vector(7 downto 0) := (others=>'0');
signal reg_b8  : std_logic_vector(7 downto 0) := (others=>'0');
signal reg_b9  : std_logic_vector(7 downto 0) := (others=>'0');
signal reg_ba  : std_logic_vector(7 downto 0) := (others=>'0');
signal reg_bb  : std_logic_vector(7 downto 0) := (others=>'0');
signal reg_bc  : std_logic_vector(7 downto 0) := (others=>'0');
signal reg_bd  : std_logic_vector(7 downto 0) := (others=>'0');
signal reg_b0  : std_logic_vector(7 downto 0) := (others=>'0');
signal reg_bas : std_logic_vector(7 downto 0) := (others=>'0');
signal reg_bga : std_logic_vector(7 downto 0) := (others=>'0');

signal fila_reg_s : std_logic_vector(3 downto 0) := (others=>'0');
signal fila : integer range 0 to 3 := 0;

signal ind_s : std_logic := '0';
signal edo : integer range 0 to 1 := 0;

begin

filas <= fila_reg_s;

--retardo 1 ms--
process(clk)
	begin
	if rising_edge(clk) then
		if conta_1ms = delay_1ms-1 then
			conta_1ms <= 0;
			bandera <= '1';
		else
			conta_1ms <= conta_1ms+1;
			bandera <= '0';
		end if;
	end if;
end process;
----------------

--retardo 10 ms--
process(clk)
	begin
	if rising_edge(clk) then
		if conta_10ms = delay_10ms-1 then
		conta_10ms <= 0;
		bandera2 <= '1';
		else
			conta_10ms <= conta_10ms+1;
			bandera2 <= '0';
		end if;
	end if;
end process;
----------------

--proceso que activa cada fila cada 10ms--
process(clk, bandera2)
	begin
		if rising_edge(clk) and bandera2 = '1' then
			if fila = 3 then
				fila <= 0;
			else
				fila <= fila+1;
			end if;
		end if;
end process;

with fila select
	fila_reg_s <= "1000" when 0,
					  "0100" when 1,
					  "0010" when 2,
					  "0001" when others;
-------------------------------				

----------proceso que evita el efecto rebote de las teclas----------------
--llena los registros con '1' dependiendo el bot�n que se haya presionado--
process(clk,bandera)
begin
	if rising_edge(clk) and bandera = '1' then
		if fila_reg_s = "1000" then --primera fila de botones
			reg_b1 <= reg_b1(6 downto 0)&columnas(3);
			reg_b2 <= reg_b2(6 downto 0)&columnas(2);
			reg_b3 <= reg_b3(6 downto 0)&columnas(1);
			reg_ba <= reg_ba(6 downto 0)&columnas(0);
		elsif fila_reg_s = "0100" then --segunda fila de botones
			reg_b4 <= reg_b4(6 downto 0)&columnas(3);
			reg_b5 <= reg_b5(6 downto 0)&columnas(2);
			reg_b6 <= reg_b6(6 downto 0)&columnas(1);
			reg_bb <= reg_bb(6 downto 0)&columnas(0);
		elsif fila_reg_s = "0010" then --tercera fila de botones
			reg_b7 <= reg_b7(6 downto 0)&columnas(3);
			reg_b8 <= reg_b8(6 downto 0)&columnas(2);
			reg_b9 <= reg_b9(6 downto 0)&columnas(1);
			reg_bc <= reg_bc(6 downto 0)&columnas(0);
		elsif fila_reg_s = "0001" then --cuarta fila de botones
			reg_bas <= reg_bas(6 downto 0)&columnas(3);
			reg_b0  <= reg_b0(6 downto 0)&columnas(2);
			reg_bga <= reg_bga(6 downto 0)&columnas(1);
			reg_bd  <= reg_bd(6 downto 0)&columnas(0);
		end if;
	end if;
end process;
----------------------------------------------------------------------------

--manda el dato a la salida--
process(clk)
begin
	if rising_edge(clk) then
		if 	reg_b0  	= "11111111" then boton_pres <= x"0"; ind_s <= '1'; siete_seg <= "00000011"; --0
		elsif reg_b1 	= "11111111" then boton_pres <= x"1"; ind_s <= '1'; siete_seg <= "10011111"; --1
		elsif reg_b2 	= "11111111" then boton_pres <= x"2"; ind_s <= '1'; siete_seg <= "00100101"; --2
		elsif reg_b3 	= "11111111" then boton_pres <= x"3"; ind_s <= '1'; siete_seg <= "00001101"; --3
		elsif reg_b4 	= "11111111" then boton_pres <= x"4"; ind_s <= '1'; siete_seg <= "10011001"; --4
		elsif reg_b5 	= "11111111" then boton_pres <= x"5"; ind_s <= '1'; siete_seg <= "01001001"; --5
		elsif reg_b6 	= "11111111" then boton_pres <= x"6"; ind_s <= '1'; siete_seg <= "01000001"; --6
		elsif reg_b7 	= "11111111" then boton_pres <= x"7"; ind_s <= '1'; siete_seg <= "00011111"; --7
		elsif reg_b8 	= "11111111" then boton_pres <= x"8"; ind_s <= '1'; siete_seg <= "00000001"; --8
		elsif reg_b9 	= "11111111" then boton_pres <= x"9"; ind_s <= '1'; siete_seg <= "00001001"; --9
		elsif reg_ba 	= "11111111" then boton_pres <= x"a"; ind_s <= '1'; siete_seg <= "00010001"; --a
		elsif reg_bb 	= "11111111" then boton_pres <= x"b"; ind_s <= '1'; siete_seg <= "11000001"; --b
		elsif reg_bc 	= "11111111" then boton_pres <= x"c"; ind_s <= '1'; siete_seg <= "01100011"; --c
		elsif reg_bd 	= "11111111" then boton_pres <= x"d"; ind_s <= '1'; siete_seg <= "10000101"; --d
		elsif reg_bas 	= "11111111" then boton_pres <= x"e"; ind_s <= '1'; siete_seg <= "11111110"; --*
		elsif reg_bga 	= "11111111" then boton_pres <= x"f"; ind_s <= '1'; siete_seg <= "10010000"; --h
		else ind_s <= '0';
		end if;
	end if;
end process;

-----------------------------

--m�quina de estados para la bandera--
process(clk)
begin
	if rising_edge(clk) then
		if edo = 0 then
			if ind_s = '1' then
				ind <= '1';
				edo <= 1;
			else
				edo <= 0;
				ind <= '0';
			end if;
		else
			if ind_s = '1' then
				edo <= 1;
				ind <= '0';
			else
				edo <= 0;
			end if;
		end if;
	end if;
end process;
--------------------------------------


end Behavioral;

