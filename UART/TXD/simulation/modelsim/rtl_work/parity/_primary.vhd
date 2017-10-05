library verilog;
use verilog.vl_types.all;
entity parity is
    port(
        data_in         : in     vl_logic_vector(7 downto 0);
        Data_out        : out    vl_logic_vector(11 downto 0)
    );
end parity;
