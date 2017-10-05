library verilog;
use verilog.vl_types.all;
entity bit_counter is
    generic(
        no_bit          : integer := 12
    );
    port(
        clk             : in     vl_logic;
        clear           : in     vl_logic;
        count           : in     vl_logic;
        bit_done        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of no_bit : constant is 1;
end bit_counter;
