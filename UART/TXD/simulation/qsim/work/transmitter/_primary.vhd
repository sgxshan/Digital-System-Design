library verilog;
use verilog.vl_types.all;
entity transmitter is
    port(
        TXD             : out    vl_logic;
        Clk             : in     vl_logic;
        Send            : in     vl_logic;
        Reset           : in     vl_logic;
        Data            : in     vl_logic_vector(7 downto 0)
    );
end transmitter;
