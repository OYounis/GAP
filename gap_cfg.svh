class gap_cfg #(type REQ = uvm_sequence_item) extends gap_base_cfg;
  gap_bfm#(REQ) bfm;
  `uvm_object_param_utils(gap_cfg #(REQ))

  function new(string name = "gap_cfg");
    super.new(name);
    bfm = gap_bfm#(REQ)::type_id::create("bfm");
  endfunction
endclass : gap_cfg
