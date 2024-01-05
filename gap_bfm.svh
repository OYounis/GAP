class gap_bfm#(
  type REQ = uvm_sequence_item
) extends uvm_object;
  `uvm_object_param_utils(gap_bfm#(REQ))
  `uvm_register_cb(gap_bfm#(REQ), gap_bfm_cb)

  gap_driver#(REQ)  drv_proxy;
  gap_monitor#(REQ) mon_proxy;

  function new(string name = "gap_bfm");
    super.new(name);
  endfunction

  virtual task drive();
    this.pre_drive();
    this.do_drive();
    this.post_drive();
  endtask : drive

  virtual task monitor();
    this.pre_monitor();
    this.do_monitor();
    this.post_monitor();
  endtask : monitor

  extern virtual task pre_drive();
  extern virtual task post_drive();
  extern virtual task do_drive();

  extern virtual task pre_monitor();
  extern virtual task post_monitor();
  extern virtual task do_monitor();
endclass : gap_bfm

task gap_bfm::pre_drive();
  `uvm_do_callbacks(gap_bfm#(REQ), gap_bfm_cb, pre_drive(this.drv_proxy))
endtask
task gap_bfm::post_drive();
  `uvm_do_callbacks(gap_bfm#(REQ), gap_bfm_cb, post_drive(this.drv_proxy))
endtask
task gap_bfm::do_drive();
  `uvm_do_callbacks(gap_bfm#(REQ), gap_bfm_cb, do_drive(this.drv_proxy))
endtask

task gap_bfm::pre_monitor();
  `uvm_do_callbacks(gap_bfm#(REQ), gap_bfm_cb, pre_monitor(this.mon_proxy))
endtask
task gap_bfm::post_monitor();
  `uvm_do_callbacks(gap_bfm#(REQ), gap_bfm_cb, post_monitor(this.mon_proxy))
endtask
task gap_bfm::do_monitor();
  `uvm_do_callbacks(gap_bfm#(REQ), gap_bfm_cb, do_monitor(this.mon_proxy))
endtask
