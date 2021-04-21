CLASS ycl_bank DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS
      constructor.

    METHODS
      reduce
        IMPORTING
          io_expression     TYPE REF TO yif_expression
          iv_currency       TYPE string
        RETURNING
          VALUE(ro_reduced) TYPE REF TO ycl_money.

    METHODS add_rate
      IMPORTING
        iv_currency_from TYPE string
        iv_currency_to   TYPE string
        iv_rate          TYPE int4.
    METHODS rate
      IMPORTING
        iv_currency_from      TYPE string
        iv_currency_to        TYPE string
      RETURNING
        VALUE(rv_change_rate) TYPE int4.

  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES: BEGIN OF ts_rates,
             pair TYPE REF TO ycl_pair,
             rate TYPE int4,
           END OF ts_rates,
           tt_rates TYPE HASHED TABLE OF ts_rates WITH UNIQUE KEY pair.
    CONSTANTS mc_rate_default TYPE i VALUE 1.
    DATA:
      mt_rates TYPE tt_rates.

    METHODS is_change_franc_to_usd
      IMPORTING
        iv_currency_from           TYPE string
        iv_currency_to             TYPE string
      RETURNING
        VALUE(rv_change_franc2usd) TYPE abap_bool.
ENDCLASS.



CLASS ycl_bank IMPLEMENTATION.

  METHOD constructor.

  ENDMETHOD.

  METHOD reduce.
    ro_reduced = io_expression->reduce( io_bank = me iv_currency = iv_currency ).
  ENDMETHOD.

  METHOD add_rate.
    INSERT VALUE ts_rates( pair = NEW ycl_pair( iv_from = iv_currency_from iv_to = iv_currency_to )
                           rate = iv_rate )
    INTO TABLE mt_rates.
  ENDMETHOD.

  METHOD rate.
    rv_change_rate = mc_rate_default.

    DATA(lo_pair) = NEW ycl_pair( iv_from = iv_currency_from iv_to = iv_currency_to ).
    LOOP AT mt_rates INTO DATA(ls_rate).
      IF ls_rate-pair->equals( io_pair = lo_pair ).
        rv_change_rate = ls_rate-rate.
        EXIT.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD is_change_franc_to_usd.
    rv_change_franc2usd = xsdbool( iv_currency_from = |CHF| AND iv_currency_to = |USD| ).
  ENDMETHOD.

ENDCLASS.
