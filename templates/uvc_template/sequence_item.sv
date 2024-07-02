`ifndef {{ name | upper }}_SEQUENCE_ITEM_SV
`define {{ name | upper }}_SEQUENCE_ITEM_SV


class {{ name }}_sequence_item extends uvm_sequence_item; 

  `uvm_object_utils({{ name }}_sequence_item)

  extern function new(string name = "");

  extern function void do_copy(uvm_object rhs);
  extern function bit  do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function string convert2string();

endclass : {{ name }}_sequence_item 


function {{ name }}_sequence_item::new(string name = "");
  super.new(name);
endfunction : new


function void {{ name }}_sequence_item::do_copy(uvm_object rhs);
  {{ name }}_sequence_item rhs_;
  if (!$cast(rhs_, rhs))
    `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  super.do_copy(rhs);
  //holder = rhs_.holder;
endfunction : do_copy


function bit {{ name }}_sequence_item::do_compare(uvm_object rhs, uvm_comparer comparer);
  bit result;
  {{ name }}_sequence_item rhs_;
  if (!$cast(rhs_, rhs))
    `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  result = super.do_compare(rhs, comparer);
  //result &= (holder == rhs_.holder);
  return result;
endfunction : do_compare


function string {{ name }}_sequence_item::convert2string();
  string s;
  s = super.convert2string();
  $sformat(s, "hello");
  return s;
endfunction : convert2string


`endif // {{ name | upper }}_SEQUENCE_ITEM_SV
