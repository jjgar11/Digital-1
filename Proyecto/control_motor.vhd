library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity control_motor is

	port(
		clk : in std_logic;
		clk_motor : in std_logic;
		clk_min : in std_logic;
		reg_config : in std_logic_vector(15 downto 0);
		StIn : in std_logic;
		DiIn : in std_logic;
		StOut : out std_logic;
		DiOut : out std_logic
	);

end control_motor;


architecture Behavioral of control_motor is

	type estados is (init, toContainer, toInit, espera);
	signal ep : estados := init;
	signal ef : estados;

	signal contadorCiclos : integer := 0;
	signal contadorPausa : integer := 0;
	signal ciclos, pausa : integer := 0;
	-- signal flag : std_logic;
	signal conteo : std_logic_vector(3 downto 0) := "0000";
	signal contenedorActual : std_logic_vector(1 downto 0) := "00";
	signal nSt : std_logic := '0';
	signal nDi : std_logic := '0';

	signal arrive, dispensed, go : std_logic := '0';

begin

	process(ep,clk)
	begin

	case ep is

		when init =>
			if conteo(3) = '1' then
				nSt <= '0';
				nDi <= '0';
				ciclos <= 256;
				ef <= toContainer;
			elsif conteo(2) = '1' then
				nSt <= '0';
				nDi <= '0';
				ciclos <= 768;
				ef <= toContainer;
			elsif conteo(1) = '1' then
				nSt <= '0';
				nDi <= '1';
				ciclos <= 768;
				ef <= toContainer;
			elsif conteo(0) = '1' then
				nSt <= '0';
				nDi <= '1';
				ciclos <= 256;
				ef <= toContainer;
			else
				nSt <= '1';
				ciclos <= 0;
				ef <= init;
			end if;
			
		when toContainer =>
			if arrive = '1' then
				nSt <= '1';
				pausa <= 15;
				ef <= espera;
			else
				ef <= toContainer;
			end if;
			
		when espera =>
			if dispensed = '1' then
				pausa <= 0;
				nSt <= '0';
				nDi <= not nDi;
				ef <= toInit;
			else
				ef <= espera;
			end if ;

		when toInit =>
			if arrive = '1' then
				nSt <= '1';
				pausa <= 15;
				ef <= init;
			else
				ef <= toInit;
			end if;

	end case;

	end process;

	process(clk_motor)
	begin

	if rising_edge(clk_motor) then
		if nSt = '0' then
			if contadorCiclos < ciclos then
				contadorCiclos <= contadorCiclos + 1;
				arrive <= '0';
			else
				contadorCiclos <= 0;
				arrive <= '1';
			end if;
		end if ;
		if nSt = '1' and ep = espera then
			if contadorPausa < pausa then
				contadorPausa <= contadorPausa + 1;
				dispensed <= '0';
			else
				contadorPausa <= 0;
				dispensed <= '1';
			end if;
		end if ;
	end if ;

	end process;

	process(clk)
	begin
	
	if rising_edge(clk) then
		ep <= ef;
	end if;

	end process;

	StOut <= nSt;
	DiOut <= nDi;

end Behavioral;