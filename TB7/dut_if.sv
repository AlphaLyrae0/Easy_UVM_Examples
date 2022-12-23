bind test_bench dut_if i_dut_if();

interface dut_if();

    bit param_a, param_b, param_c;

    task reset_release();
        test_bench.reset_release();
    endtask

    task drive_sig();
        i_bfm.drive_sig();
    endtask

    task check_result();
        test_bench.check_result();
    endtask

endinterface
