library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity reset_mod is

	port(
		Reset : in std_logic;
        clk : in std_logic;
		ext_reset : out std_logic
	);
		
end reset_mod;


architecture Behavioral of reset_mod is
	
    signal reg : std_logic_vector(24 downto 0);

begin

	process(clk)
	begin

		if rising_edge(clk) then
			if Reset = '1' then
				reg <= (others => Reset);
			else
				reg <= reg(23 downto 0) & '0';
			end if;
		end if;

	end process;

	ext_reset <= reg(24);
	
end Behavioral;