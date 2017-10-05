library verilog;
use verilog.vl_types.all;
entity baud_done_vlg_check_tst is
    port(
        done_pulse      : in     vl_logic;
        half_pulse      : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end baud_done_vlg_check_tst;
