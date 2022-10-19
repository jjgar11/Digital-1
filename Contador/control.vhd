library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity control is

	port(
		-- input ports
		clk : in std_logic;
		Start : in std_logic;
		Stop : in std_logic;

		-- output ports
		Run : out std_logic
	);
		
end control;


architecture Behavioral of control is
	
    signal r : std_logic := '1';

begin
	
	process(clk)
	begin

		if rising_edge(clk) then
			if Start = '1' then
				r <= '1';
			end if;
			if Stop = '1' then
				r <= '0';
			end if;
		end if;

	end process;

    Run <= r;
	
end Behavioral;