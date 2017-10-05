library verilog;
use verilog.vl_types.all;
entity Inverter_vlg_sample_tst is
    port(
        IR              : in     vl_logic;
        lastbit         : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end Inverter_vlg_sample_tst;
