library verilog;
use verilog.vl_types.all;
entity seg_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        data_in         : in     vl_logic_vector(10 downto 0);
        reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end seg_vlg_sample_tst;
