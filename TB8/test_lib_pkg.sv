`include "uvm_macros.svh"
package test_lib_pkg;
  import uvm_pkg::*;

  bit       param_a, param_b, param_c;
  bit [0:2] sig;                        // Input Signals
  logic     x, y, z;                    // Output

  virtual dut_if vif;

  class my_test extends uvm_test;
    `uvm_component_utils(my_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void set_params();
        {param_a, param_b, param_c} = 3'b110;
    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info( get_type_name(), "############ Hello! This is an UVM message. ################", UVM_MEDIUM)
        `uvm_info(get_type_name(), "Start of Test !!!!", UVM_MEDIUM)
        set_params();
        `uvm_info(get_type_name(), $sformatf("param_a = %b, param_b = %b, param_c =%b", param_a, param_b, param_c), UVM_MEDIUM)
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        fork
            this.check_result();        // <========
        join_none
        vif.reset_release();
        this.test_sequence_start();
        phase.drop_objection(this);
    endtask

    virtual function void final_phase(uvm_phase phase);
        `uvm_info( get_type_name(), "############ Bye! This is the end of an UVM test. ################", UVM_MEDIUM)
    endfunction

    virtual task test_sequence_start();
        `uvm_info(get_type_name(), "Start signal driving!!!", UVM_MEDIUM)
        this.drive_sig('b1_1_1); // <===========
        this.drive_sig('b0_1_1); // <===========
        this.drive_sig('b0_0_1); // <===========
        this.drive_sig('b0_0_0); // <===========
    endtask

    virtual task drive_sig(bit[0:2] val); // <==========
        @(negedge vif.clk) sig = val;     // <==========
    endtask                               // <==========

    virtual task check_result();        // <======== Added
        int i;
        bit[2:0] exp_xyz[100];
        forever @(posedge vif.clk) begin
          if ({x,y,z} !== exp_xyz[i])
            `uvm_error(get_type_name(), $sformatf("ERROR !!! xyz = %b%b%b, expected %3b",x,y,z, exp_xyz[i]))
          else
            `uvm_info (get_type_name(), $sformatf("OK        xyz = %b%b%b, expected %3b",x,y,z, exp_xyz[i]), UVM_MEDIUM)
          i++;
        end

    endtask

  endclass

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

endpackage
