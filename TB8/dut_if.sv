interface dut_if(input clk);

    bit rst_n;

    bit             param_a, param_b, param_c;
    bit [0:2]       sig;                        // Input Signals
    logic           x, y, z;                    // Output

    task reset_release();
        repeat(10) @(posedge clk);
        #(100/2)    rst_n = 1;
    endtask

endinterface
