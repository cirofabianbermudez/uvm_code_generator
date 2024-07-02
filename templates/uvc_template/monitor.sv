`ifndef {{ name | upper }}_MONITOR_SV
`define {{ name | upper }}_MONITOR_SV

class {{ name }}_monitor extends uvm_monitor;

  `uvm_component_utils({{ name }}_monitor)

  virtual {{ name }}_if vif;
  {{ name }}_config    cfg;
  uvm_analysis_port #({{ name }}_sequence_item) analysis_port;
  {{ name }}_sequence_item trans;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task do_mon();

endclass : {{ name }}_monitor


function {{ name }}_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


function void {{ name }}_monitor::build_phase(uvm_phase phase);
  if ( !uvm_config_db #(virtual {{ name }}_if)::get(get_parent(), "", "vif", vif) ) begin
		  `uvm_fatal(get_name(), "Could not retrieve {{ name }}_if from config db")
	end

  if ( !uvm_config_db #({{ name }}_config)::get(get_parent(), "", "cfg", cfg) ) begin
		  `uvm_fatal(get_name(), "Could not retrieve {{ name }}_config from config db")
	end

  analysis_port = new("analysis_port", this);

endfunction : build_phase


task {{ name }}_monitor::run_phase(uvm_phase phase);
  trans = {{ name }}_sequence_item::type_id::create("trans");
  do_mon();
endtask : run_phase


task {{ name }}_monitor::do_mon();
  forever begin
     $display("MISSING MONITOR CODE");
    `uvm_info(get_type_name(), {"Got item ", trans.convert2string()}, UVM_MEDIUM)
    analysis_port.write(trans);
  end
endtask : do_mon

`endif // {{ name | upper }}_MONITOR_SV
