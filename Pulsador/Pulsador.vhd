library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Pulsador is

	port(
--		input ports
		P: in std_logic;
--		output ports
		LED : out std_logic
	);

end Pulsador;

architecture Behavioral of Pulsador is

	signal q : std_logic;

	begin

	process(P)
	
		begin
		
			if rising_edge(P) then
				q <= not q;
			end if;
			
			led <= q;
	
	end process;

end Behavioral;
