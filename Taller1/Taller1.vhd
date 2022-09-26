library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Taller1 is

	port(
--		input ports
		a,b,c,d,e,f,g,h : in std_logic;
--		output ports
		x : out std_logic
	);
	
end Taller1;

--architecture numeralA of Taller1 is
--	
--	begin 
--	
--	x <= ((((a and b) or c)	and d) or e);
--	
--	
--end numeralA;

--architecture numeralB of Taller1 is
--	
--	begin 
--	
--	x <= (not ((not (a nand b) or not c)	nand d) or not e);
--	
--	
--end numeralB;

architecture numeralC of Taller1 is
	
	begin 
	
	x <= (not (a nand b) or not (c nand d)) nand (not (e nand f) or not (g nand h));
	
	
end numeralC;