/* Class: gap_driver
 * Extends <uvm_driver>. Base generic driver class containing the base driver methods.
 */
class gap_driver#(
  type REQ = uvm_sequence_item
) extends uvm_driver#(REQ);
  typedef gap_bfm#(REQ) bfm_m;
  // Variable: bfm
  // Bus functional model.
  bfm_m bfm;

  // Constructor: uvm_component_new
  // UVM component constructor.
  function new(string name = "gap_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction  
  // Factory Registry: `uvm_component_param_utils
  // UVM factory registry.
  `uvm_component_param_utils(gap_driver#(REQ))

  // Task: run_phase
  // UVM run phase responsible for driving the DUT i/o during simulation.
  extern virtual task run_phase(uvm_phase phase);
  // Task: Drive
  // Drive DUT bus signals. Base implementation calls the BFM drive() task.
  extern virtual task drive();
endclass : gap_driver

task gap_driver::run_phase(uvm_phase phase);
  super.run_phase(phase);
  this.drive();
endtask

task gap_driver::drive();
  bfm.drive();
endtask