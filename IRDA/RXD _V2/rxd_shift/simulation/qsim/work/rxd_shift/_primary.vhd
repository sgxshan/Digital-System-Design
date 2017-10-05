library verilog;
use verilog.vl_types.all;
entity rxd_shift is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        serial_in       : in     vl_logic;
        rshift          : in     vl_logic;
        data            : out    vl_logic_vector(10 downto 0);
        reset           : in     vl_logic;
        data_load       : out    vl_logic_vector(10 downto 0)
    );
end rxd_shift;
