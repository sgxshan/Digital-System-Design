library verilog;
use verilog.vl_types.all;
entity rxd_controller_vlg_sample_tst is
    port(
        bit_done        : in     vl_logic;
        clk             : in     vl_logic;
        data_in         : in     vl_logic;
        done_pulse      : in     vl_logic;
        half_pulse      : in     vl_logic;
        reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end rxd_controller_vlg_sample_tst;
