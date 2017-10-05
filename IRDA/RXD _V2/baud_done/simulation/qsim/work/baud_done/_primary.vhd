library verilog;
use verilog.vl_types.all;
entity baud_done is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        half_pulse      : out    vl_logic;
        done_pulse      : out    vl_logic
    );
end baud_done;
