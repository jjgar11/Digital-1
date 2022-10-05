library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity anti_rebote is

	port(
		clk : in std_logic;
		Button : in std_logic;
		isOn : out std_logic
	);

		
end anti_rebote;


architecture Behavioral of anti_rebote is

	signal reg : std_logic_vector(5 downto 0) := "000000";

begin

	process(clk)
	begin
        
		if rising_edge(clk) then
			reg <= reg(4 downto 0) & Button;
		end if;

	end process;

	isOn <= not reg(5) and not reg(4) and not reg(3) and reg(2) and reg(1) and reg(0);

end Behavioral;