`ifndef {{ name | upper }}_SEQUENCE_BASE_SV
`define {{ name | upper }}_SEQUENCE_BASE_SV

class {{ name }}_sequence_base extends uvm_sequence #({{ name }}_sequence_item);

  `uvm_object_utils({{ name }}_sequence_base)

  int num_of_trans = 50;

  extern function new(string name = "");
  extern virtual task body();
  extern function void display();

endclass : {{ name }}_sequence_base


function {{ name }}_sequence_base::new(string name = "");
  super.new(name);
endfunction : new


task {{ name }}_sequence_base::body();
    req = {{ name }}_sequence_item::type_id::create("req");
    for (int i = 0; i < num_of_trans; i++) begin

      start_item(req);

      if (i == 0) begin
        req.trans_type = {{ name | upper }}_ITEM_ASYNC;
      end else begin
        req.trans_type = {{ name | upper }}_ITEM_SYNC;
      end

      if ( !req.randomize() ) begin
        `uvm_error(get_type_name(), "Failed to randomize transaction")
      end

      if ( i == num_of_trans - 1) begin
        req.trans_stage = {{ name | upper }}_ITEM_LAST;
      end

      finish_item(req);
    end
endtask : body


function void {{ name }}_sequence_base::display();
 `uvm_info(get_type_name(), "inside base sequence", UVM_MEDIUM);
endfunction : display

`endif // {{ name | upper }}_SEQUENCE_BASE_SV
