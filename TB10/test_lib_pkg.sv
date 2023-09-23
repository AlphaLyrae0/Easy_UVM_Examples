`include "uvm_macros.svh"
package test_lib_pkg;
  import uvm_pkg::*;
  import  sig_agent_pkg::*; // <===============
  import  xyz_agent_pkg::*; // <===============

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

    my_driver  m_drv;                                       // <========
    my_monitor m_mon;                                       // <========
    virtual function void build_phase(uvm_phase phase);                    // <========
        `uvm_info( get_type_name(), "############ Hello! This is an UVM message. ################", UVM_MEDIUM)
        m_drv = my_driver ::type_id::create("m_drv", this); // <========
        m_mon = my_monitor::type_id::create("m_mon", this); // <========
    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info( get_type_name(), "Start of Test !!!!", UVM_MEDIUM)
        set_params();
      //`uvm_info(get_type_name(), $sformatf("param_a = %b, param_b = %b, param_c =%b", param_a, param_b, param_c), UVM_MEDIUM)
        `uvm_info(get_type_name(), {"\n",this.sprint()}, UVM_MEDIUM)        // <===========
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        vif.reset_release();
        this.test_sequence_start();
        phase.drop_objection(this);
    endtask

    my_item m_item;
    virtual task test_sequence_start();
        `uvm_info(get_type_name(), "Start sending items!!!", UVM_MEDIUM);
        m_item = my_item::type_id::create("m_item");
        m_item.sig ='b1_1_1; m_drv.start_item(m_item); // <===========
        m_item.sig ='b0_1_1; m_drv.start_item(m_item); // <===========
        m_item.sig ='b0_0_1; m_drv.start_item(m_item); // <===========
        m_item.sig ='b0_0_0; m_drv.start_item(m_item); // <===========
    endtask

    virtual function void final_phase(uvm_phase phase);
        `uvm_info( get_type_name(), "############ Bye! This is the end of an UVM test. ################", UVM_MEDIUM)
    endfunction

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

  class full_random_test extends random_test;
    `uvm_component_utils(full_random_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task test_sequence_start();
        `uvm_info(get_type_name(), "Start sending random items!!!", UVM_MEDIUM)
        m_item = my_item::type_id::create("m_item");
        repeat(10) begin                                  // <===========
          if (!m_item.randomize())                        // <===========
            `uvm_fatal(get_name(), "Randomize Failed!!!") // <===========
          m_drv.start_item(m_item);                       // <===========
        end                                               // <===========
    endtask

  endclass

endpackage
