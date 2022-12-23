
interface dut_prm_if();
    bit             param_a, param_b, param_c;
endinterface

interface dut_in_if(input clk);

    bit         rst_n;
    bit [0:2]   sig;

    task reset_release();
        repeat(10) @(posedge clk);
        #(100/2)    rst_n = 1;
    endtask

endinterface

interface dut_in_if(input clk);
    logic           x, y, z;
endinterface

