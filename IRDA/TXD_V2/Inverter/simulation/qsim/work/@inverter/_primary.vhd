library verilog;
use verilog.vl_types.all;
entity Inverter is
    port(
        IR              : in     vl_logic;
        lastbit         : in     vl_logic;
        txd             : out    vl_logic
    );
end Inverter;
