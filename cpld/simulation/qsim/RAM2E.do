onerror {quit -f}
vlib work
vlog -work work RAM2E.vo
vlog -work work RAM2E.vt
vsim -novopt -c -t 1ps -L max7000s_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.RAM2E_vlg_vec_tst
vcd file -direction RAM2E.msim.vcd
vcd add -internal RAM2E_vlg_vec_tst/*
vcd add -internal RAM2E_vlg_vec_tst/i1/*
add wave /*
run -all
