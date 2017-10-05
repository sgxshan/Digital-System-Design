onerror {quit -f}
vlib work
vlog -work work baud_done.vo
vlog -work work baud_done.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.baud_done_vlg_vec_tst
vcd file -direction baud_done.msim.vcd
vcd add -internal baud_done_vlg_vec_tst/*
vcd add -internal baud_done_vlg_vec_tst/i1/*
add wave /*
run -all
