library verilog;
use verilog.vl_types.all;
entity IRtransceiver_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        Input           : in     vl_logic_vector(7 downto 0);
        IRDA_RXD        : in     vl_logic;
        reset           : in     vl_logic;
        send            : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end IRtransceiver_vlg_sample_tst;
