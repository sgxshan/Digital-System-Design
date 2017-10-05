library verilog;
use verilog.vl_types.all;
entity receiver_vlg_check_tst is
    port(
        framing_error   : in     vl_logic;
        output1         : in     vl_logic_vector(6 downto 0);
        output2         : in     vl_logic_vector(6 downto 0);
        parity_error    : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end receiver_vlg_check_tst;
