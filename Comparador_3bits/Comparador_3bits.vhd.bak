library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Comparador_4bits is

	port(
--		input ports
		A, B : in std_logic_vector(3 downto 0);
--		output ports
		AmOut, BmOut, IgOut : out std_logic
	);
	
end Comparador_4bits;

architecture bit_a_bit of Comparador_4bits is

	signal Am3, Bm3, Ig3 : std_logic;
	signal Am2, Bm2, Ig2 : std_logic;
	signal Am1, Bm1, Ig1 : std_logic;
	signal Am0, Bm0, Ig0 : std_logic;
	signal AmTot, BmTot, IgTot : std_logic;
	
	begin 
	
	Am3 <= A(3) and not B(3);
	Ig3 <= A(3) xnor B(3);
	Bm3 <= not A(3) and B(3);
	
	Am2 <= A(2) and not B(2);
	Ig2 <= A(2) xnor B(2);
	Bm2 <= not A(2) and B(2);
	
	Am1 <= A(1) and not B(1);
	Ig1 <= A(1) xnor B(1);
	Bm1 <= not A(1) and B(1);
	
	Am0 <= A(0) and not B(0);
	Ig0 <= A(0) xnor B(0);
	Bm0 <= not A(0) and B(0);
	
	AmTot <= Am3 or (Ig3 and Am2) or (Ig3 and Ig2 and Am1) or (Ig3 and Ig2 and Ig1 and Am0);
	IgTot <= Ig3 and Ig2 and Ig1 and Ig0;
	BmOut <= AmTot nor IgTot;
	
	AmOut <= AmTot;
	IgOut <= IgTot;
--	BmOut <= BmTot;
	
end bit_a_bit;