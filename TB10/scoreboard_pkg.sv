`include "uvm_macros.svh"
package scoreboard_pkg;
  import uvm_pkg::*;

  virtual xyz_if vif;   //<==== Virtual Interface

  class my_monitor extends uvm_monitor;
    `uvm_component_utils(my_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    int i;
    bit[2:0] exp_xyz[100];
    virtual task run_phase(uvm_phase phase);
        forever @(posedge vif.clk) begin
          if ({vif.x,vif.y,vif.z} !== exp_xyz[i])
            `uvm_error(get_type_name(), $sformatf("ERROR !!! xyz = %b%b%b, expected %3b",vif.x,vif.y,vif.z, exp_xyz[i]))
          else
            `uvm_info (get_type_name(), $sformatf("OK        xyz = %b%b%b, expected %3b",vif.x,vif.y,vif.z, exp_xyz[i]), UVM_MEDIUM)
          i++;
        end
    endtask

  endclass

endpackage
