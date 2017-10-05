library verilog;
use verilog.vl_types.all;
entity rxd_parity_vlg_sample_tst is
    port(
        in_data         : in     vl_logic_vector(10 downto 0);
        sampler_tx      : out    vl_logic
    );
end rxd_parity_vlg_sample_tst;
