library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity senal_contador is

	port(
		clk : in std_logic;
		Reset : in std_logic;
		bin_cuenta : out std_logic_vector(5 downto 0)
	);

		
end senal_contador;


architecture Behavioral of senal_contador is

	signal flp_1 : std_logic := '0';
	signal flp_2 : std_logic := '0';
	signal flp_3 : std_logic := '0';
	signal flp_4 : std_logic := '0';
	signal flp_5 : std_logic := '0';
	signal flp_6 : std_logic := '0';

begin

	process(clk)
	begin
        
		if rising_edge(clk) then
			flp_1 <= not flp_1;
            flp_2 <= flp_2 xor (flp_1);
            flp_3 <= flp_3 xor (flp_1 and flp_2);
            flp_4 <= flp_4 xor (flp_1 and flp_2 and flp_3);
            flp_5 <= flp_5 xor (flp_1 and flp_2 and flp_3 and flp_4);
            flp_6 <= flp_6 xor (flp_1 and flp_2 and flp_3 and flp_4 and flp_5);
		end if;

	end process;

    bin_cuenta <= flp_6 & flp_5 & flp_4 & flp_3 & flp_2 & flp_1; 

end Behavioral;