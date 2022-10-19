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

	signal flp : std_logic_vector(5 downto 0) := "000000";
	signal limit : std_logic;
	signal Reset_vec : std_logic_vector(5 downto 0);

begin
	limit <= flp(5) and flp(4) and flp(3) and flp(1) and flp(0);
	Reset_vec <= (others => Reset);

	process(clk)
	begin

		if rising_edge(clk) then
			flp(0) <= (not flp(0));
			flp(1) <= flp(1) xor (flp(0));
			flp(2) <= limit xor (flp(2) xor (flp(0) and flp(1)));
			flp(3) <= limit xor (flp(3) xor (flp(0) and flp(1) and flp(2)));
			flp(4) <= limit xor (flp(4) xor (flp(0) and flp(1) and flp(2) and flp(3)));
			flp(5) <= limit xor (flp(5) xor (flp(0) and flp(1) and flp(2) and flp(3) and flp(4)));
		end if;

	end process;

	bin_cuenta <= flp and not Reset_vec;

end Behavioral;