class gap_base_cfg extends uvm_object;
  // Variable: b_is_active
  // Controls agent PASSIVE/ACTIVE operation.
  uvm_active_passive_enum is_active = UVM_ACTIVE;
  // Variable: b_checks_enable
  // Enable agent checks.
  bit checks_enable = 1;
  // Variable: b_coverage_enable
  // Enable coverage.
  bit coverage_enable = 1;
  // Constructor: `uvm_component_new
  // Calls plain UVM component constructor.

  function new(string name = "gap_base_cfg");
    super.new(name);
  endfunction
  // UVM factory registry.
    `uvm_object_utils_begin(gap_base_cfg)
    `uvm_field_int  (checks_enable, UVM_DEFAULT)
    `uvm_field_int  (coverage_enable, UVM_DEFAULT)
    `uvm_field_enum (uvm_active_passive_enum, is_active, UVM_DEFAULT)
  `uvm_object_utils_end
endclass
