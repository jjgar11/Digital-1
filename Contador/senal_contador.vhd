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
		bin_cuenta : out std_logic_vector(5 downto 0)
	);

end senal_contador;


architecture Behavioral of senal_contador is

	signal flp : std_logic_vector(5 downto 0) := "000000";
	signal cond : std_logic_vector(5 downto 0) := "000000";
	signal limit : std_logic;
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

	limit <= flp(5) and flp(4) and flp(3) and flp(1) and flp(0);
	Reset_vec <= (others => Reset);

	cond(0) <= Run and ('1');
	cond(1) <= Run and (flp(0));
	cond(2) <= Run and ((flp(0) and flp(1)) and not limit);
	cond(3) <= Run and ((flp(0) and flp(1) and flp(2)) or limit);
	cond(4) <= Run and ((flp(0) and flp(1) and flp(2) and flp(3)) or limit);
	cond(5) <= Run and ((flp(0) and flp(1) and flp(2) and flp(3) and flp(4)) or limit);

	flp_0 : flp_jk
	port map(cond(0),cond(0),clk,flp(0));

	flp_1 : flp_jk
	port map(cond(1),cond(1),clk,flp(1));

	flp_2 : flp_jk
	port map(cond(2),cond(2),clk,flp(2));

	flp_3 : flp_jk
	port map(cond(3),cond(3),clk,flp(3));

	flp_4 : flp_jk
	port map(cond(4),cond(4),clk,flp(4));

	flp_5 : flp_jk
	port map(cond(5),cond(5),clk,flp(5));

	bin_cuenta <= flp and not Reset_vec;

end Behavioral;