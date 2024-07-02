`ifndef {{ name | upper }}_TYPES_SV
`define {{ name | upper }}_TYPES_SV

typedef enum {
  {{ name | upper }}_ITEM_FIRST, 
  {{ name | upper }}_ITEM_MIDDLE, 
  {{ name | upper }}_ITEM_LAST
} {{ name }}_item_stage_e;

typedef enum {
  {{ name | upper }}_ITEM_SYNC,
  {{ name | upper }}_ITEM_ASYNC
} {{ name }}_item_type_e;

typedef enum {
  {{ name | upper }}_ITEM_DELAY_OFF,
  {{ name | upper }}_ITEM_DELAY_ON
} {{ name }}_item_delay_e;

`endif // {{ name | upper }}_TYPES_SV 
