class gap_bfm_cb extends uvm_callback;
  function new(string name = "gap_bfm_cb");
    super.new(name);
  endfunction

  virtual task pre_drive (uvm_component drv); endtask
  virtual task do_drive  (uvm_component drv); endtask
  virtual task post_drive(uvm_component drv); endtask

  virtual task pre_monitor (uvm_component mon); endtask
  virtual task do_monitor  (uvm_component mon); endtask
  virtual task post_monitor(uvm_component mon); endtask
endclass : gap_bfm_cb
