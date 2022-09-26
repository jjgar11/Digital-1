library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Sumador_Parcial is

	port(
--		input ports
		A, CAnt : in std_logic;
--		output ports
		Res, CSig : out std_logic
--		BMayor  : out std_logic;
	);
	
end Sumador_Parcial;

architecture Behavioral of Sumador_Parcial is
	
	begin 
	
	Res <= A xor CAnt;
	CSig <= A and CAnt;
	
end Behavioral;