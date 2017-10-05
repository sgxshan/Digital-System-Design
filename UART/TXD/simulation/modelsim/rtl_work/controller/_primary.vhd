library verilog;
use verilog.vl_types.all;
entity controller is
    generic(
        P               : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        Q               : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        S               : vl_logic_vector(0 to 1) := (Hi1, Hi1)
    );
    port(
        send            : in     vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        baud_done       : in     vl_logic;
        bit_done        : in     vl_logic;
        shift           : out    vl_logic;
        count           : out    vl_logic;
        reset_baud      : out    vl_logic;
        clear_bit       : out    vl_logic;
        load_shift      : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of P : constant is 1;
    attribute mti_svvh_generic_type of Q : constant is 1;
    attribute mti_svvh_generic_type of S : constant is 1;
end controller;
