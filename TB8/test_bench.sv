`include "uvm_macros.svh"
//`include "uvm_pkg.sv"
module test_bench;
  import uvm_pkg::*;
  import test_lib_pkg::*;
  bit           clk; //,rst_n;                                  ======> Moved to dut_if
//bit           param_a, param_b, param_c;  // Input Settings   ======> Moved to dut_if
//bit [0:2]     sig;                        // Input Signals    ======> Moved to dut_if
//logic         x, y, z;                    // Output           ======> Moved to dut_if

  initial forever #(100/2) clk = !clk;

//bfm i_bfm(.clk, .sig);    // ========>
  dut_if i_dut_if(clk);     // <======= Instanciated here now

  initial begin
    test_lib_pkg::vif = i_dut_if;
    uvm_pkg::run_test(); //"my_test");
  end

  dut i_dut (.clk, .rst_n(i_dut_if.rst_n),                                                  // <======
     .param_a(i_dut_if.param_a), .param_b(i_dut_if.param_b), .param_c(i_dut_if.param_c),    // <======
     .sig(i_dut_if.sig),                                                                    // <======
     .x(i_dut_if.x) , .y(i_dut_if.y), .z(i_dut_if.z));                                      // <======

endmodule
