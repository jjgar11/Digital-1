library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Sumador is

	port(
--		input ports
		A, B, CAnt : in std_logic;
--		output ports
		Res, CSig : out std_logic
--		BMayor  : out std_logic;
	);
	
end Sumador;

architecture Behavioral of Sumador is
	
	begin 
	
	Res <= (A xor B) xor CAnt;
	CSig <= ((A xor B) and CAnt) or (A and B);
	
end Behavioral;