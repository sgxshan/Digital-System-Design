library verilog;
use verilog.vl_types.all;
entity receiver is
    port(
        parity_error    : out    vl_logic;
        data_in         : in     vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        framing_error   : out    vl_logic;
        half_baud2      : out    vl_logic;
        baud_done       : out    vl_logic;
        \7seg1\         : out    vl_logic_vector(6 downto 0);
        \7seg2\         : out    vl_logic_vector(6 downto 0);
        output          : out    vl_logic_vector(9 downto 0)
    );
end receiver;
