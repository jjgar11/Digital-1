library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity PWM is

	port(
		-- input ports
		Up : in std_logic;
		Down : in std_logic;
		-- clk : in std_logic;

		-- output ports
		led : out std_logic
	);

end PWM;

architecture Behavioral of PWM is

	-- * Declare las señales que considere necesarias. Estas señales saldrán de unas instancias y entrarán
	-- a otras.
	
	signal cuenta : integer range 1 to 10;
	-- signal cuenta2 : integer range 1 to 25000;

	constant ClockFrequency : integer := 50e6; -- 50 MHz
    constant ClockPeriod    : time    := 1000 ms / ClockFrequency;
	constant T : integer := 10;

	signal clk : std_logic := '1';
	signal nclk : std_logic := '1';
	signal clk_div : std_logic := '1';
	signal sled : std_logic := '1';
	signal tau : integer range 0 to 15 := 2;
--	signal tau_mod : integer 

	-- * Declare el componente del divisor de frecuencia y del antirrebote.
	
	component div_frec
		port(
			clk: in  std_logic;
			Nciclos: in	integer;
			
			f: out std_logic
			);
		end component;
		
	-- * Declare el componente del modulador y de la señal PWM.
	
	component Modulador
		port(
			-- input ports
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

	clk <= not clk after ClockPeriod / 2;

	-- * Cree instancias del divisor de frecuencia para generar la señal de muestreo de los antirrebote
	--   y la señal de reloj del registro que almacenará el conteo del pwm.

	div_pulsador : div_frec
	port map(clk,25,clk_div);

	-- * Cree instancias del antirrebote para el pulsador de aumento y de reducción de tau.

	-- * Cree la instancia del modulador y de la señal PWM.

	modtau : Modulador
	port map(Up,Down,tau,tau);

	div_1Hz : div_frec
	port map(clk,25e3,nclk);
	
	senal : senal_PWM
	port map(tau,T,nclk,sled);

	process(clk, nclk)

	begin
		-- if rising_edge(clk) then
		-- 	if cuenta2 = 25 then
		-- 		nclk <= not nclk;
		-- 		cuenta2 <= 1;
		-- 	else
		-- 		cuenta2 <= cuenta + 1;
		-- 	end if;
		-- end if;
		-- if rising_edge(nclk) then
			-- if cuenta = 10 then
			-- 	cuenta <= 1;
			-- 	sled <= not sled;
			-- else
			-- 	cuenta <= cuenta + 1;
			-- end if;
			-- if cuenta = t then
			-- 	sled <= not sled;
			-- end if;
		-- end if;

	end process;

	-- * Conecte las instancias con las señales internas (intermedias) que declaró.

	led <= sled;

end Behavioral;