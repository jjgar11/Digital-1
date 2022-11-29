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
		reg_config_In : in std_logic_vector(15 downto 0);
		reg_config_Out : out std_logic_vector(15 downto 0)
	);

end control_config;


architecture Behavioral of control_config is

	type estados is (init, esperaContenedor, tiempo, esperaTiempo0, esperaTiempo1, guardar, pausa);
	signal ep : estados := pausa; 	--Estado Presente
	signal ef : estados; 		--Estado Siguiente

	signal reg_config : std_logic_vector(15 downto 0) := (others => '0');
	signal Tecla : std_logic_vector(3 downto 0);
	signal TiempoBin : std_logic_vector(3 downto 0);
	signal temp0 : std_logic_vector(3 downto 0);

begin

	process(ep,ind,config)
	begin

	case ep is

		when pausa =>
			--TiempoBin <= "0000";
			--Tecla <= "0000";
			if config = '1' then
				ef <= init;
			else 
				ef <= pausa;
			end if;

		when init =>
			if (TeclaOprimida >= x"A" or TeclaOprimida <= x"D") and ind = '1' then
				Tecla <= TeclaOprimida;
				ef <= esperaContenedor;
			else
				ef <= init;
			end if;
		
		when esperaContenedor =>
			if TeclaOprimida = x"E" and ind = '1' then
				ef <= init;
			elsif TeclaOprimida = x"F" and ind = '1' then
				ef <= tiempo;
			else
				ef <= esperaContenedor;
			end if;

		when tiempo =>
			if TeclaOprimida >= x"0" and TeclaOprimida <= x"9" and ind = '1' then
				TiempoBin <= TeclaOprimida;
				temp0 <= TeclaOprimida;
				ef <= esperaTiempo1;
			else 
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
				ef <= esperaTiempo1;
			end if;

		when esperaTiempo0 =>
			if TeclaOprimida = x"E" and ind = '1' then
				ef <= tiempo;
			elsif TeclaOprimida = x"F" and ind = '1' then
				ef <= guardar;
			else
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

end Behavioral;