module bfm( input clk, output logic [0:2]  sig);

    task drive_sig();
        $display("BFM start driving!!!");
        @(posedge clk) sig = 'b1_1_1;
        @(posedge clk) sig = 'b0_1_1;
        @(posedge clk) sig = 'b0_0_1;
        @(posedge clk) sig = 'b0_0_0;
    endtask

endmodule
