bind test_bench test_if i_test_if();

interface test_if();

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
