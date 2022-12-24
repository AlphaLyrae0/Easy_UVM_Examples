`include "uvm_macros.svh"
package test_lib_pkg;
  import uvm_pkg::*;
  import agent_pkg     ::my_driver ;
  import scoreboard_pkg::my_monitor;

  bit       param_a, param_b, param_c;

  class my_test extends uvm_test;
    `uvm_component_utils(my_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void set_params();
        {param_a, param_b, param_c} = 3'b110;
    endfunction

    my_driver  m_drv;
    my_monitor m_mon;
    virtual function void build_phase(uvm_phase phase);
        m_drv = my_driver ::type_id::create("m_drv", this);
        m_mon = my_monitor::type_id::create("m_mon", this);
    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Start of Test !!!!", UVM_MEDIUM)
        set_params();
        `uvm_info(get_type_name(), $sformatf("param_a = %b, param_b = %b, param_c =%b", param_a, param_b, param_c), UVM_MEDIUM)
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info( "my_test", "Hello! This is an UVM message.", UVM_MEDIUM)
        m_drv.reset_release();
        m_drv.drive_sig();
        phase.drop_objection(this);
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
