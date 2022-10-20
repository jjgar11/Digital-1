library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Contador is

	port(
		-- input ports
		nStart : in std_logic := '0';
		nStop : in std_logic := '0';
		nReset : in std_logic := '0';
		-- clk : in std_logic;

		-- output ports
		enable : out std_logic_vector(1 downto 0);
		segmento_siete : out std_logic_vector(7 downto 0);
		Led_conteo : out std_logic
	);

end Contador;

architecture Behavioral of Contador is
	
	signal Start : std_logic;
	signal Stop : std_logic;
	signal Reset : std_logic;

	-- Se simula el clock de la FPGA
	constant ClockFrequency : integer := 50e6; -- 50 MHz
	constant ClockPeriod    : time    := 1000 ms / ClockFrequency;

	signal clk : std_logic := '1';
	signal nclk, clk_rebote : std_logic := '1';
	signal clk_segment : std_logic := '1';
	signal ar_Start, ar_Stop, ar_Reset: std_logic := '0';
	signal ext_reset : std_logic := '0';
	signal run : std_logic := '1';

	signal cuenta : std_logic_vector(5 downto 0);

	-- Binario de ejemplo
	--signal zB_bin: std_logic_vector(5 downto 0) := "010010";
	signal codigo0, codigo1: std_logic_vector(3 downto 0); 

	-- * Componente de divisor de frecuencia y antirrebote.
	
	component div_frec
		port(
			clk: in  std_logic;
			Nciclos: in	integer;
			
			f: out std_logic
		);
	end component;

	component anti_rebote
		port(
			clk : in std_logic;
			Button : in std_logic;
			isOn : out std_logic
		);
	end component;

	component control
		port(
			clk : in std_logic;
			Start : in std_logic;
			Stop : in std_logic;
			Run : out std_logic
		);
	end component;

	component reset_mod
		port(
			Reset : in std_logic;
			clk : in std_logic;
			ext_reset : out std_logic
		);
	end component;

	component senal_contador
		port(
			clk : in std_logic;
			Reset : in std_logic;
			Run : in std_logic;
			bin_cuenta : out std_logic_vector(5 downto 0)
		);
	end component;	

	component bin_bcd
		port(
			clk : in std_logic;
			binario: in  std_logic_vector(5 downto 0);
			
			bcd0, bcd1: out std_logic_vector(3 downto 0)
		);
	end component;
	
	component bcd_7seg
		port( 
		clk: in std_logic;
		code0,code1: in std_logic_vector(3 downto 0); -- Slide Switch
		
		digit: out std_logic_vector(1 downto 0); -- Enable 4 digit
		Siete_Seg: out std_logic_vector(7 downto 0) -- 7 Segments and Dot LEDs
		); 
	end component;

begin

	-- * En simulacion
	clk <= not clk after ClockPeriod / 2;
	Start <= nStart;
	Stop <= nStop;
	Reset <= nReset;

	-- * En FPGA
	-- Start <= not nStart;
	-- Stop <= not nStop;
	-- Reset <= not nReset;

	div_pulsador : div_frec
	port map(clk,5e3,clk_rebote);
	-- port map(clk,1e6,clk_rebote);

	reboteStart : anti_rebote
	port map(clk_rebote,Start,ar_Start);
	
	reboteStop : anti_rebote
	port map(clk_rebote,Stop,ar_Stop);

	runControl : control
	port map(clk_rebote,ar_Start,ar_Stop,run);

	reboteReset : anti_rebote
	port map(clk_rebote,Reset,ar_Reset);

	extended_Reset : reset_mod
	port map(ar_Reset,clk_rebote,ext_reset);
    

	div_1Hz : div_frec
	port map(clk,25e3,nclk);
	-- port map(clk,25e6,nclk);

	senal : senal_contador
	port map(nclk,ext_reset,run,cuenta);

	div_sietesegmetos : div_frec
	port map(clk,20e4,clk_segment);

	code : bin_bcd
	port map(clk_rebote,cuenta,codigo0,codigo1);
	
	nixie : bcd_7seg
	port map(clk_segment,codigo0,codigo1,enable,segmento_siete);
	
	Led_conteo <= not nclk;

end Behavioral;