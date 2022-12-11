REPORT zfizzbuzz_range.

DATA: lv_number TYPE i,
      lr_fizzbuzz TYPE REF TO zcl_fizzbuzz_range,
      lt_result TYPE TABLE OF zsw_fizzbuzz,
      lw_result TYPE zsw_fizzbuzz.

SELECT-OPTIONS: so_num FOR lv_number NO-EXTENSION.

CREATE OBJECT lr_fizzbuzz.

lr_fizzbuzz->zif_fizzbuzz_range~convert_number_to_fizzbuzz(
  EXPORTING
    iv_number          = so_num[]
  IMPORTING
    ev_value_to_number = lt_result
).

LOOP AT lt_result INTO lw_result.
  WRITE:
     lw_result-zahl, ':', lw_result-bezeichnung.
  SKIP.
ENDLOOP.
