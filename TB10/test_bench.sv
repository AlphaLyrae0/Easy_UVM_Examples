`include "uvm_macros.svh"
//`include "uvm_pkg.sv"
module test_bench;
  import uvm_pkg::*;
  import test_lib_pkg::*;
  bit           clk;

  initial forever #(100/2) clk = !clk;

  dut_if i_dut_if(.clk);
  sig_if i_sig_if(.clk, .rst_n(i_dut_if.rst_n) );   // <========
  xyz_if i_xyz_if(.clk, .rst_n(i_dut_if.rst_n) );   // <========

  initial begin
    test_lib_pkg  ::vif = i_dut_if;
    agent_pkg     ::vif = i_sig_if;                 // <========
    scoreboard_pkg::vif = i_xyz_if;                 // <========
    uvm_pkg::run_test(); //"my_test");
  end

  dut i_dut (.clk, .rst_n(i_dut_if.rst_n),
     .param_a(param_a), .param_b(param_b), .param_c(param_c),
     .sig(i_sig_if.sig),                                    // <========
     .x(i_xyz_if.x) , .y(i_xyz_if.y), .z(i_xyz_if.z));      // <========

endmodule
