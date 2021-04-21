INTERFACE yif_expression
  PUBLIC .
  METHODS:
    reduce
      IMPORTING
        io_bank         TYPE REF TO ycl_bank
        iv_currency     TYPE string
      RETURNING
        VALUE(ro_money) TYPE REF TO ycl_money,
    currency
      RETURNING
        VALUE(rv_currency) TYPE string,
    get_amount
      RETURNING VALUE(rv_amount) TYPE int4,
    equals
      IMPORTING
        io_money           TYPE REF TO yif_expression
      RETURNING
        VALUE(rv_is_equal) TYPE abap_bool,
    times
      IMPORTING
        iv_times        TYPE int1
      RETURNING
        VALUE(ro_money) TYPE REF TO yif_expression,
    plus
      IMPORTING
                io_money      TYPE REF TO yif_expression
      RETURNING VALUE(ro_sum) TYPE REF TO yif_expression.
ENDINTERFACE.
