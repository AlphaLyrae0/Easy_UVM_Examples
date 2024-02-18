
interface test_if();

    task reset_release();
        test_bench.reset_release();
    endtask

    task drive_sig(bit[0:2] val);
        i_bfm.drive_sig(val);
    endtask

    task check_result();
        test_bench.check_result();
    endtask

endinterface
