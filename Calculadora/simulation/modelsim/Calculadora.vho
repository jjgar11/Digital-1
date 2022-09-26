-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 20.1.0 Build 711 06/05/2020 SJ Lite Edition"

-- DATE "09/13/2022 20:15:09"

-- 
-- Device: Altera EP4CE10E22C8 Package TQFP144
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_ASDO_DATA1~	=>  Location: PIN_6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_FLASH_nCE_nCSO~	=>  Location: PIN_8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DCLK~	=>  Location: PIN_12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DATA0~	=>  Location: PIN_13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_nCEO~	=>  Location: PIN_101,	 I/O Standard: 2.5 V,	 Current Strength: 8mA


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_ASDO_DATA1~~padout\ : std_logic;
SIGNAL \~ALTERA_FLASH_nCE_nCSO~~padout\ : std_logic;
SIGNAL \~ALTERA_DATA0~~padout\ : std_logic;
SIGNAL \~ALTERA_ASDO_DATA1~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_FLASH_nCE_nCSO~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_DATA0~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	Calculadora IS
    PORT (
	An : IN std_logic_vector(2 DOWNTO 0);
	Bn : IN std_logic_vector(2 DOWNTO 0);
	Sn : IN std_logic;
	RES : BUFFER std_logic_vector(3 DOWNTO 0);
	NEG : BUFFER std_logic
	);
END Calculadora;

-- Design Ports Information
-- RES[0]	=>  Location: PIN_71,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RES[1]	=>  Location: PIN_70,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RES[2]	=>  Location: PIN_69,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RES[3]	=>  Location: PIN_72,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- NEG	=>  Location: PIN_84,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- An[0]	=>  Location: PIN_60,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Bn[0]	=>  Location: PIN_68,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Bn[1]	=>  Location: PIN_67,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Sn	=>  Location: PIN_65,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- An[1]	=>  Location: PIN_59,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Bn[2]	=>  Location: PIN_66,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- An[2]	=>  Location: PIN_58,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF Calculadora IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_An : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_Bn : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_Sn : std_logic;
SIGNAL ww_RES : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_NEG : std_logic;
SIGNAL \RES[0]~output_o\ : std_logic;
SIGNAL \RES[1]~output_o\ : std_logic;
SIGNAL \RES[2]~output_o\ : std_logic;
SIGNAL \RES[3]~output_o\ : std_logic;
SIGNAL \NEG~output_o\ : std_logic;
SIGNAL \An[0]~input_o\ : std_logic;
SIGNAL \Bn[0]~input_o\ : std_logic;
SIGNAL \RESN0|Res~0_combout\ : std_logic;
SIGNAL \Sn~input_o\ : std_logic;
SIGNAL \An[1]~input_o\ : std_logic;
SIGNAL \SUM0|CSig~0_combout\ : std_logic;
SIGNAL \Bn[1]~input_o\ : std_logic;
SIGNAL \SUM1|Res~combout\ : std_logic;
SIGNAL \An[2]~input_o\ : std_logic;
SIGNAL \Bn[2]~input_o\ : std_logic;
SIGNAL \SUM1|CSig~combout\ : std_logic;
SIGNAL \RestaNegativa~combout\ : std_logic;
SIGNAL \RESN1|Res~2_combout\ : std_logic;
SIGNAL \RESN2|Res~0_combout\ : std_logic;
SIGNAL \RESN2|Res~combout\ : std_logic;
SIGNAL \RES~0_combout\ : std_logic;
SIGNAL \RESN0|ALT_INV_Res~0_combout\ : std_logic;
SIGNAL \ALT_INV_RES~0_combout\ : std_logic;
SIGNAL \RESN1|ALT_INV_Res~2_combout\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_An <= An;
ww_Bn <= Bn;
ww_Sn <= Sn;
RES <= ww_RES;
NEG <= ww_NEG;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\RESN0|ALT_INV_Res~0_combout\ <= NOT \RESN0|Res~0_combout\;
\ALT_INV_RES~0_combout\ <= NOT \RES~0_combout\;
\RESN1|ALT_INV_Res~2_combout\ <= NOT \RESN1|Res~2_combout\;
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: IOOBUF_X32_Y0_N16
\RES[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \RESN0|ALT_INV_Res~0_combout\,
	devoe => ww_devoe,
	o => \RES[0]~output_o\);

-- Location: IOOBUF_X32_Y0_N23
\RES[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \RESN1|ALT_INV_Res~2_combout\,
	devoe => ww_devoe,
	o => \RES[1]~output_o\);

-- Location: IOOBUF_X30_Y0_N2
\RES[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \RESN2|Res~combout\,
	devoe => ww_devoe,
	o => \RES[2]~output_o\);

-- Location: IOOBUF_X32_Y0_N9
\RES[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_RES~0_combout\,
	devoe => ww_devoe,
	o => \RES[3]~output_o\);

-- Location: IOOBUF_X34_Y9_N16
\NEG~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \RestaNegativa~combout\,
	devoe => ww_devoe,
	o => \NEG~output_o\);

-- Location: IOIBUF_X23_Y0_N8
\An[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_An(0),
	o => \An[0]~input_o\);

-- Location: IOIBUF_X30_Y0_N8
\Bn[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Bn(0),
	o => \Bn[0]~input_o\);

-- Location: LCCOMB_X28_Y2_N16
\RESN0|Res~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \RESN0|Res~0_combout\ = \An[0]~input_o\ $ (\Bn[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \An[0]~input_o\,
	datad => \Bn[0]~input_o\,
	combout => \RESN0|Res~0_combout\);

-- Location: IOIBUF_X28_Y0_N22
\Sn~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Sn,
	o => \Sn~input_o\);

-- Location: IOIBUF_X23_Y0_N15
\An[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_An(1),
	o => \An[1]~input_o\);

-- Location: LCCOMB_X28_Y2_N26
\SUM0|CSig~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \SUM0|CSig~0_combout\ = (\Bn[0]~input_o\ & ((\Sn~input_o\))) # (!\Bn[0]~input_o\ & (\An[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \An[0]~input_o\,
	datab => \Bn[0]~input_o\,
	datad => \Sn~input_o\,
	combout => \SUM0|CSig~0_combout\);

-- Location: IOIBUF_X30_Y0_N22
\Bn[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Bn(1),
	o => \Bn[1]~input_o\);

-- Location: LCCOMB_X28_Y2_N12
\SUM1|Res\ : cycloneive_lcell_comb
-- Equation(s):
-- \SUM1|Res~combout\ = \Sn~input_o\ $ (\An[1]~input_o\ $ (\SUM0|CSig~0_combout\ $ (\Bn[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Sn~input_o\,
	datab => \An[1]~input_o\,
	datac => \SUM0|CSig~0_combout\,
	datad => \Bn[1]~input_o\,
	combout => \SUM1|Res~combout\);

-- Location: IOIBUF_X21_Y0_N8
\An[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_An(2),
	o => \An[2]~input_o\);

-- Location: IOIBUF_X28_Y0_N1
\Bn[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Bn(2),
	o => \Bn[2]~input_o\);

-- Location: LCCOMB_X28_Y2_N6
\SUM1|CSig\ : cycloneive_lcell_comb
-- Equation(s):
-- \SUM1|CSig~combout\ = (\An[1]~input_o\ & (!\SUM0|CSig~0_combout\ & (\Sn~input_o\ $ (\Bn[1]~input_o\)))) # (!\An[1]~input_o\ & ((\Sn~input_o\ $ (\Bn[1]~input_o\)) # (!\SUM0|CSig~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001011100101011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Sn~input_o\,
	datab => \An[1]~input_o\,
	datac => \SUM0|CSig~0_combout\,
	datad => \Bn[1]~input_o\,
	combout => \SUM1|CSig~combout\);

-- Location: LCCOMB_X28_Y2_N0
RestaNegativa : cycloneive_lcell_comb
-- Equation(s):
-- \RestaNegativa~combout\ = (\Sn~input_o\) # ((\An[2]~input_o\ & (\Bn[2]~input_o\ & \SUM1|CSig~combout\)) # (!\An[2]~input_o\ & ((\Bn[2]~input_o\) # (\SUM1|CSig~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101110111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Sn~input_o\,
	datab => \An[2]~input_o\,
	datac => \Bn[2]~input_o\,
	datad => \SUM1|CSig~combout\,
	combout => \RestaNegativa~combout\);

-- Location: LCCOMB_X28_Y2_N8
\RESN1|Res~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \RESN1|Res~2_combout\ = \SUM1|Res~combout\ $ (((!\RestaNegativa~combout\ & (\An[0]~input_o\ $ (\Bn[0]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100110011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SUM1|Res~combout\,
	datab => \RestaNegativa~combout\,
	datac => \An[0]~input_o\,
	datad => \Bn[0]~input_o\,
	combout => \RESN1|Res~2_combout\);

-- Location: LCCOMB_X28_Y2_N10
\RESN2|Res~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \RESN2|Res~0_combout\ = \Sn~input_o\ $ (\An[2]~input_o\ $ (\Bn[2]~input_o\ $ (\SUM1|CSig~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Sn~input_o\,
	datab => \An[2]~input_o\,
	datac => \Bn[2]~input_o\,
	datad => \SUM1|CSig~combout\,
	combout => \RESN2|Res~0_combout\);

-- Location: LCCOMB_X28_Y2_N20
\RESN2|Res\ : cycloneive_lcell_comb
-- Equation(s):
-- \RESN2|Res~combout\ = \RESN2|Res~0_combout\ $ (((!\RestaNegativa~combout\ & ((\SUM1|Res~combout\) # (\RESN0|Res~0_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001111010010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SUM1|Res~combout\,
	datab => \RestaNegativa~combout\,
	datac => \RESN2|Res~0_combout\,
	datad => \RESN0|Res~0_combout\,
	combout => \RESN2|Res~combout\);

-- Location: LCCOMB_X28_Y2_N30
\RES~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \RES~0_combout\ = (\Sn~input_o\ & ((\An[2]~input_o\ & (!\Bn[2]~input_o\ & \SUM1|CSig~combout\)) # (!\An[2]~input_o\ & ((\SUM1|CSig~combout\) # (!\Bn[2]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Sn~input_o\,
	datab => \An[2]~input_o\,
	datac => \Bn[2]~input_o\,
	datad => \SUM1|CSig~combout\,
	combout => \RES~0_combout\);

ww_RES(0) <= \RES[0]~output_o\;

ww_RES(1) <= \RES[1]~output_o\;

ww_RES(2) <= \RES[2]~output_o\;

ww_RES(3) <= \RES[3]~output_o\;

ww_NEG <= \NEG~output_o\;
END structure;


