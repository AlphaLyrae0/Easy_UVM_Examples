`include "uvm_macros.svh"
package sig_agent_pkg;
  import uvm_pkg::*;

  virtual sig_if vif;   //<==== Virtual Interface


  class my_item extends uvm_sequence_item;
  //`uvm_object_utils(my_item)
    `uvm_object_utils_begin(my_item)             // <=======
        `uvm_field_int(sig, UVM_PRINT | UVM_BIN) // <=======
    `uvm_object_utils_end                        // <=======
  
    function new(string name = "");
      super.new(name);
    endfunction

    rand bit[0:2] sig;

  endclass


  class my_driver extends uvm_driver;
    `uvm_component_utils(my_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task start_item(my_item tr);
      tr.print();
      this.drive_sig(tr.sig);
    endtask

    virtual task drive_sig(bit[0:2] val);
      //@(posedge vif.clk) vif.sig = val;
        @(negedge vif.clk) vif.sig = val;
      //@(posedge vif.clk);
    endtask

  //virtual task run_phase (uvm_phase phase);
  //  forever @(posedge vif.clk)
  //    `uvm_info(get_name(), $sformatf("Input sig : %b", vif.sig), UVM_MEDIUM)
  //endtask

  endclass

endpackage
