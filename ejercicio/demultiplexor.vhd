library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity demultiplexor is
	port (
--		s0, s1 : in std_logic;
		S : in std_logic_vector(1 downto 0);
		Y : in std_logic;
		
--		downto 0 es que el de la izquierda es el mas significativo

		Z : out std_logic_vector(3 downto 0)
	);
end demultiplexor;

architecture seleccion_demux of demultiplexor is
		
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
			
--	process(s)
	
	-- All choice expressions in a VHDL case statement must be constant
	-- and unique.	Also, the case statement must be complete, or it must
	-- include an others clause. 
--	begin
--		case s is
--			when "00" => z(0) <= Y;
--			when "01" => z(1) <= Y;
--			when "10" => z(2) <= Y;
--			when "11" => z(3) <= Y;
--			
--		end case;

	
		z(0) <= Y when s = "00" else '0';
		z(1) <= Y when s = "01" else '0';
		z(2) <= Y when s = "10" else '0';
		z(3) <= Y when s = "11" else '0';
		
--	end process;
	
end seleccion_demux;