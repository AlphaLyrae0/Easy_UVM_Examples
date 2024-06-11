`include "uvm_macros.svh"
//`include "uvm_pkg.sv"
module test_bench;
  import uvm_pkg::*;
  import test_lib_pkg::*;                   // <========= Added
  bit           clk, rst_n;
//bit           param_a, param_b, param_c;  // Input Settings =========> Moved to test_lib_pkg
  bit [0:2]     sig;                        // Input Signals
  logic         x, y, z;                    // Output

  initial forever #(100/2) clk = !clk;

  //############## ==========> Classes were moved into test_lib_pkg
  //############## ==========> Classes were moved into test_lib_pkg

  initial begin
    test_lib_pkg::vif     = test_bench.i_test_if;  // <========= interface handle passing
    test_lib_pkg::bfm_vif = i_bfm.i_probe;         // <========= interface handle passing
    uvm_pkg::run_test(); //"my_test");
  end

  task reset_release();
    repeat(10) @(posedge clk);
    #(100/2)    rst_n = 1;
    `uvm_info("test_bench.test_sequence()", "Reset Is Released!!!", UVM_MEDIUM)
  endtask

  test_if i_test_if();              // <================ Added test_if
  bind bfm bfm_if i_probe();        // <================ Bind bfm_if to the BFM

  bfm i_bfm(.clk, .sig);

  dut i_dut (.clk, .rst_n,
     .param_a(param_a), .param_b(param_b), .param_c(param_c),
     .sig,
     .x , .y, .z);

  task check_result();
    int i;
    bit[2:0] exp_xyz[100];
    forever @(posedge clk) begin
        if ({x,y,z} !== exp_xyz[i])
          `uvm_error("test_bench.check_result()", $sformatf("ERROR !!! xyz = %b%b%b, expected %3b",x,y,z, exp_xyz[i]))
        else
          `uvm_info ("test_bench.check_result()", $sformatf("OK        xyz = %b%b%b, expected %3b",x,y,z, exp_xyz[i]), UVM_MEDIUM)
        i++;
    end
  endtask

endmodule
