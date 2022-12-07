LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY control_lcd IS
  PORT(
      clk       : IN  STD_LOGIC;  --system clock
      lcd_busy : IN STD_LOGIC;
      lcd_enable : INOUT STD_LOGIC:='0';  
      lcd_reset: OUT std_logic:='1'; --activo en bajo
      lcd_bus: OUT std_logic_vector(9 downto 0);
      en_teclado: IN std_logic;
      tecla: IN std_logic_vector(3 downto 0)
      ); --data signals for lcd
END control_lcd;

ARCHITECTURE behavior OF control_lcd IS
    
COMPONENT divisor is
    port ( clk,rst:  in std_logic;
           T: in std_logic_vector(27 downto 0);
           q: out std_logic --1Hz pulse
           );
end component  divisor;

  signal clkdiv: std_logic;
  type states is (welcome,welcome_moving,options,s3,s4);
  signal state: states:=Welcome;
  type tstring is array(natural range<>) of character;
  constant Nmsj1: natural:=29;
  constant msj1: tstring(0 to Nmsj1-1):= "Bienvenido al restaurante H&S";
  constant Nmsj12:natural:=15;
  constant msj12: tstring(0 to Nmsj12-1):= "Haz tu pedido! ";
  constant Nfood:natural:=17;
  constant msj21: tstring(0 to Nfood-1):= "Elige la opcion: ";
  constant msj22: tstring(0 to Nfood-1):= "1)Hamburguesa    ";
  constant msj23: tstring(0 to Nfood-1):= "2)Pizza          ";
  constant msj24: tstring(0 to Nfood-1):= "3)Perro Caliente "; 
  constant msj25: tstring(0 to Nfood-1):= "4)Enviar         "; 
  constant msj26: tstring(0 to Nfood-1):= "5)Salir          ";
  constant Ncant:natural:=10;
  constant msj31: tstring(0 to Ncant-1):= "Cantidad: ";
  constant msj32: tstring(0 to Nfood-1):= "Espera a tu turno";
  constant msj33: tstring(0 to 1):= ":)";
  constant msj34: tstring(0 to Nfood-1):= "Recoge tu pedido!";
BEGIN

--que borrar pantalla sea un estado aparte

process(clk)
    VARIABLE numchar: INTEGER:= 0; --Nmsj2 es la cadena más larga
    constant per: integer:=125000000; --tiempo de espera para el estado s2
    begin
    if (clk'event and clk='1') then
        case state is 
            when Welcome=> --primeros mensajes
                state<=Welcome;
                if (lcd_busy='0' and lcd_enable='0') then     --se necesita obligatoriamente realimentación con lcd_enable para poder seguir enviando caracteres
                            lcd_enable<='1'; --se puede reducir
                            --falta poner función para borrar pantalla y reseteo (si se puede)
                            --arreglo que almacene los 3 valores de la cantidad por cada comida (se inicializan en 0) 
                            if numchar<Nmsj1 then --mensaje 1
                                lcd_bus <= "10"&std_logic_vector(to_unsigned(character'pos(msj1(numchar)),8));
                            elsif numchar=Nmsj1 then
                                lcd_bus<="0011000001"; --posiciona en la 2 linea, 1 columna
                            elsif numchar<(Nmsj1+Nmsj12) then         --mensaje 2
                                lcd_bus <= "10"&std_logic_vector(to_unsigned(character'pos(msj12(numchar-(Nmsj1+1))),8));
                            elsif numchar=(Nmsj1+Nmsj12) then
                                lcd_bus<="0011010111"; --poscion especfica ddram 
                            elsif numchar<(Nmsj1+2*Nmsj12) then 
                                lcd_bus<="10"&std_logic_vector(to_unsigned(character'pos(msj12(numchar-(Nmsj1+Nmsj12+1))),8));    
                            else
                                state<=Welcome_moving;
                                lcd_enable<='0';
                            end if;
                            numchar:=numchar+1;
                else
                    lcd_enable<='0';
                end if;
            when Welcome_moving=>--efecto 
                -- state<=Welcome_moving;
                -- IF rising_edge(clkdiv) or clkdiv='1' then
                --     if(lcd_busy='0' and lcd_enable='0') then     --se necesita obligatoriamente realimentación con lcd_enable para poder seguir enviando caracteres
                --             lcd_enable<='1';
                --             lcd_bus<="0000011100";
                --     end if;
                -- else 
                --   lcd_enable<='0';
                -- end if;
                if en_teclado='1' then
                    state<=options;
                    numchar:=-2;
                end if;                   
            when options=>--opciones
                state<=options;
                lcd_reset<='1';
                if (lcd_busy='0' and lcd_enable='0') then     --se necesita obligatoriamente realimentación con lcd_enable para poder seguir enviando caracteres
                            lcd_enable<='1';
                            if  numchar=-2 then --limpia
                                lcd_bus<="0000000001"; --hacer función con estas dos opciones!
                            elsif numchar=-1 then--reseteo
                                lcd_reset<='0';
                            elsif numchar<Nfood then --mensaje parte superior
                                lcd_bus <= "10"&std_logic_vector(to_unsigned(character'pos(msj21(numchar)),8));
                            elsif numchar=Nfood then 
                                lcd_bus<="0011000000"; --posiciona en la 2 linea, 1 columna
                            elsif numchar<(2*Nfood) then --hamburguesa
                                lcd_bus<="10"&std_logic_vector(to_unsigned(character'pos(msj22(numchar-(Nfood+1))),8));
                            elsif numchar<per then --espera
                                lcd_enable<='0';
                            elsif numchar=per then --posiciona
                                lcd_bus<="0011000000";
                            elsif numchar<(Nfood+per) then --pizza
                                lcd_bus<="10"&std_logic_vector(to_unsigned(character'pos(msj23(numchar-(per+1))),8));
                            elsif numchar<2*per then
                                lcd_enable<='0';
                            elsif numchar=2*per then --posiciona
                                lcd_bus<="0011000000";
                            elsif numchar<(Nfood+2*per) then --perro
                                lcd_bus<="10"&std_logic_vector(to_unsigned(character'pos(msj24(numchar-(2*per+1))),8)); 
                            elsif numchar<3*per then --espera
                                lcd_enable<='0';
                            elsif numchar=3*per then --posiciona
                                lcd_bus<="0011000000";
                            elsif numchar<(Nfood+3*per) then --enviar
                                lcd_bus<="10"&std_logic_vector(to_unsigned(character'pos(msj25(numchar-(3*per+1))),8)); 
                            elsif numchar<4*per then --espera
                                lcd_enable<='0';
                            elsif numchar=4*per then --posiciona
                                lcd_bus<="0011000000";
                            elsif numchar<(Nfood+4*per) then --salir
                                lcd_bus<="10"&std_logic_vector(to_unsigned(character'pos(msj26(numchar-(4*per+1))),8));     
                            else
                                numchar:=Nfood-1;   
                                lcd_enable<='0';
                            end if;
                            numchar:=numchar+1;
                else 
                    lcd_enable<='0';
                end if;
                if tecla=x"1" or tecla=x"2" or tecla=x"3" then --si se escoge una opcion, se limpia pantalla
                    lcd_enable<='0';
                    numchar:=-2; --decodificador para cada letra a entero, el valor decodificado de tecla se almacena en una varibale temporal 
                    --esta es el inidice del arreglo .
                    state<=s3; --elsif enter y variable booleana=True
                elsif tecla=x"5" then --salir
                    lcd_enable<='0';
                    state<=Welcome_moving;
                    numchar:=-2;
                end if;
            when s3=>
                    --se pone a 0 el elemento del indice respectivo del arreglo 
                    state<=s3;
                    lcd_reset<='1';
                    --opciones : entradas del teclado
                    if (lcd_busy='0' and lcd_enable='0') then     
                            lcd_enable<='1';
                            if numchar=-2 then --limpia pantalla
                                lcd_bus<="0000000001";
                                numchar:=-1;  
                            elsif numchar=-1 then --resetea
                                lcd_reset<='0';
                                numchar:=0;   
                            elsif numchar<Ncant then --"cantidad:"
                                lcd_bus <= "10"&std_logic_vector(to_unsigned(character'pos(msj31(numchar)),8));
                                numchar:=numchar+1;
                            else                         
                                if en_teclado='1' then
                                    if tecla=x"4" then --enter(E)
                                        state<=options;
                                        numchar:=-2;
                                        --v. boolena
                                    else --digita numeros
                                        -- lcd_bus <= "10"&std_logic_vector(to_unsigned(tecla)); 
                                        --concatenar ascii y convertir a entero!
                                    end if;
                                else
                                    lcd_enable<='0';
                                end if;
                                
                            end if;
                    else
                        lcd_enable<='0';
                    end if;
           when s4=>     
                lcd_enable<='0';
          end case;
  end if;
end process; 
END behavior;
