library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity And_Comp is
	port (
		a : in std_logic;
		b: in std_logic;
--		downto 0 es que el de la izquierda es el mas significativo

		c, d : out std_logic
	);
end And_Comp;

architecture Behavioral of And_Comp is
	
	begin
	c <= a and b;	
	d <= a and '1';	
	
end Behavioral;