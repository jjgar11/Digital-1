library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity div_frec is

	port(
		-- Input ports
		clk: in  std_logic;
		Nciclos: in	integer;
		
		-- Output ports
		f: out std_logic
	);
		
end div_frec;


architecture Behavioral of div_frec is

	signal cuenta: integer range 1 to 1500e6 := 1;
	signal salida: std_logic := '1';
	
begin

	process(clk) 
	begin
		
		if rising_edge(clk) then 
		
			if cuenta = Nciclos then
				salida <= not salida;
				cuenta <= 1;
			else
				cuenta <= cuenta + 1; 
			end if;
		end if;

	end process;
	
	f <= salida;

end Behavioral;