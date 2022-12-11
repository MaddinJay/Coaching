CLASS ycl_sum DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: yif_expression.
    ALIASES reduce FOR yif_expression~reduce.

    METHODS:
      constructor
        IMPORTING
          io_augend TYPE REF TO yif_expression
          io_addend TYPE REF TO yif_expression,

      get_augend
        RETURNING
          VALUE(ro_augend) TYPE REF TO yif_expression,
      get_addend
        RETURNING
          VALUE(ro_addend) TYPE REF TO yif_expression.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      mo_augend TYPE REF TO yif_expression,
      mo_addend TYPE REF TO yif_expression.
ENDCLASS.

CLASS ycl_sum IMPLEMENTATION.

  METHOD constructor.
    mo_augend = io_augend.
    mo_addend = io_addend.
  ENDMETHOD.

  METHOD get_augend.
    ro_augend = mo_augend.
  ENDMETHOD.

  METHOD get_addend.
    ro_addend = mo_addend.
  ENDMETHOD.

  METHOD yif_expression~reduce.
    ro_money = NEW ycl_money( iv_amount   = mo_augend->reduce( io_bank = io_bank iv_currency = iv_currency )->get_amount( ) +
                                            mo_addend->reduce( io_bank = io_bank iv_currency = iv_currency )->get_amount( )
                              iv_currency = iv_currency ).
  ENDMETHOD.

ENDCLASS.
