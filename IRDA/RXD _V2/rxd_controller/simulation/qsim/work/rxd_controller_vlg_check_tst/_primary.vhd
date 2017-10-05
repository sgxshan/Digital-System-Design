library verilog;
use verilog.vl_types.all;
entity rxd_controller_vlg_check_tst is
    port(
        clear_bit       : in     vl_logic;
        load_shift      : in     vl_logic;
        parity_check    : in     vl_logic;
        reset_baud      : in     vl_logic;
        rxd_count       : in     vl_logic;
        rxd_shift       : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end rxd_controller_vlg_check_tst;
