INTERFACE yif_money_example
  PUBLIC .
  METHODS:
    times
      IMPORTING
        iv_times         TYPE int1
      RETURNING
        VALUE(ro_dollar) TYPE REF TO yif_money_example,
    equals
      IMPORTING
        io_money_example   TYPE REF TO yif_money_example
      RETURNING
        VALUE(rv_is_equal) TYPE abap_bool,
    get_amount
      RETURNING
        VALUE(rv_amount) TYPE int4.

ENDINTERFACE.
