`ifndef {{ name | upper }}_SEQUENCE_ITEM_SV
`define {{ name | upper }}_SEQUENCE_ITEM_SV

class {{ name }}_sequence_item extends uvm_sequence_item; 

  `uvm_object_utils({{ name }}_sequence_item)

  {{ name }}_item_stage_e  trans_stage  = {{ name }}_ITEM_MIDDLE;
  {{ name }}_item_type_e   trans_type   = {{ name }}_ITEM_SYNC;
  {{ name }}_item_delay_e  delay_enable = {{ name }}_ITEM_DELAY_OFF;
  rand int unsigned delay_duration_ps;

  extern function new(string name = "");

  extern function void do_copy(uvm_object rhs);
  extern function bit  do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function string convert2string();

  // IMPORTANT -timescale=1ps/100fs to avoid Verdi errors
  constraint delay_c {
    soft delay_duration_ps inside { [1_000 : 10_000] }; // 1ns - 10ns
  }

endclass : {{ name }}_sequence_item 


function {{ name }}_sequence_item::new(string name = "");
  super.new(name);
endfunction : new


function void {{ name }}_sequence_item::do_copy(uvm_object rhs);
  {{ name }}_sequence_item rhs_;
  if (!$cast(rhs_, rhs))
    `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  super.do_copy(rhs);
  trans_stage       = rhs_.trans_stage;
  trans_type        = rhs_.trans_type;
  delay_enable      = rhs_.delay_enable;
  delay_duration_ps = rhs_.delay_duration_ps;
endfunction : do_copy


function bit {{ name }}_sequence_item::do_compare(uvm_object rhs, uvm_comparer comparer);
  bit result;
  {{ name }}_sequence_item rhs_;
  if (!$cast(rhs_, rhs))
    `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  result = super.do_compare(rhs, comparer);
  delay_enable      &= rhs_.delay_enable;
  return result;
endfunction : do_compare


function string {{ name }}_sequence_item::convert2string();
  string s;
  s = super.convert2string();
  $sformat(s, "delay_enable = 'b%0b", delay_enable);
  return s;
endfunction : convert2string

`endif // {{ name | upper }}_SEQUENCE_ITEM_SV
