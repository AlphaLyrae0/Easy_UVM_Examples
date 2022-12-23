`include "uvm_macros.svh"
package test_lib_pkg;
  import uvm_pkg::*;

  virtual dut_if vif; //<==== Virtual Interface

  //############################################
  class my_test extends uvm_test;
    `uvm_component_utils(my_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void set_params();
        {vif.param_a, vif.param_b, vif.param_c} = 3'b110;
    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);
        set_params();
        `uvm_info(get_type_name(), $sformatf("param_a = %b, param_b = %b, param_c =%b", vif.param_a, vif.param_b, vif.param_c), UVM_MEDIUM)
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info( "my_test", "Hello! This is an UVM message.", UVM_MEDIUM)
        fork
            vif.check_result();
        join_none
        vif.reset_release(); //test_sequence();
        vif.drive_sig();
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
        {vif.param_a, vif.param_b, vif.param_c} = this.param_abc;
    endfunction

  endclass
  //############################################

endpackage
