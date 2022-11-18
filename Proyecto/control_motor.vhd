library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity control_motor is

	port(
		clk : in std_logic;
		StIn : in std_logic;
		DiIn : in std_logic;
		B : in std_logic_vector(0 to 3);
		StOut : out std_logic;
		DiOut : out std_logic
	);

end control_motor;


architecture Behavioral of control_motor is

	signal contadorCiclos : integer := 1;
	signal contadorPausa : integer := 0;
	signal flag : std_logic;
	signal Banterior : std_logic_vector(0 to 3);
	signal nSt : std_logic := '0';
	signal nDi : std_logic := '0';

	component flp_jk
		port(
			-- Input ports
			j: in  std_logic;
			k: in  std_logic;
			clk: in	std_logic;

			-- Output ports
			Q: out std_logic
		);
	end component;

begin

	-- flag <= B and Banterior;
	process(clk,flag)
	begin

		if rising_edge(clk) then
		-- 	Banterior <= B;
		-- end if;

		-- if rising_edge(flag) then
			if contadorCiclos < 20-1 then
				contadorCiclos <= contadorCiclos + 1;
				nSt <= '0';
				nDi <= '0';
			else
				nSt <= '1';
				nDi <= '1';
				if contadorPausa < 10-1 then
					contadorPausa <= contadorPausa + 1;
				else
					contadorCiclos <= 1;
					contadorPausa <= 0;
				end if;
			end if;
		end if;

	end process;

	StOut <= nSt;
	DiOut <= nDi;

end Behavioral;