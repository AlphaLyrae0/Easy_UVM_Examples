`include "uvm_macros.svh"
module test_bench;
  import uvm_pkg::*;
  bit       clk, rst_n;
  bit       param_a, param_b, param_c;  // Input Settings
  bit [0:2] sig;                        // Input Signals
  logic     x, y, z;                    // Output

  initial forever #(100/2) clk = !clk;

  initial begin
    `uvm_info("test_bench", "Start of Test !!!!", UVM_MEDIUM)
    {param_a, param_b, param_c} = 'b110;
    repeat(10) @(posedge clk);
    #(100/2)    rst_n = 1;
    `uvm_info("test_bench", "Reset Is Released!!!", UVM_MEDIUM)
    @(posedge clk) sig = 'b1_1_1;
    @(posedge clk) sig = 'b0_1_1;
    @(posedge clk) sig = 'b0_0_1;
    @(posedge clk) sig = 'b0_0_0;
    $finish();
 end

  dut i_dut (.clk, .rst_n,
     .param_a, .param_b, .param_c,
     .sig,
     .x , .y, .z);

int i;
bit[2:0] exp_xyz[100];
always@(posedge clk) begin
  if ({x,y,z} !== exp_xyz[i])
    `uvm_error("test_bench", $sformatf("ERROR !!! xyz = %b%b%b, expected %3b",x,y,z, exp_xyz[i]))
  else
    `uvm_info ("test_bench", $sformatf("OK        xyz = %b%b%b, expected %3b",x,y,z, exp_xyz[i]), UVM_MEDIUM)
  i++;
end

endmodule
