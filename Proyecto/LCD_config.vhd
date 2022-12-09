library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity LCD_config is

	port(
		clk : in std_logic;
		epConfig : in integer;
		e_out,rs_out : out std_logic;
		datos_out : out  std_logic_vector(7 downto 0)
	);

end LCD_config;


architecture Behavioral of LCD_config is

	type estados is (e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19,e20,e21,e22,e23,e24,
							e25,e26,e27,e28,e29,e30,e31,e32,e33,e34,e35,e36,e37,e38,e39,e40,e41,e42,e43,e44,e45,e46,
							e47,e48,e49,e50,idle);
	signal ep : estados := e0; 	--Estado Presente
	signal ef : estados := e0; 		--Estado Siguiente

	signal e,rs : std_logic;
	signal datos : std_logic_vector(7 downto 0);
	signal reg_state : integer := 1;
	
begin

	process(epConfig,ep)
	begin
	
	case ep is

		when e0 =>
			datos <= x"38";
			e <= '1';
			rs <= '0';
			ef <= e1;
			reg_state <= epConfig;
			
		when e1 =>
			e <= '0';
			ef <= e2;
			--
		when e2 =>
			datos <= x"01";
			e <= '1';
			rs <= '0';
			ef <= e3;
			
		when e3 =>
			e <= '0';
			ef <= e4;
			
		when e4 =>
			datos <= x"0E";
			e <= '1';
			rs <= '0';
			ef <= e5;
			
		when e5 =>
			e <= '0';
			ef <= e6;
			
		when e6 =>
			if epConfig = 1 then
				ef <= e7;          --Config
			elsif epConfig = 2 then
				ef <= e20;         --Select
			elsif epConfig = 3 then
				ef <= e33;         --OK
			elsif epConfig = 4 then
				ef <= e38;         --Tiempo
			elsif epConfig = 5 then
				ef <= e38;
			elsif epConfig = 6 then
				ef <= e33;
			end if;
		
		--Config
		when e7 =>
			datos <= x"43"; --C
			e <= '1';
			rs <= '1';
			ef <= e8;			
		when e8 =>
			e <= '0';
			ef <= e9;
			
		when e9 =>
			datos <= x"6F"; --o
			e <= '1';
			rs <= '1';
			ef <= e10;			
		when e10 =>
			e <= '0';
			ef <= e11;
			
		when e11 =>
			datos <= x"6E"; --n
			e <= '1';
			rs <= '1';
			ef <= e12;			
		when e12 =>
			e <= '0';
			ef <= e13;
			
		when e13 =>
			datos <= x"66"; --f
			e <= '1';
			rs <= '1';
			ef <= e14;			
		when e14 =>
			e <= '0';
			ef <= e15;
			
		when e15 =>
			datos <= x"69"; --i
			e <= '1';
			rs <= '1';
			ef <= e16;
		when e16 =>
			e <= '0';
			ef <= e17;
			
		when e17 =>
			datos <= x"67"; --g
			e <= '1';
			rs <= '1';
			ef <= e18;
		when e18 =>
			e <= '0';
			ef <= idle;
		
		--Select
		when e20 =>
			datos <= x"53"; --S
			e <= '1';
			rs <= '1';
			ef <= e21;
		when e21 =>
			e <= '0';
			ef <= e22;
			
		when e22 =>
			datos <= x"65"; --e
			e <= '1';
			rs <= '1';
			ef <= e23;
		when e23 =>
			e <= '0';
			ef <= e24;
			
		when e24 =>
			datos <= x"6C"; --l
			e <= '1';
			rs <= '1';
			ef <= e25;
		when e25 =>
			e <= '0';
			ef <= e26;
			
		when e26 =>
			datos <= x"65"; --e
			e <= '1';
			rs <= '1';
			ef <= e27;
		when e27 =>
			e <= '0';
			ef <= e28;
			
		when e28 =>
			datos <= x"63"; --c
			e <= '1';
			rs <= '1';
			ef <= e29;
		when e29 =>
			e <= '0';
			ef <= e30;
			
		when e30 =>
			datos <= x"74"; --t
			e <= '1';
			rs <= '1';
			ef <= e31;
		when e31 =>
			e <= '0';
			ef <= idle;
			
		--OK
		when e33 =>
			datos <= x"4F"; --O
			e <= '1';
			rs <= '1';
			ef <= e34;
		when e34 =>
			e <= '0';
			ef <= e35;
			
		when e35 =>
			datos <= x"4B"; --K
			e <= '1';
			rs <= '1';
			ef <= e36;
		when e36 =>
			e <= '0';
			ef <= idle;
			
		--Tiempo
		when e38 =>
			datos <= x"54"; --T
			e <= '1';
			rs <= '1';
			ef <= e39;
		when e39 =>
			e <= '0';
			ef <= e40;
			
		when e40 =>
			datos <= x"69"; --i
			e <= '1';
			rs <= '1';
			ef <= e41;
		when e41 =>
			e <= '0';
			ef <= e42;
			
		when e42 =>
			datos <= x"65"; --e
			e <= '1';
			rs <= '1';
			ef <= e43;
		when e43 =>
			e <= '0';
			ef <= e44;
			
		when e44 =>
			datos <= x"6D"; --m
			e <= '1';
			rs <= '1';
			ef <= e45;
		when e45 =>
			e <= '0';
			ef <= e46;
			
		when e46 =>
			datos <= x"70"; --p
			e <= '1';
			rs <= '1';
			ef <= e47;
		when e47 =>
			e <= '0';
			ef <= e48;
			
		when e48 =>
			datos <= x"6F"; --o
			e <= '1';
			rs <= '1';
			ef <= e49;
		when e49 =>
			e <= '0';
			ef <= idle;
		
		when idle =>
			if reg_state /= epConfig then
				ef <= e0;
			else
				ef <= idle;
			end if;
			
		
		when others =>
			ef <= e0;

	end case;
	
	
	

	
	

	end process;

	process(clk)
	begin
		if rising_edge(clk) then
			ep <= ef;
		end if;
	end process;

	e_out <= e;
	rs_out <= rs;
	datos_out <= datos;

end Behavioral;