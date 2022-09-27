library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity PWM is

	port(
		-- input ports
		nUp : in std_logic;
		nDown : in std_logic;
		-- clk : in std_logic;

		-- output ports
		Led : out std_logic
	);

end PWM;

architecture Behavioral of PWM is

	-- * Declare las señales que considere necesarias. Estas señales saldrán de unas instancias y entrarán
	-- a otras.
	
	signal Up : std_logic;
	signal Down : std_logic;

	-- Se simula el clock de la FPGA
	constant ClockFrequency : integer := 50e6; -- 50 MHz
    constant ClockPeriod    : time    := 1000 ms / ClockFrequency;

	constant T : integer := 10;

	signal clk, nclk, clk_div : std_logic := '1';
	signal sled : std_logic := '0';
	signal tau : integer range 0 to 10 := 2;
	signal increase, decrease : std_logic := '0';

	-- * Declare el componente del divisor de frecuencia y del antirrebote.
	
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
		
	-- * Declare el componente del modulador y de la señal PWM.
	
	component Modulador
		port(
			-- input ports
			clk : in std_logic;
			Up : in std_logic;
			Down : in std_logic;
			tau : in integer range 0 to 10;
			-- clk : in std_logic;

			-- output ports
			tau_mod : out integer range 0 to 10
		);
	end component;

	component senal_PWM
		port(
			tau : in integer;
			T : in integer;
			clk : in std_logic;

			pwm : out std_logic
		);
	end component;

begin

	-- En simulacion
	clk <= not clk after ClockPeriod / 2;
	Up <= nUp;
	Down <= nDown;

	-- En FPGA
	-- Up <= not nUp;
	-- Down <= not nDown;

	-- * Cree instancias del divisor de frecuencia para generar la señal de muestreo de los antirrebote
	--   y la señal de reloj del registro que almacenará el conteo del pwm.

	div_pulsador : div_frec
	port map(clk,2500,clk_div);

	-- * Cree instancias del antirrebote para el pulsador de aumento y de reducción de tau.

	reboteUp : anti_rebote
	port map(clk_div,Up,increase);
	
	reboteDown : anti_rebote
	port map(clk_div,Down,decrease);

	-- * Cree la instancia del modulador y de la señal PWM.

	modtau : Modulador
	port map(clk_div,increase,decrease,tau,tau);

	div_1Hz : div_frec
	port map(clk,25e3,nclk);
	
	senal : senal_PWM
	port map(tau,T,nclk,sled);

	-- * Conecte las instancias con las señales internas (intermedias) que declaró.

	-- Led <= not sled;			-- En FPGA
	Led <= sled;				-- En simulacion

end Behavioral;