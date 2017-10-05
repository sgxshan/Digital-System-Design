library verilog;
use verilog.vl_types.all;
entity rxd_parity_vlg_check_tst is
    port(
        framing_error   : in     vl_logic;
        parity_error    : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end rxd_parity_vlg_check_tst;
