onerror {quit -f}
vlib work
vlog -work work transmitter.vo
vlog -work work transmitter.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.transmitter_vlg_vec_tst
vcd file -direction transmitter.msim.vcd
vcd add -internal transmitter_vlg_vec_tst/*
vcd add -internal transmitter_vlg_vec_tst/i1/*
add wave /*
run -all
