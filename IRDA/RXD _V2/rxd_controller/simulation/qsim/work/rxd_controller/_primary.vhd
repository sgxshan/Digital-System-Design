library verilog;
use verilog.vl_types.all;
entity rxd_controller is
    port(
        data_in         : in     vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        half_pulse      : in     vl_logic;
        done_pulse      : in     vl_logic;
        bit_done        : in     vl_logic;
        rxd_shift       : out    vl_logic;
        rxd_count       : out    vl_logic;
        reset_baud      : out    vl_logic;
        clear_bit       : out    vl_logic;
        load_shift      : out    vl_logic;
        parity_check    : out    vl_logic
    );
end rxd_controller;
