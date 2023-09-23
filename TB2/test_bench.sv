`include "uvm_macros.svh"
//`include "uvm_pkg.sv"
module test_bench;
    import uvm_pkg::*;
    bit         clk, rst_n;
    bit         param_a, param_b, param_c;  // Input Settings
    bit [0:2]   sig;                        // Input Signals
    logic       x, y, z;                    // Output

    initial forever #(100/2) clk = !clk;

    event test_done_evt;

  //############################################
  class my_test extends uvm_test;
    `uvm_component_utils(my_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void set_params();
        {param_a, param_b, param_c} = 'b110;
    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info( get_type_name(), "############ Hello! This is an UVM message. ################", UVM_MEDIUM)
        `uvm_info( get_type_name(), "Start of Test !!!!", UVM_MEDIUM)
        set_params();
        `uvm_info(get_type_name(), $sformatf("param_a = %b, param_b = %b, param_c =%b", param_a, param_b, param_c), UVM_MEDIUM)
    endfunction

    virtual task run_phase (uvm_phase phase);
        phase.raise_objection(this);
        @(test_done_evt);
        phase.drop_objection(this);
    endtask

    virtual function void final_phase(uvm_phase phase);
        `uvm_info( get_type_name(), "############ Bye! This is the end of an UVM test. ################", UVM_MEDIUM)
    endfunction

  endclass
  //############################################

  initial uvm_pkg::run_test("my_test");

  initial begin
  //`uvm_info("test_bench", "Start of Test !!!!", UVM_MEDIUM)   // ===========> Moved to start_of_simulation_phase()
  //{param_a, param_b, param_c} = 'b110;                        // ===========> Moved to start_of_simulation_phase()
    uvm_pkg::uvm_wait_for_nba_region();                         // <=========== Wait until the start of run_phase()
    `uvm_info("test_bench", "Waited until the start of run_phase.", UVM_MEDIUM)
    repeat(10) @(posedge clk);
    #(100/2)    rst_n = 1;
    `uvm_info("test_bench", "Reset Is Released!!!", UVM_MEDIUM)
    @(negedge clk) sig = 'b1_1_1;
    @(negedge clk) sig = 'b0_1_1;
    @(negedge clk) sig = 'b0_0_1;
    @(negedge clk) sig = 'b0_0_0;
    -> test_done_evt;  //$finish();
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
