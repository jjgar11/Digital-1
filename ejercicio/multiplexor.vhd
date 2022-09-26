library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity multiplexor is
	port (
--		s0, s1 : in std_logic;
		S : in std_logic_vector(1 downto 0);
		D : in std_logic_vector(3 downto 0);
--		downto 0 es que el de la izquierda es el mas significativo

		Y : out std_logic
	);
end multiplexor;

architecture Behavioral of multiplexor is
	
	begin
	
--	D0 <= not S(0) and not S(1) and D(0);
--	D1 <= not S(0) and     S(1) and D(1);
--	D2 <=     S(0) and not S(1) and D(2);
--	D3 <=     S(0) and     S(1) and D(3);
--	
--	Y <= D0 or D1 or D2 or D3;
	
--	with s select
--	Y 	<= 	D(0) when "00",
--				D(1) when "01",
--				D(2) when "10",
--				D(3) when "11";
			
	process(S)
	
	-- All choice expressions in a VHDL case statement must be constant
	-- and unique.	Also, the case statement must be complete, or it must
	-- include an others clause. 
	begin
		case S is
			when "00" => Y <= D(0);
			when "01" => Y <= D(1);
			when "10" => Y <= D(2);
			when others => Y <= D(3);
			
		end case;
	end process;

	
end Behavioral;