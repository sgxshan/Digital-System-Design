library verilog;
use verilog.vl_types.all;
entity shift is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        shift           : in     vl_logic;
        dat             : in     vl_logic_vector(11 downto 0);
        reset           : in     vl_logic;
        lastbit         : out    vl_logic
    );
end shift;
