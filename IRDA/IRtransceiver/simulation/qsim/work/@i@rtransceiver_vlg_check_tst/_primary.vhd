library verilog;
use verilog.vl_types.all;
entity IRtransceiver_vlg_check_tst is
    port(
        framing_error   : in     vl_logic;
        IRDA_TXD        : in     vl_logic;
        parity_error    : in     vl_logic;
        pin_name1       : in     vl_logic;
        segL            : in     vl_logic_vector(6 downto 0);
        segR            : in     vl_logic_vector(6 downto 0);
        sampler_rx      : in     vl_logic
    );
end IRtransceiver_vlg_check_tst;
