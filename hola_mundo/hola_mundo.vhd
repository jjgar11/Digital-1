library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity hola_mundo is

	port(
	
		-- input ports
		a: in std_logic;
		b: in std_logic;
		
		-- output ports
		c: out std_logic
	);
	
end hola_mundo;

architecture compuerta_and of hola_mundo is

	begin
	
	c <= a and b;
	
end compuerta_and;