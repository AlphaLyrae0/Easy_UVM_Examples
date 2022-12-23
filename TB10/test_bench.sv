`include "uvm_macros.svh"
//`include "uvm_pkg.sv"
module test_bench;
  import uvm_pkg::*;
  import test_lib_pkg::*;
  bit           clk;

  initial forever #(100/2) clk = !clk;

  dut_prm_if i_dut_prm_if(   );
  dut_in_if  i_dut_in_if (clk);
  dut_out_if i_dut_out_if(clk);

  initial begin
    test_lib_pkg  ::prm_vif = i_dut_prm_if;
    agent_pkg     ::in_vif  = i_dut_in_if ;
    scoreboard_pkg::out_vif = i_dut_out_if;
    uvm_pkg::run_test(); //"my_test");
  end

  dut i_dut (.clk, .rst_n(i_dut_in_if.rst_n),
     .param_a(i_dut_prm_if.param_a), .param_b(i_dut_prm_if.param_b), .param_c(i_dut_prm_if.param_c),
     .sig(i_dut_in_if.sig),
     .x(i_dut_out_if.x) , .y(i_dut_out_if.y), .z(i_dut_out_if.z));

endmodule
