library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ejercicio is
	port (
		S : in std_logic_vector(1 downto 0);
		D : in std_logic_vector(3 downto 0);
--		downto 0 es que el de la izquierda es el mas significativo

		Z : out std_logic_vector(3 downto 0)
	);
end ejercicio;

architecture seleccion of ejercicio is
	
	component multiplexor
	port (
--		s0, s1 : in std_logic;
		S : in std_logic_vector(1 downto 0);
		D : in std_logic_vector(3 downto 0);
--		downto 0 es que el de la izquierda es el mas significativo

		Y : out std_logic
	);
	end component;
	
	component demultiplexor
	port (
--		s0, s1 : in std_logic;
		S : in std_logic_vector(1 downto 0);
		Y : in std_logic;
		
--		downto 0 es que el de la izquierda es el mas significativo

		Z : out std_logic_vector(3 downto 0)
	);
	end component;
	
	signal Y : std_logic;
	
begin
	
	mux : multiplexor
	port map(S,D,Y);
	
	demux : demultiplexor
	port map(S,Y,Z);
	
	
end seleccion;