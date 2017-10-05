library verilog;
use verilog.vl_types.all;
entity counter is
    port(
        clk             : in     vl_logic;
        clear           : in     vl_logic;
        count           : in     vl_logic;
        bit_done        : out    vl_logic
    );
end counter;
