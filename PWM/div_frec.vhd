library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- El divisor de frecuencia cuenta con la señal de reloj como entrada 
-- y como salida la señal con frecuencia disminuida

entity div_frec is

	port(
		-- Input ports
		clk: in  std_logic;
		Nciclos: in	integer;			-- número de ciclos para la frecuencia deseada
		
		-- Output ports
		f: out std_logic
	);
		
end div_frec;


architecture divisor of div_frec is

	signal cuenta: integer range 1 to 25000000 := 1; -- Para inicializar una señal se usa := valor;
	signal salida: std_logic := '1';
	-- En este caso la señal cuenta la definimos dentro del rango 0 a 25 millones.
	
begin

	-- la lista sensible del bloque process es la que se encuentra entre paréntesis. En esta colocamos las señales 
	-- que queremos que ejecuten el process cuando se presente un cambio en ellas.
	process(clk) 
	begin
	
		-- Para que un conjunto de instrucciones se ejecuten con un flanco de subida se pueden usar las condiciones
		-- rising_edge(clk) o clk = 1 and clk'event.
		-- para que se ejecuten con flanco de bajada se puede usar falling_edge(clk) o clk = 0 and clk'event
		
		if rising_edge(clk) then 
		
			if cuenta = Nciclos then
				salida <= not salida; -- Se niega el valor de la señal salida y se asigna a sí misma.
				cuenta <= 1;
			else
				cuenta <= cuenta + 1; 
			end if;
		end if;
		
		-- Para entender mejor qué está sucediendo puede ver el diagrama RTL que puede encontrar en 
		-- Tools/Netlist Viewers/RTL viewer, aunque para ello primero debe indicar este archivo como top entity y 
		-- ejecutar análisis y síntesis (el archivo anti_rebote puede generar problemas de compilación. Primero 
		-- complete todas la tareas que se le solicitan en dicho archivo antes de proceder como se acaba de indicar).
	
	end process;
	
	f <= salida;

end divisor;