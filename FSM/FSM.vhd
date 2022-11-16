library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity FSM is
	port(
		-- input ports
		clk : in std_logic;
		nSentido : in std_logic;
		nSpeed : in std_logic;

		-- output ports
		enable : out std_logic_vector(3 downto 0);
		segmento_siete : out std_logic_vector(7 downto 0);
		Led_conteo : out std_logic
	);

end FSM;

architecture Behavioral of FSM is

	signal Sentido : std_logic;
	signal Speed : std_logic;
	
	signal nclk,clk_segment,clk_rebote: std_logic := '1';
	signal codbcd0,codbcd1,codbcd2,codbcd3 : std_logic_vector(2 downto 0) := "000";
	--signal ar_Sentido,ar_Speed : std_logic := '0';

	
	component div_frec
		port(
			clk: in  std_logic;
			Nciclos: in	integer;
			
			f: out std_logic
		);
	end component;
	
	--component anti_rebote
	--	port(
	--		clk : in std_logic;
	--		Button : in std_logic;
	--		isOn : out std_logic
	--	);
	--end component;
	
	component DispSeg
		port( 
		clk: in std_logic;
		code0,code1,code2,code3: in std_logic_vector(2 downto 0); -- Slide Switch
		
		digit: out std_logic_vector(3 downto 0); -- Enable 4 digit
		Siete_Seg: out std_logic_vector(7 downto 0) -- 7 Segments and Dot LEDs
		); 
	end component;
	
	component PruebaFSM
		port(
		clk : in std_logic;
		s, d : in std_logic;
		
		out1,out2,out3,out4 : out std_logic_vector(2 downto 0)
		);
	end component;

begin

	Sentido <= not nSentido;
	Speed <= not nSpeed;

	-- * En simulacion
	-- clk <= not clk after ClockPeriod / 2;

	div_1Hz : div_frec
	-- port map(clk,25e3,nclk);
	port map(clk,25e6,nclk);
	
	div_pulsador : div_frec
	-- port map(clk,5e3,clk_rebote);
	port map(clk,50e4,clk_rebote);

	div_sietesegmetos : div_frec
	port map(clk,5e4,clk_segment);
	
	--reboteSentido: anti_rebote
	--port map(clk_rebote,Sentido,ar_Sentido);
	
	--reboteSpeed : anti_rebote
	--port map(clk_rebote,Speed,ar_Speed);
	
	states : PruebaFSM
	port map(nclk,Speed,Sentido,codbcd0,codbcd1,codbcd2,codbcd3);
	
	nixie : DispSeg
	port map(clk_segment,codbcd0,codbcd1,codbcd2,codbcd3,enable,segmento_siete);
	
	Led_conteo <= not nclk;

end Behavioral;