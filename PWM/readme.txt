Antes de comenzar por favor lea el siguiente documento.

El programa se divide en dos partes:
	- El sistema anti-rebote.
	- El PWM.
	
A su vez, el sistema anti-rebote lo conforma:
	- El divisor de frecuencia (div_frec). [1]
	- El registro de desplazamiento (anti_rebote). [2]
	
Y el PWM está conformado por:
	- El módulo de modificación de tau (Modulador). [3]
	- El módulo de la señal de salida PWM (senal_PWM). [4]

Ambos componentes se integran en el módulo principal (PWM). [5]

Revise los archivos en el mismo orden en el que se presentan.

Para la simulación 
	- No incluya el sistema antirrebote.
	- No utilice una frecuencia tan alta para la señal de reloj del registro de conteo, ya que se podría 
	  bloquear el simulador. Tenga en cuenta que la escala de tiempo es del orden de los segundos.

Para la implementación en la FPGA
	- Mediante prueba y error elija el tamaño del registro y la frecuencia de muestreo, de tal manera que 
	  no se necesite presionar durante mucho tiempo el pulsador para enviar la señal de estado activo o cerrado.