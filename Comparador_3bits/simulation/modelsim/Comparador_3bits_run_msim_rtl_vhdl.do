transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/alph4/QuartusProyects/Comparador_3bits/Comparador_3bits.vhd}

