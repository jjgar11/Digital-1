library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity PWM is

	port(
		-- input ports
		Up : in std_logic;
		Down : in std_logic;
		-- clk : in std_logic;

		-- output ports
		led : out std_logic
	);

end PWM;

architecture Behavioral of PWM is

	component senal_PWM
		port(
			tau : in integer;
			T : in integer;
			clk : in std_logic;
		
			pwm : out std_logic
		);
	end component;
	
	signal cuenta : integer range 1 to 25000;
	signal cuenta2 : integer range 1 to 10;

	constant ClockFrequency : integer := 50e6; -- 50 MHz
    constant ClockPeriod    : time    := 1000 ms / ClockFrequency;
	constant T : integer := 10;
 
    signal clk : std_logic := '1';
	signal nclk : std_logic := '1';
	signal sled : std_logic := '1';
	signal tau : integer := 2;
	
	begin

		clk <= not clk after ClockPeriod / 2;

		SUM0 : senal_PWM
		port map(tau,T,nclk,sled);
		
		process(clk, nclk)
		begin
			if rising_edge(clk) then
				if cuenta = 25000 then
					nclk <= not nclk;
					cuenta <= 1;
				else
					cuenta <= cuenta + 1;
				end if;
			end if;
			-- if rising_edge(nclk) then
				-- if cuenta2 = 10 then
				-- 	cuenta2 <= 1;
				-- 	sled <= not sled;
				-- else
				-- 	cuenta2 <= cuenta2 + 1;
				-- end if;
				-- if cuenta2 = t then
				-- 	sled <= not sled;
				-- end if;
			-- end if;


		end process;
		led <= sled;

end Behavioral;
