onerror {quit -f}
vlib work
vlog -work work rxd_shift.vo
vlog -work work rxd_shift.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.rxd_shift_vlg_vec_tst
vcd file -direction rxd_shift.msim.vcd
vcd add -internal rxd_shift_vlg_vec_tst/*
vcd add -internal rxd_shift_vlg_vec_tst/i1/*
add wave /*
run -all
