transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/alph4/QuartusProjects/PWM/PWM.vhd}
vcom -93 -work work {/home/alph4/QuartusProjects/PWM/senal_PWM.vhd}

