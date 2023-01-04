`include "uvm_macros.svh"
interface dut_if(input clk);
    import uvm_pkg::*;

    bit rst_n;

    task reset_release();
        repeat(10) @(posedge clk);
        #(100/2)    rst_n = 1;
        `uvm_info("reset_release()", "Reset Is Released!!!", UVM_MEDIUM)
    endtask

endinterface
