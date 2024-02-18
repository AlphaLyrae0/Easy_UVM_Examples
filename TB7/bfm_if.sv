
interface bfm_if();

    task drive_sig(bit[0:2] val);
        i_bfm.drive_sig(val);
    endtask

endinterface
