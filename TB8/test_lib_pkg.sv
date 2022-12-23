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
            this.check_result();
        join_none
        vif.reset_release();
        `uvm_info(get_type_name(), "Reset Is Released!!!", UVM_MEDIUM)
        this.drive_sig();
        phase.drop_objection(this);
    endtask

    virtual task drive_sig();
        `uvm_info(get_type_name(), "BFM start driving!!!", UVM_MEDIUM);
        @(posedge vif.clk) vif.sig = 'b1_1_1;
        @(posedge vif.clk) vif.sig = 'b0_1_1;
        @(posedge vif.clk) vif.sig = 'b0_0_1;
        @(posedge vif.clk) vif.sig = 'b0_0_0;
    endtask

    virtual task check_result();
        int i;
        bit[2:0] exp_xyz[100];
        forever @(posedge vif.clk) begin
          if ({vif.x,vif.y,vif.z} !== exp_xyz[i])
            `uvm_error(get_type_name(), $sformatf("ERROR !!! xyz = %b%b%b, expected %3b",vif.x,vif.y,vif.z, exp_xyz[i]))
          else
            `uvm_info (get_type_name(), $sformatf("OK        xyz = %b%b%b, expected %3b",vif.x,vif.y,vif.z, exp_xyz[i]), UVM_MEDIUM)
          i++;
        end

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
