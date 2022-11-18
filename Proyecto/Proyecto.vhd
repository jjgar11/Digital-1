library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Proyecto is

	port(
		-- clk : in std_logic;
		-- St : in std_logic;
		columna: in std_logic_vector(3 downto 0);
		fila: out std_logic_vector(3 downto 0);
		BO : out std_logic_vector(3 downto 0);
		dispOn : out std_logic_vector(3 downto 0) := "1110";
		disp7seg : out std_logic_vector(7 downto 0)
	);


end Proyecto;


architecture Behavioral of Proyecto is

	-- Se simula el clock de la FPGA
	constant ClockFrequency : integer := 50e6; -- 50 MHz
	constant ClockPeriod    : time    := 1000 ms / ClockFrequency;
	signal clk : std_logic := '1';

	signal nclk, clk_rebote, clk_ar, clk_tc : std_logic := '1';
	signal St, Di : std_logic := '0';
	signal B : std_logic_vector(0 to 3) := "0001";

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
			StIn : in std_logic;
			DiIn : in std_logic;
			B : in std_logic_vector(0 to 3);
			StOut : out std_logic;
			DiOut : out std_logic
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
			columnas: in std_logic_vector(3 downto 0);
			
			filas: out std_logic_vector(3 downto 0); -- Enable 4 digit
			Siete_Seg_Out: out std_logic_vector(7 downto 0) -- 7 Segments and Dot LEDs
		); 
	end component;

begin

	clk <= not clk after ClockPeriod / 2;
	div1 : div_frec
	port map(clk,100e3,nclk);

	-- div2 : div_frec
	-- port map(clk,200e3,clk_ar);

	div3 : div_frec
	port map(clk,1e3,clk_tc);

	control : control_motor
	port map(nclk,St,Di,B,St,Di);

	motor : PAP_motor
	port map(nclk,St,Di,B,B);

	tecladito : teclado
	port map(clk_tc,columna,fila,disp7seg);

	BO <= B;

end Behavioral;