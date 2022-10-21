library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity senal_contador is

	port(
		clk : in std_logic;
		Reset : in std_logic;
		Run : in std_logic;
		Limit : in std_logic_vector(5 downto 0);
		bin_cuenta : out std_logic_vector(5 downto 0)
	);

end senal_contador;


architecture Behavioral of senal_contador is

	signal flp : std_logic_vector(5 downto 0) := "000000";
	signal cond,j,k : std_logic_vector(5 downto 0) := "000000";
	signal isLimit : std_logic;
	signal Reset_vec : std_logic_vector(5 downto 0);

	component flp_jk
		port(
			-- Input ports
			j, k: in  std_logic;
			clk: in	std_logic;
			
			-- Output ports
			Q: out std_logic
		);
	end component;

begin

	isLimit <= (flp(5) xnor Limit(5)) and (flp(4) xnor Limit(4)) and (flp(3) xnor Limit(3)) and (flp(2) xnor Limit(2)) and (flp(1) xnor Limit(1)) and (flp(0) xnor Limit(0));
	Reset_vec <= (others => (Reset or (isLimit and Run)));

	cond(0) <= Run;
	cond(1) <= Run and (flp(0));
	cond(2) <= Run and ((flp(0) and flp(1)));
	cond(3) <= Run and ((flp(0) and flp(1) and flp(2)));
	cond(4) <= Run and ((flp(0) and flp(1) and flp(2) and flp(3)));
	cond(5) <= Run and ((flp(0) and flp(1) and flp(2) and flp(3) and flp(4)));

	j <= cond and not Reset_vec;
	k <= cond or Reset_vec;

	flp_0 : flp_jk
	port map(j(0),k(0),clk,flp(0));

	flp_1 : flp_jk
	port map(j(1),k(1),clk,flp(1));

	flp_2 : flp_jk
	port map(j(2),k(2),clk,flp(2));

	flp_3 : flp_jk
	port map(j(3),k(3),clk,flp(3));

	flp_4 : flp_jk
	port map(j(4),k(4),clk,flp(4));

	flp_5 : flp_jk
	port map(j(5),k(5),clk,flp(5));

	bin_cuenta <= flp;

end Behavioral;