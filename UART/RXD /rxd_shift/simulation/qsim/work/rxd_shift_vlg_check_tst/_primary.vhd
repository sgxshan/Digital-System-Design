library verilog;
use verilog.vl_types.all;
entity rxd_shift_vlg_check_tst is
    port(
        data            : in     vl_logic_vector(10 downto 0);
        data_load       : in     vl_logic_vector(10 downto 0);
        sampler_rx      : in     vl_logic
    );
end rxd_shift_vlg_check_tst;
