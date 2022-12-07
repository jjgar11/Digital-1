LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY driver IS
  GENERIC(
    clk_freq       :  INTEGER    := 125;    --system clock frequency/1E6 Hz!
    display_lines  :  STD_LOGIC  := '1';   --number of display lines (0 = 1-line mode, 1 = 2-line mode)
    character_font :  STD_LOGIC  := '0';   --font (0 = 5x8 dots, 1 = 5x10 dots)
    display_on_off :  STD_LOGIC  := '1';   --display on/off (0 = off, 1 = on)
    cursor         :  STD_LOGIC  := '0';   --cursor on/off (0 = off, 1 = on)
    blink          :  STD_LOGIC  := '0';   --blink on/off (0 = off, 1 = on)
    inc_dec        :  STD_LOGIC  := '1';   --increment/decrement (0 = decrement, 1 = increment)
    shift          :  STD_LOGIC  := '0');  --shift on/off (0 = off, 1 = on)
  PORT(
    clk        : IN   STD_LOGIC;                     --system clock
    reset_n    : IN   STD_LOGIC;                     --active low reinitializes lcd
    lcd_enable : IN   STD_LOGIC;                     --latches data into lcd controller
    lcd_bus    : IN   STD_LOGIC_VECTOR(9 DOWNTO 0);  --data and control signals
    busy       : OUT  STD_LOGIC := '1';              --lcd controller busy/idle feedback
    rw, rs, e  : OUT  STD_LOGIC;                     --read/write, setup/data, and enable for lcd
    lcd_data   : OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)); --data signals for lcd
END driver;

ARCHITECTURE controller OF driver IS
  TYPE CONTROL IS(power_up, initialize, ready, send);
  SIGNAL  state  : CONTROL;
BEGIN
  PROCESS(clk)
    VARIABLE clk_count : INTEGER := 0; --event counter for timing
  BEGIN
    IF(clk'EVENT and clk = '1') THEN
      CASE state IS
        --wait 50 ms to ensure Vdd has risen and required LCD wait is met (secuencial). tiempo de espera para el encendido (TOTAL=50ms)
        WHEN power_up =>
          busy <= '1';
      IF(clk_count < (50000 * clk_freq)) THEN    --wait 50 ms
  --        IF(clk_count < 25) THEN
            clk_count := clk_count + 1;
            state <= power_up;
          ELSE                                       --power-up complete
            clk_count := 0;
            rs <= '0';
            rw <= '0';
            lcd_data <= "00110000";  
            state <= initialize;
          END IF;
          
        --cycle through initialization sequence  (secuencial) Serie de instrucciones para lcd_data con tiempos de espera (TOTAL=2.2ms)
        WHEN initialize =>
          busy <= '1';
          clk_count := clk_count + 1;
      IF(clk_count < (10 * clk_freq)) THEN       --function set
   --     IF(clk_count <2) THEN  
            lcd_data <= "0011" & display_lines & character_font & "00";
            e <= '1';
            state <= initialize;
       ELSIF(clk_count < (60 * clk_freq)) THEN    --wait 50 us
    --      ELSIF(clk_count<6) THEN
            lcd_data <= "00000000"; 
            e <= '0';
            state <= initialize;
      ELSIF(clk_count < (70 * clk_freq)) THEN    --display on/off control
     --    ELSIF(clk_count<7) THEN     
            lcd_data <= "00001" & display_on_off & cursor & blink;
            e <= '1';
            state <= initialize;
      ELSIF(clk_count < (120 * clk_freq)) THEN   --wait 50 us
     --    ELSIF(clk_count<12) THEN
            lcd_data <= "00000000";
            e <= '0';
            state <= initialize;
      ELSIF(clk_count < (130 * clk_freq)) THEN   --display clear
     --   ELSIF(clk_count<13) THEN 
            lcd_data <= "00000001";
            e <= '1';
            state <= initialize;
      ELSIF(clk_count < (2130 * clk_freq)) THEN  --wait 2 ms
    --      ELSIF(clk_count < 21) THEN
            lcd_data <= "00000000";
            e <= '0';
            state <= initialize;
    ELSIF(clk_count < (2140 * clk_freq)) THEN  --entry mode set
    --   ELSIF(clk_count <24) THEN 
           lcd_data <= "000001" & inc_dec & shift;
            e <= '1';
            state <= initialize;
    ELSIF(clk_count < (2200 * clk_freq)) THEN  --wait 60 us
       --   ELSIF(clk_count <26) THEN 
            lcd_data <= "00000000";
            e <= '0';
            state <= initialize;
          ELSE                                       --initialization complete
            clk_count := 0;
            busy <= '0';
            state <= ready;
          END IF;    
       
        --wait for the enable signal and then latch in the instruction (no secuencial) DECODER
        --Almacena rs,rw y lcd_data si lcd_enable esta encendido
        WHEN ready =>
          IF(lcd_enable = '1') THEN
            busy <= '1';
            rs <= lcd_bus(9);
            rw <= lcd_bus(8);
            lcd_data <= lcd_bus(7 DOWNTO 0);
            clk_count := 0;            --? no hace falta
            state <= send;
          ELSE
            busy <= '0';
            rs <= '0';
            rw <= '0';
            lcd_data <= "00000000";
            clk_count := 0; --? no hace falta
            state <= ready;
          END IF;
        
        --send instruction to lcd (secuencial). Activa el enable  (TOTAL=50us)
        WHEN send =>
          busy <= '1';
      IF(clk_count < (50 * clk_freq)) THEN       --do not exit for 50us
    --      IF(clk_count < 5) THEN
               IF(clk_count < clk_freq) THEN            --negative enable
    --       IF(clk_count < 2) THEN 
                    e <= '0';
              ELSIF(clk_count < (14 * clk_freq)) THEN    --positive enable half-cycle
      --    ELSIF(clk_count <3) THEN  
                     e <= '1';
               ELSIF(clk_count < (27 * clk_freq)) THEN    --negative enable half-cycle
       --   ELSIF(clk_count <4) THEN   
              e <= '0';
            END IF;
            clk_count := clk_count + 1;
            state <= send;
          ELSE
            clk_count := 0;
            state <= ready;
          END IF;

      END CASE;    
      --reset
      IF(reset_n = '0') THEN
          state <= initialize; --podría ser power_up jmmm... pero solo quiero borrado...
      END IF;
    
    END IF;
  END PROCESS;
END controller;

