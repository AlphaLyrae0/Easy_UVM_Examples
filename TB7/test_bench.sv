`include "uvm_macros.svh" //<===========
module test_bench;
  import uvm_pkg::*;     //<===========
  import test_lib_pkg::*;

  bit           clk, rst_n;
//bit           param_a, param_b, param_c;  // Input Settings
  bit [0:2]     sig;                        // Input Signals
  logic         x, y, z;                    // Output

  initial forever #(100/2) clk = !clk;

  initial begin
    test_lib_pkg::vif = test_bench.i_dut_if;
    uvm_pkg::run_test(); //"my_test"); //<============
  end

//initial begin
  task reset_release(); //test_sequence();
////{param_a, param_b, param_c} = 'b110;
////uvm_pkg::uvm_wait_for_nba_region(); //<<=========== Wait untl the start of run_phase
////`uvm_info("test_bench", "Waited until the start of run_phase.", UVM_MEDIUM)
    repeat(10) @(posedge clk);
    #(100/2)    rst_n = 1;
    `uvm_info("test_bench.test_sequence()", "Reset Is Released!!!", UVM_MEDIUM)
//  @(posedge clk) sig = 'b1_1_1;
//  @(posedge clk) sig = 'b0_1_1;
//  @(posedge clk) sig = 'b0_0_1;
//  @(posedge clk) sig = 'b0_0_0;
////-> test_done_evt;  //$finish();
  endtask

  bfm i_bfm(.clk, .sig);

//dut_if i_dut_if();

  dut i_dut (.clk, .rst_n,
     .param_a(i_dut_if.param_a), .param_b(i_dut_if.param_b), .param_c(i_dut_if.param_c),
     .sig,
     .x , .y, .z);

task check_result();
  int i;
  bit[2:0] exp_xyz[100];
//always@(posedge clk) begin
  forever @(posedge clk) begin
      if ({x,y,z} !== exp_xyz[i])
        `uvm_error("test_bench.check_result()", $sformatf("ERROR !!! xyz = %b%b%b, expected %3b",x,y,z, exp_xyz[i]))
      else
        `uvm_info ("test_bench.check_result()", $sformatf("OK        xyz = %b%b%b, expected %3b",x,y,z, exp_xyz[i]), UVM_MEDIUM)
      i++;
  end
endtask

endmodule
