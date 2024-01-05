/* Class: gap_agent
 * Extends <gap_base_agent>. Base agent class containing the base agent methods.
 */
class gap_agent #(type CFG = gap_cfg) extends gap_base_agent;
  //Re-definition of the typedefs in the CFG to be available in this class scope.
  typedef CFG::REQ REQ;
  //Typedefs based on the configuration
  typedef gap_driver#(REQ) drv_t;
  typedef gap_monitor#(REQ) mon_t;
  typedef uvm_sequencer#(REQ)  sqr_t;

  // Variable: ap
  // Analysis port used to broadcast outside the agent.
  uvm_analysis_port#(REQ) ap;
  // Variable: cfg_h
  // Base agent configuration handle.
  CFG cfg_h;
  // Variable: drv_h
  // Driver handle.
  drv_t drv_h;
  // Variable: mon_h
  // Monitor handle.
  mon_t mon_h;
  // Variable: sqr_h
  // Sequencer handle.
  sqr_t sqr_h;

  // Constructor: uvm_component_new
  // UVM component constructor.
  function new(string name = "gap_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction  
  // Factory Registry: `uvm_component_param_utils
  // UVM factory registry.
  `uvm_component_param_utils(gap_agent#(CFG))

  /* Function: build_phase
    UVM build phase calls the <do_build> function.
  */
  extern virtual function void build_phase(uvm_phase phase);
  /* Function: connect_phase
    UVM connect phase calls the <do_connect> function.
  */
  extern virtual function void connect_phase(uvm_phase phase);
  /* Function: do_build
    Executed in the build phase. gets the configuration object from uvm_config_db.
    The config object is expected to be named ~name_cfg_h~
    where "name" is the UVM component name.
  */
  extern virtual function void do_build();
  /* Function: do_connect
    Executed in the connect phase. Connects the sub-components of the agent.
  */
  extern virtual function void do_connect();
endclass : gap_agent

function void gap_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  this.do_build();
endfunction

function void gap_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  this.do_connect();
endfunction

function void gap_agent::do_build();
  if(!uvm_config_db#(CFG)::get(this, "", {$sformatf("%0s", get_name()),"_cfg"}, cfg_h)) begin
    `uvm_fatal("[agent]",$sformatf("Failed to fetch %0s from CGFDB", {$sformatf("%0s", get_name()),"_cfg"}))
  end
  if (cfg_h.is_active == UVM_ACTIVE) begin
    drv_h = drv_t::type_id::create({$sformatf("%0s", get_name()),"_drv"}, this);
  end
  mon_h = mon_t::type_id::create({$sformatf("%0s", get_name()),"_mon"}, this);
  sqr_h = sqr_t::type_id::create({$sformatf("%0s", get_name()),"_sqr"}, this);
  ap = new("analysis_port", this);
endfunction

function void gap_agent::do_connect();
  if (cfg_h.is_active == UVM_ACTIVE) begin
    cfg_h.bfm.drv_proxy = drv_h;
    drv_h.bfm = cfg_h.bfm;
  end
  cfg_h.bfm.mon_proxy = mon_h;
  mon_h.bfm = cfg_h.bfm;

  drv_h.seq_item_port.connect(sqr_h.seq_item_export);
  mon_h.ap.connect(this.ap);
endfunction
