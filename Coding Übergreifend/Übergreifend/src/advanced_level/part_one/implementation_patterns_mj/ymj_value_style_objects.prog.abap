*&---------------------------------------------------------------------*
*& Report ymj_value_style_objects
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_value_style_objects.

CLASS ymj_account DEFINITION FINAL.

  PUBLIC SECTION.
    METHODS:
      add_debit
        IMPORTING
          iv_value TYPE i,
      add_credit
        IMPORTING
          iv_value TYPE i,
      value_style
        IMPORTING
                  iv_value          TYPE i
        RETURNING VALUE(ro_account) TYPE REF TO ymj_account.
  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA mv_debit TYPE i.
    DATA mv_credit TYPE i.

ENDCLASS.

CLASS ymj_account IMPLEMENTATION.

  METHOD add_credit.
    mv_credit = iv_value.
  ENDMETHOD.

  METHOD add_debit.
    mv_debit = iv_value.
  ENDMETHOD.

  METHOD value_style.
    ro_account = NEW ymj_account( ).
    ro_account->add_credit( iv_value ).
  ENDMETHOD.

ENDCLASS.

CLASS ymj_transaction DEFINITION.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_value  TYPE i
          io_credit TYPE REF TO ymj_account
          io_debit  TYPE REF TO ymj_account,
      get_value
        RETURNING VALUE(rv_value) TYPE i,
      set_value
        IMPORTING
          iv_value  TYPE i
          io_credit TYPE REF TO ymj_account.
  PRIVATE SECTION.
    DATA mv_value TYPE i.
    DATA mo_credit TYPE REF TO ymj_account.
ENDCLASS.

CLASS ymj_transaction IMPLEMENTATION.

  METHOD constructor.
    mv_value = iv_value.
    io_debit->add_debit( iv_value ).
    io_credit->add_credit( iv_value ).
  ENDMETHOD.

  METHOD get_value.
    rv_value = mv_value.
  ENDMETHOD.

  METHOD set_value.
    mv_value = iv_value.
    mo_credit = NEW ymj_account( )->value_style( iv_value ).
  ENDMETHOD.

ENDCLASS.
