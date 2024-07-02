`ifndef {{ name | upper }}_AGENT_SV
`define {{ name | upper }}_AGENT_SV

class {{ name }}_agent extends uvm_agent;

  `uvm_component_utils({{ name }}_agent)

  uvm_analysis_port #({{ name }}_sequence_item) analysis_port;

  {{ name }}_sequencer sqr;
  {{ name }}_driver    drv;
  {{ name }}_monitor   mon;
  {{ name }}_config    cfg;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass : {{ name }}_agent


function  {{ name }}_agent::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


function void {{ name }}_agent::build_phase(uvm_phase phase);

  if ( !uvm_config_db #({{ name }}_config)::get(this, "", "cfg", cfg) ) begin
		  `uvm_fatal(get_name(), "Could not retrieve {{ name }}_config from config db")
	end

  if (cfg.is_active == UVM_ACTIVE) begin
    sqr = {{ name }}_sequencer::type_id::create("sqr", this);
    drv = {{ name }}_driver   ::type_id::create("drv", this);
    `uvm_info(get_type_name(), "sqr created", UVM_MEDIUM)
    `uvm_info(get_type_name(), "drv created", UVM_MEDIUM)
  end

  mon = {{ name }}_monitor::type_id::create("mon", this);
  `uvm_info(get_type_name(), "mon created", UVM_MEDIUM)

  analysis_port = new("analysis_port", this);

endfunction : build_phase


function void {{ name }}_agent::connect_phase(uvm_phase phase);

  if (cfg.is_active == UVM_ACTIVE) begin
    drv.seq_item_port.connect(sqr.seq_item_export);
    `uvm_info(get_type_name(), "drv and sqr connected", UVM_MEDIUM)
  end

  mon.analysis_port.connect(this.analysis_port);

endfunction : connect_phase


`endif // {{ name | upper }}_AGENT_SV
