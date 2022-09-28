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
		clk : in std_logic;
		Up : in std_logic;
		Down : in std_logic;
		tau : in integer range 0 to 10;

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
	
	process(clk)
	begin

		if rising_edge(clk) then
			if Up = '1' and tau < 10 then
				ntau <= (tau + 2);
			end if;
			if Down = '1' and tau > 0 then
				ntau <=  (tau - 2);
			end if;
		end if;

	end process;

	tau_mod <= ntau;
	
end Modtau;