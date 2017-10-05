library verilog;
use verilog.vl_types.all;
entity IRtransceiver is
    port(
        parity_error    : out    vl_logic;
        IRDA_RXD        : in     vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        framing_error   : out    vl_logic;
        IRDA_TXD        : out    vl_logic;
        send            : in     vl_logic;
        Input           : in     vl_logic_vector(7 downto 0);
        pin_name1       : out    vl_logic;
        segL            : out    vl_logic_vector(6 downto 0);
        segR            : out    vl_logic_vector(6 downto 0)
    );
end IRtransceiver;
