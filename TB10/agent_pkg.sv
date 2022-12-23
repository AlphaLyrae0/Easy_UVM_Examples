`include "uvm_macros.svh"
package agent_pkg;
  import uvm_pkg::*;

  virtual dut_in_if     in_vif ; //<==== Virtual Interface

  class my_driver extends uvm_driver;
    `uvm_component_utils(my_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual dut_in_if vif;

    virtual function void connect_phase(uvm_phase phase);
        vif = in_vif;
    endfunction

    virtual task reset_release;
        vif.reset_release();
        `uvm_info(get_type_name(), "Reset Is Released!!!", UVM_MEDIUM)
    endtask

    virtual task drive_sig();
        `uvm_info(get_type_name(), "BFM start driving!!!", UVM_MEDIUM);
        @(posedge vif.clk) vif.sig = 'b1_1_1;
        @(posedge vif.clk) vif.sig = 'b0_1_1;
        @(posedge vif.clk) vif.sig = 'b0_0_1;
        @(posedge vif.clk) vif.sig = 'b0_0_0;
    endtask

  endclass

endpackage
