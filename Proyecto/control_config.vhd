library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity control_config is

	port(
		clk : in std_logic;
		config : in std_logic;
		TeclaOprimida : in std_logic_vector(3 downto 0);
		ind : in std_logic := '0';
		comm_ino : out std_logic_vector(1 downto 0);
		reg_config_In : in std_logic_vector(15 downto 0);
		reg_config_Out : out std_logic_vector(15 downto 0)

		-- rw, rs, e : OUT STD_LOGIC;  --read/write, setup/data, and enable for lcd
		-- lcd_data  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  
	);

end control_config;


architecture Behavioral of control_config is


	-- component  control_lcd IS
	-- 	PORT(
	-- 		clk,lcd_busy : IN  STD_LOGIC;  --system clock
	-- 		lcd_enable : INOUT STD_LOGIC;  
	-- 		lcd_reset: OUT std_logic:='0';
	-- 		lcd_bus: OUT std_logic_vector(9 downto 0);
	-- 		en_teclado: IN std_logic;
	-- 		tecla: IN std_logic_vector(3 downto 0)
	-- 	); --data signals for lcd
	-- END component control_lcd;

	-- component driver IS
	-- 	PORT(
	-- 		clk        : IN   STD_LOGIC;                     --system clock
	-- 		reset_n    : IN   STD_LOGIC;                     --active low reinitializes lcd
	-- 		lcd_enable : IN   STD_LOGIC;                     --latches data into lcd controller
	-- 		lcd_bus    : IN   STD_LOGIC_VECTOR(9 DOWNTO 0);  --data and control signals
	-- 		busy       : OUT  STD_LOGIC := '1';              --lcd controller busy/idle feedback
	-- 		rw, rs, e  : OUT  STD_LOGIC;                     --read/write, setup/data, and enable for lcd
	-- 		lcd_data   : OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	-- 	); --data signals for lcd
	-- END component  driver;

	type estados is (init, esperaContenedor, tiempo, esperaTiempo0, esperaTiempo1, guardar, pausa);
	signal ep : estados := pausa; 	--Estado Presente
	signal ef : estados; 		--Estado Siguiente

	signal reg_config : std_logic_vector(15 downto 0) := (others => '0');
	signal Tecla : std_logic_vector(3 downto 0);
	signal TiempoBin : std_logic_vector(3 downto 0);
	signal temp0 : std_logic_vector(3 downto 0);
	signal text_command : std_logic_vector(1 downto 0);

	signal sig_bus: std_logic_vector(9 downto 0);
	signal sig_reset: std_logic;
	signal sig_en: std_logic:='1';
	signal sig_busy: std_logic;

begin

	-- u_logic: control_lcd
	-- port map( clk, sig_busy, sig_en, sig_reset, sig_bus, ind, TeclaOprimida);
	-- lcd_driver: driver
	-- port map(clk, sig_reset, sig_en, sig_bus, sig_busy, rw, rs, e, lcd_data);


	process(ep,ind,config)
	begin

	case ep is

		when pausa =>
			--TiempoBin <= "0000";
			--Tecla <= "0000";
			if config = '1' then
				ef <= init;
				else 
				text_command <= "00";  --Presione config
				ef <= pausa;
			end if;

		when init =>
			if (TeclaOprimida >= x"A" or TeclaOprimida <= x"D") and ind = '1' then
				Tecla <= TeclaOprimida;
				ef <= esperaContenedor;
			else
				ef <= init;
				text_command <= "01";  --Seleccione contenedor 
			end if;
		
		when esperaContenedor =>
			if TeclaOprimida = x"E" and ind = '1' then
				ef <= init;
			elsif TeclaOprimida = x"F" and ind = '1' then
				ef <= tiempo;
			else
				text_command <= "10";  --Presione OK
				ef <= esperaContenedor;
			end if;

		when tiempo =>
			if TeclaOprimida >= x"0" and TeclaOprimida <= x"9" and ind = '1' then
				TiempoBin <= TeclaOprimida;
				temp0 <= TeclaOprimida;
				ef <= esperaTiempo1;
			else 
				text_command <= "11";  --Digite el Tiempo
				ef <= tiempo;
			end if;

		when esperaTiempo1 =>
			if TeclaOprimida = x"F" and ind = '1' then
				ef <= guardar;
			elsif temp0 <= x"1" and TeclaOprimida>=x"0" and TeclaOprimida<=x"5" and ind = '1' then
				TiempoBin <= "1010" + TeclaOprimida;
				ef <= esperaTiempo0;
			elsif TeclaOprimida = x"E" and ind = '1' then
				ef <= tiempo;
			else
				text_command <= "11";  --Digite el Tiempo
				ef <= esperaTiempo1;
			end if;

		when esperaTiempo0 =>
			if TeclaOprimida = x"E" and ind = '1' then
				ef <= tiempo;
			elsif TeclaOprimida = x"F" and ind = '1' then
				ef <= guardar;
			else
				text_command <= "10"; --presione OK
				ef <= esperaTiempo0;
			end if;

		when guardar =>
			if Tecla = x"A" then
				reg_config <= TiempoBin & reg_config_In(11 downto 0);
			elsif Tecla = x"B" then
				reg_config <= reg_config_In(15 downto 12) & TiempoBin & reg_config_In(7 downto 0);
			elsif Tecla = x"C" then
				reg_config <= reg_config_In(15 downto 8) & TiempoBin & reg_config_In(3 downto 0);
			elsif Tecla = x"D" then
				reg_config <= reg_config_In(15 downto 4) & TiempoBin;
			end if;
			ef <= pausa;
				

	end case;

	end process;

	process(clk)
	begin
		if rising_edge(clk) then
			ep <= ef;
		end if;
	end process;

	reg_config_Out <= reg_config;
	comm_ino <= not text_command;

end Behavioral;