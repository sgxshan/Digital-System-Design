library verilog;
use verilog.vl_types.all;
entity transmitter_vlg_sample_tst is
    port(
        Clk             : in     vl_logic;
        Data            : in     vl_logic_vector(7 downto 0);
        Reset           : in     vl_logic;
        Send            : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end transmitter_vlg_sample_tst;
