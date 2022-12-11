CLASS ycl_sell_in DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_sell_in TYPE i,

      "! Get Sell-In Parameter
      "! @parameter r_result |
      get_sell_in
        RETURNING
          VALUE(r_result) TYPE i,
      "! Decrement Sell-In by One
      decrement,

      "! Check if Sell-In is negative
      "! @parameter rv_is_negative |
      is_sell_in_negative
        RETURNING
          VALUE(rv_is_negative) TYPE abap_bool.

  PRIVATE SECTION.
    DATA:
      mv_sell_in TYPE i.

ENDCLASS.

CLASS ycl_sell_in IMPLEMENTATION.

  METHOD constructor.
    mv_sell_in = iv_sell_in.
  ENDMETHOD.

  METHOD get_sell_in.
    r_result = me->mv_sell_in.
  ENDMETHOD.

  METHOD decrement.
    mv_sell_in = mv_sell_in - 1.
  ENDMETHOD.

  METHOD is_sell_in_negative.
    rv_is_negative = xsdbool( mv_sell_in < 0 ).
  ENDMETHOD.

ENDCLASS.
