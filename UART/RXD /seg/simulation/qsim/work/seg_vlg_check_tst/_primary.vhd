library verilog;
use verilog.vl_types.all;
entity seg_vlg_check_tst is
    port(
        data_1          : in     vl_logic_vector(6 downto 0);
        data_2          : in     vl_logic_vector(6 downto 0);
        sampler_rx      : in     vl_logic
    );
end seg_vlg_check_tst;
