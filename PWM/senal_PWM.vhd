library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity senal_pwm is

	-- * Cree las señales de entrada y salida.
	port(
		tau : in integer;
		T : in integer;
		clk : in std_logic;
	
		pwm : out std_logic
	);
		
end senal_pwm;


architecture ciclo_trabajo of senal_pwm is

	-- * Diseñe la arquitectura de la entidad.
	
	-- Recuerde que este módulo entrega como salida la señal de pwm dado un cierto ciclo de trabajo.
	
	-- Pista: Su diseño es muy parecido al del divisor de frecuencia.
    
    signal cuenta : natural range 1 to 10;

    begin

        process(clk)
        begin
            
            if rising_edge(clk) then
                if cuenta >= T then
                    cuenta <= 1;
                else
                    cuenta <= cuenta + 1;
                end if;
            end if;

        end process;
        pwm <= '1' when cuenta <= tau else '0';

end ciclo_trabajo;