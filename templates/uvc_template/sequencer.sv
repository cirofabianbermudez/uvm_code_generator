`ifndef {{ name | upper }}_SEQUENCER_SV
`define {{ name | upper }}_SEQUENCER_SV


typedef uvm_sequencer #({{ name }}_sequence_item) {{ name }}_sequencer;


`endif // {{ name | upper }}_SEQUENCER_SV
