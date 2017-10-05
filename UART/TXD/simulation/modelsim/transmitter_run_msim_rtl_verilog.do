transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/Liverpool/ELEC373/Assignment\ 1/UART/TXD_V2 {F:/Liverpool/ELEC373/Assignment 1/UART/TXD_V2/shift.v}
vlog -vlog01compat -work work +incdir+F:/Liverpool/ELEC373/Assignment\ 1/UART/TXD_V2 {F:/Liverpool/ELEC373/Assignment 1/UART/TXD_V2/parity.v}
vlog -vlog01compat -work work +incdir+F:/Liverpool/ELEC373/Assignment\ 1/UART/TXD_V2 {F:/Liverpool/ELEC373/Assignment 1/UART/TXD_V2/controller.v}
vlog -vlog01compat -work work +incdir+F:/Liverpool/ELEC373/Assignment\ 1/UART/TXD_V2 {F:/Liverpool/ELEC373/Assignment 1/UART/TXD_V2/bit_counter.v}
vlog -vlog01compat -work work +incdir+F:/Liverpool/ELEC373/Assignment\ 1/UART/TXD_V2 {F:/Liverpool/ELEC373/Assignment 1/UART/TXD_V2/baud_counter.v}

