/* Class: gap_monitor
 * Extends <uvm_monitor>. Base genric monitor class containing generic monitor methods.
 */
class gap_monitor #(
  type REQ = uvm_sequence_item
) extends uvm_monitor;
  typedef gap_bfm#(REQ) bfm_m;

  // Variable: ap
  // Analysis port used to notify sampled transactions.
  uvm_analysis_port#(REQ) ap;
  // Variable: bfm
  // Bus functional model.
  bfm_m bfm; //Bus functional model
  // Constructor: uvm_component_new
  // Calls plain UVM component constructor.
  function new(string name = "gap_monitor", uvm_component parent = null);
    super.new(name, parent);
  endfunction    
  // Factory Registry: `uvm_component_param_utils
  // UVM factory registry.
  `uvm_component_param_utils(gap_monitor#(REQ))

  /* Function: build_phase
    UVM build phase calls the do_build function.
  */
  extern virtual function void build_phase(uvm_phase phase);

  /* Task: main_phase
    UVM main phase responsible for sampling the DUT i/o values during simulation.
  */
  extern virtual task main_phase(uvm_phase phase);
  // Task: monitor
  // Sample DUT bus signals. Base implementation calls the BFM monitor() task.
  extern virtual task monitor();
  // Function: notify
  // Calls the write function of the analysis port.
  //extern virtual function void notify(string path);
endclass : gap_monitor

function void gap_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  ap = new("analysis_port", this);
endfunction

task gap_monitor::main_phase(uvm_phase phase);
  super.main_phase(phase);
  this.monitor();
endtask

task gap_monitor::monitor();
  bfm.monitor();
endtask