onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /comparador_4bits/A
add wave -noupdate -radix binary -childformat {{/comparador_4bits/B(3) -radix binary} {/comparador_4bits/B(2) -radix binary} {/comparador_4bits/B(1) -radix binary} {/comparador_4bits/B(0) -radix binary}} -subitemconfig {/comparador_4bits/B(3) {-radix binary} /comparador_4bits/B(2) {-radix binary} /comparador_4bits/B(1) {-radix binary} /comparador_4bits/B(0) {-radix binary}} /comparador_4bits/B
add wave -noupdate /comparador_4bits/AmOut
add wave -noupdate /comparador_4bits/BmOut
add wave -noupdate /comparador_4bits/IgOut
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {471 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 169
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1251 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern random -initialvalue 1010 -period 50ps -random_type Uniform -seed 5 -range 3 0 -starttime 0ps -endtime 1000ps sim:/comparador_4bits/A 
WaveExpandAll -1
wave create -driver freeze -pattern random -initialvalue 1010 -period 50ps -random_type Uniform -seed 5 -range 3 0 -starttime 0ps -endtime 1000ps sim:/comparador_4bits/B 
WaveExpandAll -1
wave modify -driver freeze -pattern random -initialvalue 1010 -period 25ps -random_type Normal -seed 5 -range 3 0 -starttime 0ps -endtime 1000ps Edit:/comparador_4bits/B 
WaveCollapseAll -1
wave clipboard restore
