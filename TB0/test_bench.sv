module test_bench;
  bit       clk, rst_n;
  bit       param_a, param_b, param_c;  // Input Settings
  bit [0:2] sig;                        // Input Signals
  logic     x, y, z;                    // Output

  initial forever #(100/2) clk = !clk;

  initial begin
    $display("Start of Test !!!!");
    {param_a, param_b, param_c} = 'b110;
    repeat(10) @(posedge clk);
    #(100/2)    rst_n = 1;
    $display("Reset Is Released!!!");
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
    $display("ERROR !!! xyz = %b%b%b, expected %3b",x,y,z, exp_xyz[i]);
  else
    $display("OK        xyz = %b%b%b, expected %3b",x,y,z, exp_xyz[i]);
  i++;
end

endmodule
