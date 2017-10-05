library verilog;
use verilog.vl_types.all;
entity rxd_parity is
    port(
        in_data         : in     vl_logic_vector(10 downto 0);
        parity_error    : out    vl_logic;
        framing_error   : out    vl_logic
    );
end rxd_parity;
