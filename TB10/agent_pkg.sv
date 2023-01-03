`include "uvm_macros.svh"
package agent_pkg;
  import uvm_pkg::*;

  virtual sig_if vif;   //<==== Virtual Interface

  class my_driver extends uvm_driver;
    `uvm_component_utils(my_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task drive_sig();
        `uvm_info(get_type_name(), "BFM start driving!!!", UVM_MEDIUM);
        @(posedge vif.clk) vif.sig = 'b1_1_1;
        @(posedge vif.clk) vif.sig = 'b0_1_1;
        @(posedge vif.clk) vif.sig = 'b0_0_1;
        @(posedge vif.clk) vif.sig = 'b0_0_0;
    endtask

  endclass

endpackage
