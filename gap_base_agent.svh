/* Class: gap_base_agent
 * Extends <uvm_agent>. Base agent class.
 * All agents should extend this class.
 */
class gap_base_agent extends uvm_agent;
  // Constructor: uvm_component_new
  // UVM component constructor.
  function new(string name = "gap_base_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  // Factory Registry: `uvm_component_utils
  // UVM factory registry.
  `uvm_component_utils(gap_base_agent)
endclass : gap_base_agent
