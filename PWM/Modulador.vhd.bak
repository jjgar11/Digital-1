library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

--   Si revisó los subcapítulos 7.2 y 7.4 del Floyd 9na edición recuerde que:
--   - Una lectura de flanco la puede realizar un flip-flop o un registro (un conjunto de flip-flops) y el 
--     valor que almacena está representado en VHDL por una señal.
   
--	  En la declaración:

--	  if rising_edge(clk) then
--			a <= b;
--	  end if

--   siendo "a" un vector. "clk" es la señal de reloj del registro y "a" el valor que almacena.

--   - Tenga en cuenta lo siguiente si presenta errores de compilación. Un registro solo puede tener una señal 
--     de reloj, o dicho de otro modo, el valor de un registro solo puede ser representado por una señal.

entity Modulador is

	-- * Cree las señales de entrada y salida del modulador.

	port(
		-- input ports
		Up : in std_logic;
		Down : in std_logic;
		tau : in integer range 0 to 10;
		-- clk : in std_logic;

		-- output ports
		tau_mod : out integer range 0 to 10
	);
		
end Modulador;


architecture Modtau of Modulador is

	-- * Diseñe la arquitectura del modulador. 

	signal ntau : integer range 0 to 10;
	
begin
	
	-- Recuerde que el trabajo del modulador es aumentar o disminuir el valor del ciclo de trabajo a partir de
	-- pulsos de entrada.

	-- Puede usar los operadores matemáticos que necesite. No trabaje con números decimales.

--	ntau <= tau;
	
	process(Up, Down)

	begin
		if rising_edge(Up) then
			if tau = 10 then
				ntau <= 0;
			else 
				ntau <= (tau + 2) mod 10;
			end if;
		end if;

	end process;

	 tau_mod <= ntau;
	
end Modtau;