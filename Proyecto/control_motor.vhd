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
		StOut : out std_logic;
		DiOut : out std_logic
	);

end control_motor;


architecture Behavioral of control_motor is

	signal contador : integer := 0;
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

	process(clk)
	begin

		if rising_edge(clk) then
			if contador <= 20 then
				contador <= contador + 1;
				nSt <= StIn;
				nDi <=  DiIn;
			else
				contador <= 0;
				nSt <=  StIn;
				nDi <=  not DiIn;
			end if;
		end if;

	end process;

	StOut <= nSt;
	DiOut <= nDi;

end Behavioral;