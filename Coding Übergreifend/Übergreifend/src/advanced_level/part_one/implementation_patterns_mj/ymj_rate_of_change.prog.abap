*&---------------------------------------------------------------------*
*& Report ymj_rate_of_change
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_rate_of_change.

CLASS lcl_money DEFINITION.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_value    TYPE curr13_2
          iv_currency TYPE currency.

  PRIVATE SECTION.
    DATA:
      mv_value    TYPE curr13_2,
      mv_currency TYPE currency.

ENDCLASS.

CLASS lcl_money IMPLEMENTATION.

  METHOD constructor.
    mv_value = iv_value.
    mv_currency = iv_currency.
  ENDMETHOD.

ENDCLASS.

CLASS lmj_rate_of_change DEFINITION.

  PUBLIC SECTION.
    METHODS:
      set_amount
        IMPORTING
          io_money TYPE REF TO lcl_money.
  PRIVATE SECTION.
    DATA:
      mo_money TYPE REF TO lcl_money.
ENDCLASS.

CLASS lmj_rate_of_change IMPLEMENTATION.
  METHOD set_amount.
    mo_money = io_money.
*    mv_money = NEW lcl_money( iv_value    = iv_value
*                              iv_currency = iv_currency ).
  ENDMETHOD.

ENDCLASS.
