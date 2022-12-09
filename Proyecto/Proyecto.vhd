library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Proyecto is

	port(
		clk : in std_logic;
		columna: in std_logic_vector(3 downto 0);
		configIn: in std_logic := '0';
		fila: out std_logic_vector(3 downto 0);
		BO : out std_logic_vector(3 downto 0);
		comm_ino : out std_logic_vector(1 downto 0);
		digit : out std_logic_vector(4 downto 0);
		disp7seg : out std_logic_vector(7 downto 0);
		conteoOut, tempOut : out std_logic_vector(3 downto 0);
		clk_out : out std_logic;
		buzzer_out : out std_logic

		-- rw, rs, e : OUT STD_LOGIC;  --read/write, setup/data, and enable for lcd
		-- lcd_data  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);

end Proyecto;


architecture Behavioral of Proyecto is

	-- Se simula el clock de la FPGA
	-- constant ClockFrequency : integer := 50e6; -- 50 MHz
	-- constant ClockPeriod    : time    := 1000 ms / ClockFrequency;
	-- signal clk : std_logic := '1';

	signal clk_motor, clk_rebote, clk_ar, clk_min, clk_tc : std_logic := '1';
	signal St, Di : std_logic := '0';
	signal B : std_logic_vector(0 to 3) := "0001";
	signal boton : std_logic_vector(3 downto 0) := "0000";
	signal ind, buzzer : std_logic := '0';
	signal reg_config : std_logic_vector(15 downto 0) := (others => '0');

	signal configIno: std_logic := '0';
	signal config: std_logic := '0';
	-- signal conteo : std_logic_vector(3 downto 0);

	component anti_rebote

	port(
		clk : in std_logic;
		Button : in std_logic;
		isOn : out std_logic
	);

	end component;
	
	component div_frec
		port(
			-- Input ports
			clk: in  std_logic;
			Nciclos: in	integer;

			-- Output ports
			f: out std_logic
		);
	end component;

	component control_motor
		port(
			clk : in std_logic;
			clk_motor : in std_logic;
			clk_min : in std_logic;
			reg_config : in std_logic_vector(15 downto 0);
			-- conteo : in std_logic_vector(3 downto 0);
			StIn : in std_logic;
			DiIn : in std_logic;
			StOut : out std_logic;
			DiOut : out std_logic;
			TeclaOprimida : in std_logic_vector(3 downto 0);
			ind : in std_logic;
			conteoOut, tempOut : out std_logic_vector(3 downto 0);
			buzzer : out std_logic
		);
	end component;

	component PAP_motor
		port(
			clk : in std_logic;
			St : in std_logic;
			Di : in std_logic;
			Bin : in std_logic_vector(3 downto 0);
			Bout : out std_logic_vector(3 downto 0)
		);
	end component;

	component teclado
		port( 
			clk: in std_logic;
			clk_ar : in std_logic;
			columnas: in std_logic_vector(3 downto 0);
			
			filas: out std_logic_vector(3 downto 0); -- Enable 4 digit
			Siete_Seg_Out: out std_logic_vector(7 downto 0) -- 7 Segments and Dot LEDs
		); 
	end component;

	component tecladoDos
		PORT(
			CLK 		  : IN  STD_LOGIC; 						  --RELOJ FPGA
			COLUMNAS   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); --PUERTO CONECTADO A LAS COLUMNAS DEL TECLADO
			FILAS 	  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); --PUERTO CONECTADO A LA FILAS DEL TECLADO
			BOTON_PRES : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); --PUERTO QUE INDICA LA TECLA QUE SE PRESION�
			IND		  : OUT STD_LOGIC							  --BANDERA QUE INDICA CUANDO SE PRESION� UNA TECLA (S�LO DURA UN CICLO DE RELOJ)
		);
	end component;

	component control_config
		port(
			clk : in std_logic;
			config : in std_logic;
			TeclaOprimida : in std_logic_vector(3 downto 0);
			ind : in std_logic := '0';
			-- VecTiempos : out std_logic_vector(15 downto 0) := (others => '0');
			comm_ino : out std_logic_vector(1 downto 0);
			reg_config_In : in std_logic_vector(15 downto 0);
			reg_config_Out : out std_logic_vector(15 downto 0)

			-- rw, rs, e : OUT STD_LOGIC;  --read/write, setup/data, and enable for lcd
			-- lcd_data  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	end component;

	component DispSeg
		port( 
			clk: in std_logic;
			VecTiempos: in std_logic_vector(15 downto 0); -- Slide Switch
			btn : in std_logic_vector(3 downto 0);
			
			digit: out std_logic_vector(4 downto 0); -- Enable 4 digit
			Siete_Seg: out std_logic_vector(7 downto 0) -- 7 Segments and Dot LEDs
		);
	end component;
	
begin
	
	-- clk <= not clk after ClockPeriod / 2;

	configIno <= not configIn;
	-- conteo <= not conteoIn;
	clk_out <= not clk_min;
	
	div1 : div_frec
	port map(clk,100e3,clk_motor);

	div2 : div_frec
	port map(clk,25e3,clk_ar);

	div3 : div_frec
	port map(clk,500e3,clk_tc);

	div4 : div_frec
	port map(clk,750e6,clk_min);

	ar5 : anti_rebote
	port map(clk_motor,configIno,config);

	control : control_motor
	port map(clk,clk_motor,clk_min,reg_config,St,Di,St,Di,boton,ind,conteoOut,tempOut,buzzer);

	motor : PAP_motor
	port map(clk_motor,St,Di,B,B);

	tecladitodos :tecladoDos
	port map(clk,columna,fila,boton,ind);

	config_comp :control_config
	port map(clk,config,boton,ind,comm_ino,reg_config,reg_config);

	-- controlito : control_config
	-- port map(clk,config,boton,ind,VecTiempos);
	
	prueba : DispSeg
	port map(clk_ar,reg_config,boton,digit,disp7seg);

	BO <= B;
	buzzer_out <= not buzzer;

end Behavioral;