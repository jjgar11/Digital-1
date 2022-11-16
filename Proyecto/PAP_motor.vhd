library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity PAP_motor is

	port(
		clk : in std_logic;
		St : in std_logic;
		Bin : in std_logic_vector(3 downto 0);
		Bout : out std_logic_vector(3 downto 0)
	);

		
end PAP_motor;


architecture Behavioral of PAP_motor is

    signal cod : std_logic_vector(1 downto 0);
    signal flp : std_logic_vector(1 downto 0);
    signal jk : std_logic_vector(1 downto 0);

    component flp_jk
		port(
			-- Input ports
			j: in  std_logic;
			k: in  std_logic;
			clk: in	std_logic;
			
			-- Output ports
			Q: out std_logic
		);
	end component;

begin
        
    jk(0) <= not St;
    jk(1) <= not St and flp(0);

	flp_0 : flp_jk
	port map(jk(0),jk(0),clk,flp(0));

	flp_1 : flp_jk
	port map(jk(1),jk(1),clk,flp(1));

	process(clk, Bin, flp)
    begin

    case Bin is
        when "0001" => cod <= "00";
        when "0010" => cod <= "01";
        when "0100" => cod <= "10";
        when others => cod <= "11";
    end case;    


    case flp is
        when  "00" => Bout <= "0001";
        when  "01" => Bout <= "0010";
        when  "10" => Bout <= "0100";
        when  others => Bout <= "1000";
    end case;
    


	end process;


end Behavioral;