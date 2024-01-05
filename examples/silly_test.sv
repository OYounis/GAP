import uvm_pkg::*;
`include "uvm_macros.svh"
import gap_pkg::*;

interface dut_bfm();
  logic clk, nrst;
  int i;

  class dut_bfm_cb extends gap_bfm_cb;
  function new(string name = "");
    super.new(name);
  endfunction

  task pre_drive(uvm_component drv);
    `uvm_info($sformatf("%0s", drv.get_name()),"This is pre_drive", UVM_NONE)
  endtask

  task post_drive(uvm_component drv);
    `uvm_info($sformatf("%0s", drv.get_name()),"This is post_drive", UVM_NONE)
  endtask

  task do_drive(uvm_component drv);
    nrst = 0;
    forever begin
      #5 clk = 0;
      #5 clk = 1;
      i++;
    end
  endtask
  endclass : dut_bfm_cb

  dut_bfm_cb bfm = new();
endinterface

class gap_silly_test extends uvm_test;
  `uvm_component_utils(gap_silly_test)
  gap_agent agnt_h;
  gap_cfg   cfg_h;
  gap_bfm_cb bfm_cb;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agnt_h = gap_agent#(gap_cfg)::type_id::create("dut_agnt", this);
    cfg_h  = gap_cfg#(uvm_sequence_item)::type_id::create({$sformatf("%0s", agnt_h.get_name()),"_cfg"});

    if(!uvm_config_db#(gap_bfm_cb)::get(this, "", "dut_bfm_cb", bfm_cb)) begin
      `uvm_fatal("[agent]",$sformatf("Failed to fetch %0s from CGFDB", {$sformatf("%0s", get_name()),"_cfg"}))
    end

    uvm_callbacks #(gap_bfm, gap_bfm_cb)::add(this.cfg_h.bfm, this.bfm_cb);
    uvm_callbacks #(gap_bfm, gap_bfm_cb)::display();
    
    uvm_config_db#(gap_cfg)::set(this, "*", cfg_h.get_name(), cfg_h);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
      #500ns
    phase.drop_objection(this);
  endtask
endclass : gap_silly_test

module silly_top;
  dut_bfm dut_if();

  initial begin
    uvm_config_db#(gap_bfm_cb)::set(null, "*", "dut_bfm_cb", dut_if.bfm);
    run_test("gap_silly_test");
  end
endmodule : silly_top