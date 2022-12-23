`include "uvm_macros.svh" //<===========
module test_bench;
  import uvm_pkg::*;     //<===========

  bit           clk, rst_n;
  bit           param_a, param_b, param_c;  // Input Settings
  bit [0:2]     sig;                        // Input Signals
  logic         x, y, z;                    // Output

  initial forever #(100/2) clk = !clk;

//event test_done_evt;

  //############################################
  class my_test extends uvm_test;
    `uvm_component_utils(my_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void set_params();
        {param_a, param_b, param_c} = 3'b110;
    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);
        set_params();
        `uvm_info(get_type_name(), $sformatf("param_a = %b, param_b = %b, param_c =%b", param_a, param_b, param_c), UVM_MEDIUM)
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info( "my_test", "Hello! This is an UVM message.", UVM_MEDIUM)
        fork
            check_result();
        join_none
        test_sequence();
      //@(test_doe_evt);
        phase.drop_objection(this);
    endtask

  endclass
  //############################################

  //############################################
  class random_test extends my_test;
    `uvm_component_utils(random_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    rand bit[2:0] param_abc = 3'b110;

    virtual function void set_params();
        this.randomize();
        {param_a, param_b, param_c} = this.param_abc;
    endfunction

  endclass
  //############################################

  initial uvm_pkg::run_test(); //"my_test"); //<============

//initial begin
  task test_sequence();
  //{param_a, param_b, param_c} = 'b110;
  //uvm_pkg::uvm_wait_for_nba_region(); //<<=========== Wait untl the start of run_phase
  //`uvm_info("test_bench", "Waited until the start of run_phase.", UVM_MEDIUM)
    repeat(10) @(posedge clk);
    #(100/2)    rst_n = 1;
    `uvm_info("test_bench.test_sequence()", "Reset Is Released!!!", UVM_MEDIUM)
    @(posedge clk) sig = 'b1_1_1;
    @(posedge clk) sig = 'b0_1_1;
    @(posedge clk) sig = 'b0_0_1;
    @(posedge clk) sig = 'b0_0_0;
  //-> test_done_evt;  //$finish();
  endtask

  dut i_dut (.clk, .rst_n,
     .param_a, .param_b, .param_c,
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
