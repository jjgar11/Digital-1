library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Proyecto is

	port(
		clk : in std_logic;
		-- St : in std_logic;
		BO : out std_logic_vector(3 downto 0)
	);


end Proyecto;


architecture Behavioral of Proyecto is

	-- Se simula el clock de la FPGA
	-- constant ClockFrequency : integer := 50e6; -- 50 MHz
	-- constant ClockPeriod    : time    := 1000 ms / ClockFrequency;
	-- signal clk : std_logic := '1';

	signal nclk, clk_rebote : std_logic := '1';
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

begin

	-- clk <= not clk after ClockPeriod / 2;
	div1 : div_frec
	port map(clk,100e3,nclk);

	control : control_motor
	port map(nclk,St,Di,St,Di);

	motor : PAP_motor
	port map(nclk,St,Di,B,B);

	BO <= B;

end Behavioral;