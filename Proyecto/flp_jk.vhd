library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity flp_jk is

	port(
		-- Input ports
		j, k: in  std_logic;
		clk: in	std_logic;
		
		-- Output ports
		Q: out std_logic
	);
		
end flp_jk;


architecture Behavioral of flp_jk is
	
    signal Q0 : std_logic := '0';

begin

	process(clk) 
	begin
		
		if rising_edge(clk) then 
		
            if j = '0' and k = '0' then
                Q0 <= Q0;
            elsif j = '1' and k = '0' then
                Q0 <= '1';
            elsif j = '0' and k = '1' then
                Q0 <= '0';
            elsif j = '1' and k = '1' then
                Q0 <= not Q0;
            end if;
        end if;

	end process;
	
	Q <= Q0;

end Behavioral;