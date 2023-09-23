module bfm( input clk, output logic [0:2]  sig);

    task drive_sig(bit[0:2] val);
        @(negedge clk) sig = val;
    endtask

endmodule
