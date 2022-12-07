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
		okButton : in std_logic:= '0';
		reg_config : in std_logic_vector(15 downto 0);
		-- conteo : std_logic_vector(3 downto 0);
		StIn : in std_logic;
		DiIn : in std_logic;
		StOut : out std_logic;
		DiOut : out std_logic;
		conteoOut, tempOut : out std_logic_vector(3 downto 0);
		buzzer : out std_logic
	);

end control_motor;


architecture Behavioral of control_motor is

	type estados is (init, espera, toContainer, onContainer, verify);
	signal ep : estados := init;
	signal ef : estados;

	signal contadorCiclos, ciclos : integer := 0;
	signal conteo : std_logic_vector(3 downto 0) := "0000";
	signal dispensed, temp, tempAnt : std_logic_vector(3 downto 0) := "0000";
	signal contAct, contSig, ciclosBin : std_logic_vector(1 downto 0) := "00";
	signal contadorA,contadorB,contadorC,contadorD : std_logic_vector(3 downto 0) := "0000";
	signal St, Di, arrive : std_logic := '0';
	signal edo, flag_arrive : std_logic := '0';

begin

	conteoOut <= not conteo;
	tempOut <= not temp;

	ciclosBin(1) <= ((not contAct(1) and contSig(1)) or (contAct(1) and not contSig(1))) and ((not contAct(0) and not contSig(0)) or (contAct(0) and contSig(0)));
	ciclosBin(0) <= (not contAct(0) and contSig(0)) or (contAct(0) and not contSig(0));
	Di <= (not contAct(1) and not contAct(0) and not contSig(1)) or (not contAct(1) and contAct(0) and contSig(1)) or (contAct(1) and not contAct(0) and contSig(1)) or (contAct(1) and contAct(0) and not contSig(1));
	ciclos <= to_integer(ieee.numeric_std.unsigned(ciclosBin)) * 510;

	process(ep,clk)
	begin

	case ep is

		when init =>
			-- St <= '1';
			buzzer <= '0';
			if temp = tempAnt or temp = "0000" then
				ef <= init;
			else 
				conteo <= temp;
				ef <= espera;
			end if;

		when espera =>
			tempAnt <= temp;
			buzzer <= '0';
			contSig(1) <= not conteo(3) and not conteo(2);
			contSig(0) <= not conteo(3) and (conteo(2) or not conteo(1));
			St <= '0';
			ef <= toContainer;

		when toContainer =>
			if flag_arrive = '1' then
				buzzer <= '1';
				St <= '1';
				contAct <= contSig;
				ef <= onContainer;
			else 
				buzzer <= '0';
				St <= '0';
				ef <= toContainer;
			end if;

		when onContainer =>
			if okButton = '1' then
				-- dispensed <= (not contAct(1) and not contAct(0)) & (not contAct(1) and contAct(0)) & (contAct(1) and not contAct(0)) & (contAct(1) and contAct(0));
				conteo <= ('0') & (not contSig(0) and conteo(2)) & (not contSig(1) and conteo(1)) & (conteo(0) and not (contSig(1) and contSig(0)));
				buzzer <= '0';
				ef <= verify;
			else 
				buzzer <= '1';
				ef <= onContainer;
			end if;

		when verify =>
			if conteo = "0000" then
				ef <= init;
			else 
				ef <= espera;
			end if;

	end case;

	end process;

	process(clk_motor)
	begin

	if rising_edge(clk_motor) then
		if St = '0' then
			if contadorCiclos < ciclos then
				contadorCiclos <= contadorCiclos + 1;
				arrive <= '0';
			else
				contadorCiclos <= 0;
				arrive <= '1';
			end if;
		else
			arrive <= '0';
		end if;
	end if;

	end process;

	process(clk)
	begin
	
	if rising_edge(clk) then
		ep <= ef;
	end if;

	end process;

	process(clk_min)
	begin

		if rising_edge(clk_min) then
			
			if reg_config(15 downto 12) = "0000" then
				temp(3) <= '0';
			else
				if contadorA = reg_config(15 downto 12)-1 then
					contadorA <= "0000";
					temp(3) <= '1';
				else
					contadorA <= contadorA+1;
					temp(3) <= '0';
				end if;
			end if;
				
			if reg_config(11 downto 8) = "0000" then
				temp(2) <= '0';
			else
				if contadorB = reg_config(11 downto 8)-1 then
					contadorB <= "0000";
					temp(2) <= '1';
				else
					contadorB <= contadorB+1;
					temp(2) <= '0';
				end if;
			end if;
				
			if reg_config(7 downto 4) = "0000" then
				temp(1) <= '0';
			else
				if contadorC = reg_config(7 downto 4)-1 then
					contadorC <= "0000";
					temp(1) <= '1';
				else
					contadorC <= contadorC+1;
					temp(1) <= '0';
				end if;
			end if;
				
			if reg_config(3 downto 0) = "0000" then
				temp(0) <= '0';
			else
				if contadorD = reg_config(3 downto 0)-1 then
					contadorD <= "0000";
					temp(0) <= '1';
				else
					contadorD <= contadorD+1;
					temp(0) <= '0';
				end if;
			end if;

		end if;

	end process;

	process(clk)
	begin
		if rising_edge(clk) then
			if edo = '0' then
				if arrive = '1' then
					flag_arrive <= '1';
					edo <= '1';
				else
					edo <= '0';
					flag_arrive <= '0';
				end if;
			else
				if arrive = '1' then
					edo <= '1';
					flag_arrive <= '0';
				else
					edo <= '0';
				end if;
			end if;
		end if;
	end process;

	StOut <= St;
	DiOut <= Di;

end Behavioral;