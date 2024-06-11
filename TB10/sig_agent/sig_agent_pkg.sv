`include "uvm_macros.svh"
package sig_agent_pkg;
  import uvm_pkg::*;

  virtual sig_if vif;   //<==== Virtual Interface

  class my_item extends uvm_sequence_item;        // <======= Added

    rand bit[0:2] sig;

  //`uvm_object_utils(my_item)
    `uvm_object_utils_begin(my_item)
        `uvm_field_int(sig, UVM_PRINT | UVM_BIN)
    `uvm_object_utils_end
  
    function new(string name = "");
      super.new(name);
    endfunction

  endclass


  class my_driver extends uvm_driver;
    `uvm_component_utils(my_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task start_item(my_item tr);  // <======= Added
      tr.print();                         // <======= Added
      this.drive_sig(tr.sig);             // <======= Added
    endtask                               // <======= Added

    virtual task drive_sig(bit[0:2] val);
        @(negedge vif.clk) vif.sig = val;
    endtask

  endclass

endpackage
