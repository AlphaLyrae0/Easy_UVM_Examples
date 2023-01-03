`include "uvm_macros.svh"
//`include "uvm_pkg.sv"
module test_bench;
  import uvm_pkg::*;
  import test_lib_pkg::*;
  bit           clk;

  initial forever #(100/2) clk = !clk;

  dut_if     i_dut_if(.clk);
  dut_in_if  i_in_if (.clk, .rst_n(i_dut_if.rst_n) );   // <========
  dut_out_if i_out_if(.clk, .rst_n(i_dut_if.rst_n) );   // <========

  initial begin
    test_lib_pkg  ::vif = i_dut_if;
    agent_pkg     ::vif = i_in_if ;                     // <========
    scoreboard_pkg::vif = i_out_if;                     // <========
    uvm_pkg::run_test(); //"my_test");
  end

  dut i_dut (.clk, .rst_n(i_dut_if.rst_n),
     .param_a(param_a), .param_b(param_b), .param_c(param_c),
     .sig(i_in_if.sig),                                 // <========
     .x(i_out_if.x) , .y(i_out_if.y), .z(i_out_if.z));  // <========

endmodule
