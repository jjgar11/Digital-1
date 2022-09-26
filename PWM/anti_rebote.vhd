library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- Recordando el diseño del registro de desplazamiento se necesita de entrada una señal de reloj 
-- para hacer el muestreo del pulsador, la señal del pulsador y de salida la señal limpia del pulsador

-- * Construya la entidad con las señales de entrada y salida requeridas.

entity anti_rebote is

		
end anti_rebote;


architecture registro of anti_rebote is

	-- * Declare una señal vector de longitud mayor a 3 bits (este será el registro de desplazamiento).

begin

	-- * Coloque en la lista sensibles las señales que ejecutarían el bloque process.
--	process()
	
	
		-- Un desplazamiento en un registro se puede realizar con el operador de concatenación &. 
		-- Por ejemplo si tiene un vector (registro) de 3 posiciones y quiere realizar un corrimiento hacia 
		-- la izquierda incluyendo un valor en la primera posicion, debe proceder de la siguiente manera:
		-- reg <= reg(1 downto 0) & btn;
		
		-- * Cree un condicional que se ejecute por flanco de subida de su señal de reloj. Dentro de este cree
		-- el registro de desplazamiento (recuerde considerar la lógica negativa de la tarjeta). 
				
		-- Para definir la salida de acuerdo a los valores almacenados en el registro tiene dos opciones,
		-- la sentencia if-then o su análoga when-else.
		-- * Utilice la de su preferencia y modifíquela de acuerdo a sus necesidades.
		
	-- Sentencia secuencial if-then:
		
--		if reg = "111" then
--			bto <= '1';
--		else
--			bto <= '0';
--		end if;
	
--	end process;
	
-- Sentencia concurrente análoga when-else :

--	bto <= '1' when reg = "111" else '0';

end registro;