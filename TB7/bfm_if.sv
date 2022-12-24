bind test_bench bfm_if i_bfm_if();

interface bfm_if();

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
