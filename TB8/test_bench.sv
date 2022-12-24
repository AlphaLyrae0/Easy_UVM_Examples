`include "uvm_macros.svh"
//`include "uvm_pkg.sv"
module test_bench;
  import uvm_pkg::*;
  import test_lib_pkg::*;
  bit           clk; //,rst_n;                                  ======> Moved to test_lib_pkg

//bit [0:2]     sig;                        // Input Signals    ======> Moved to test_lib_pkg
//logic         x, y, z;                    // Output           ======> Moved to test_lib_pkg

  initial forever #(100/2) clk = !clk;

//bfm i_bfm(.clk, .sig);    // ========>
//bfm_if i_bfm_if(); // Instanciated by bind, not here
  dut_if i_dut_if(clk);     // <======= Instanciated here

  initial begin
    test_lib_pkg::vif = i_dut_if;
    uvm_pkg::run_test(); //"my_test");
  end

  dut i_dut (.clk, .rst_n(i_dut_if.rst_n),     // <======
     .param_a(param_a), .param_b(param_b), .param_c(param_c),
     .sig(sig),                                // <======
     .x(x) , .y(y), .z(z));                    // <======

endmodule
