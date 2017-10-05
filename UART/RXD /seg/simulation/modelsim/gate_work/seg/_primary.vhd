library verilog;
use verilog.vl_types.all;
entity seg is
    port(
        data_in         : in     vl_logic_vector(10 downto 0);
        reset           : in     vl_logic;
        data_1          : out    vl_logic_vector(6 downto 0);
        data_2          : out    vl_logic_vector(6 downto 0)
    );
end seg;
