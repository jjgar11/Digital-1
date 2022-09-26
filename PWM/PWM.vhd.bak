library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Calculadora is

	port(
--		input ports
		An, Bn : in std_logic_vector(2 downto 0);
		Sn: in std_logic;
--		output ports
		RES : out std_logic_vector(3 downto 0);
		NEG : out std_logic
	);

end Calculadora;

architecture Behavioral of Calculadora is

--	Declaracion de sumador completo de un solo bit
	component Sumador
		port(
--			input ports
			A, B, CAnt : in std_logic;
--    	output ports
			Res, CSig : out std_logic
		);
	end component;
	
--	Declaracion de sumador de un solo bit especial para el complemento 
	component Sumador_Parcial
		port(
--			input ports
			A, CAnt : in std_logic;
--    	output ports
			Res, CSig : out std_logic
		);
	end component;
	
	signal A, B : std_logic_vector(2 downto 0);
	signal S : std_logic;
	
	signal Ss : std_logic_vector(2 downto 0); 	-- Vector de 3 bits de valor S
	signal BComp : std_logic_vector(2 downto 0);	-- B lista para ser sumada o restada
	
	signal CSum	: std_logic_vector(1 downto 0);	-- Carry de la suma
	signal RSum : std_logic_vector(3 downto 0);	-- Resultado de la suma
	
	signal AMayor : std_logic;				-- 1 si A es mayor que B
	
	signal RestaNegativa : std_logic;	-- 1 si hay que restar y si B es mayor que A
	signal RestasNegativas : std_logic_vector(3 downto 0);	-- Vector del mismo valor
	
--	Componente a 1 del resultado en caso de resta con resultado negativo
	signal Comp1: std_logic_vector(3 downto 0);
	signal CResN : std_logic_vector(2 downto 0);		-- Carry de la suma de comp a 2
	
	signal Result : std_logic_vector(3 downto 0);	-- Resultado final
	
	begin
	
		A <= not An;
		B <= not Bn;
		S <= not Sn;
	
--		Se hace un vector de valores de S
		Ss <= (others => S);
--		Si S=0 entonces BComp es igual a B pero si S=1 BComp es el comp a 1
		BComp <= B xor Ss;
	
--		Si es resta se pasa S=1 en el carry inicial para terminal el comp a 2
--		Si es suma se pasa S=0 en el carry inicial y se suma A con B sin cambiar
		SUM0 : Sumador
		port map(A(0),BComp(0),S,RSum(0),CSum(0));
		SUM1 : Sumador
		port map(A(1),BComp(1),CSum(0),RSum(1),CSum(1));
		SUM2 : Sumador
		port map(A(2),BComp(2),CSum(1),RSum(2),RSum(3));

--		Indicador de que es una resta con resultado negativo y vector con este valor
		RestaNegativa <= not RSum(3) and S;
		RestasNegativas <= (others => RestaNegativa);
		
--		Si es resta con res. negativo se hace comp a 1 al resultado
--		Si no el resultado se mantiene igual
		Comp1 <= RSum xor RestasNegativas;
		
--		Si es resta con res. negativo se suma 1 para comp a 2
--		Si no se suma con 0000 y el resultado permanece igual
		RESN0 : Sumador_Parcial
		port map(Comp1(0),RestaNegativa,Result(0),CResN(0));
		RESN1 : Sumador_Parcial
		port map(Comp1(1),CResN(0),Result(1),CResN(1));
		RESN2 : Sumador_Parcial
		port map(Comp1(2),CResN(1),Result(2),CResN(2));
		RESN3 : Sumador_Parcial
		port map(Comp1(3),CResN(2),Result(3));
		
--		Se asignan el resultado a la salida
		RES(0) 	<= not Result(0);
		RES(1) 	<= not Result(1);
		RES(2) 	<= not Result(2);
--		Si S=1 (resta) el ultimo bit se anula
		RES(3) 	<= not (Result(3) and not S);
		NEG 		<= not RestaNegativa;

end Behavioral;
