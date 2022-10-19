library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity bin_bcd is

	port(
		-- Input ports
		clk: in  std_logic;
		binario: in  std_logic_vector(5 downto 0);

		-- Output ports
		bcd0, bcd1: out std_logic_vector(3 downto 0)
	);
		
end bin_bcd;


architecture Behavioral of bin_bcd is

	signal bcdsig0: std_logic_vector(7 downto 0) := "00000000";
	signal sum: std_logic := '0';
	signal index: integer range 0 to 6 := 6;
	signal binario_reg: std_logic_vector(5 downto 0) := "000000";
	
begin

	process(clk) 
	begin
		
		if rising_edge(clk) then 
			if binario_reg /= binario then
				index <= 6;
				binario_reg <= binario;
				bcdsig0 <= "00000000";
				sum <= '0';
			end if;
			
			if  (bcdsig0(3 downto 0) > 4) and (sum = '0') and (index > 0) then
				bcdsig0 <= bcdsig0 + 3;
				sum <= '1';
			else
				if index > 0  then
			
				bcdsig0 <= bcdsig0(6 downto 0) & binario(index-1);	
								
				index <= index - 1;
				
				sum <= '0';

				end if;
			end if;
			
			
		end if;

	end process;
	
	bcd0 <= bcdsig0(3 downto 0);
	bcd1 <= bcdsig0(7 downto 4);

end Behavioral;