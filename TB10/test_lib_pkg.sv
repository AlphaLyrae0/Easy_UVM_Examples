`include "uvm_macros.svh"
package test_lib_pkg;
  import uvm_pkg::*;

//bit       param_a, param_b, param_c;                          // =======> to dut_if
//bit [0:2] sig;                        // Input Signals        // =======> to sig_if
//logic     x, y, z;                    // Output               // =======> to xyz_if

  virtual dut_if vif;

  class my_test extends uvm_test;
  //`uvm_component_utils(my_test)
    `uvm_component_utils_begin(my_test)                         // <=======
        `uvm_field_int(param_abc, UVM_PRINT | UVM_BIN)          // <=======
    `uvm_component_utils_end                                    // <=======

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    rand bit[2:0] param_abc = 3'b110;

    virtual function void set_params();
        {vif.param_a, vif.param_b, vif.param_c} = param_abc;               // <========
    endfunction

    sig_agent_pkg::my_driver  m_drv;                                       // <========
    xyz_agent_pkg::my_monitor m_mon;                                       // <========
    virtual function void build_phase(uvm_phase phase);                    // <========
        m_drv = sig_agent_pkg::my_driver ::type_id::create("m_drv", this); // <========
        m_mon = xyz_agent_pkg::my_monitor::type_id::create("m_mon", this); // <========
    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Start of Test !!!!", UVM_MEDIUM)
        set_params();
      //`uvm_info(get_type_name(), $sformatf("param_a = %b, param_b = %b, param_c =%b", param_a, param_b, param_c), UVM_MEDIUM)
        `uvm_info(get_type_name(), {"\n",this.sprint()}, UVM_MEDIUM)        // <===========
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info( "my_test", "Hello! This is an UVM message.", UVM_MEDIUM)
        vif.reset_release();
        m_drv.drive_sig();
        phase.drop_objection(this);
    endtask

  endclass

  class random_test extends my_test;
    `uvm_component_utils(random_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void set_params();
        this.randomize();
        super.set_params();
    endfunction

  endclass

endpackage
