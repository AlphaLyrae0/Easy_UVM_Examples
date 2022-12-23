
interface dut_in_if(input clk);

    bit         rst_n;
    bit [0:2]   sig;

    task reset_release();
        repeat(10) @(posedge clk);
        #(100/2)    rst_n = 1;
    endtask

endinterface

