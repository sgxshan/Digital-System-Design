onerror {quit -f}
vlib work
vlog -work work receiver.vo
vlog -work work receiver.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.receiver_vlg_vec_tst
vcd file -direction receiver.msim.vcd
vcd add -internal receiver_vlg_vec_tst/*
vcd add -internal receiver_vlg_vec_tst/i1/*
add wave /*
run -all
