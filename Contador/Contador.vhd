library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Contador is

	port(
		-- input ports
		nStart : in std_logic;
		nStop : in std_logic;
		nReset : in std_logic := '0';
		-- clk : in std_logic;

		-- output ports
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
	signal ar_Start, ar_Stop, ar_Reset: std_logic := '0';
	signal run : std_logic := '1';

	signal cuenta : std_logic_vector(5 downto 0);

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

	component senal_contador
		port(
			clk : in std_logic;
			Reset : in std_logic;
			Run : in std_logic;
			bin_cuenta : out std_logic_vector(5 downto 0)
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

	reboteStart : anti_rebote
	port map(clk_rebote,Start,ar_Start);
	
	reboteStop : anti_rebote
	port map(clk_rebote,Stop,ar_Stop);

	runControl : control
	port map(clk_rebote,ar_Start,ar_Stop,run);

	reboteReset : anti_rebote
	port map(clk_rebote,Reset,ar_Reset);
    

	div_1Hz : div_frec
	port map(clk,25e3,nclk);

	senal : senal_contador
	port map(nclk,ar_Reset,run,cuenta);

	Led_conteo <= not nclk;

end Behavioral;