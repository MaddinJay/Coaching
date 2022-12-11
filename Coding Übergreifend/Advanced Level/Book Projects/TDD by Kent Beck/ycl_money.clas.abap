CLASS ycl_money DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES: yif_expression.
    ALIASES reduce FOR yif_expression~reduce.
    ALIASES: currency FOR yif_expression~currency,
             get_amount FOR yif_expression~get_amount,
             equals FOR yif_expression~equals,
             times FOR yif_expression~times,
             plus FOR yif_expression~plus.

    CLASS-METHODS:
      dollar
        IMPORTING
                  iv_amount        TYPE int4
        RETURNING VALUE(ro_dollar) TYPE REF TO yif_expression,
      franc
        IMPORTING
          iv_amount       TYPE int4
        RETURNING
          VALUE(ro_franc) TYPE REF TO yif_expression.

    METHODS:
      constructor
        IMPORTING
          iv_amount   TYPE int4
          iv_currency TYPE string.

  PRIVATE SECTION.
    DATA:
      mv_amount   TYPE int4,
      mv_currency TYPE string.

ENDCLASS.

CLASS ycl_money IMPLEMENTATION.

  METHOD constructor.
    mv_amount   = iv_amount.
    mv_currency = iv_currency.
  ENDMETHOD.

  METHOD yif_expression~get_amount.
    rv_amount = mv_amount.
  ENDMETHOD.

  METHOD yif_expression~times.
    ro_money = NEW ycl_money( iv_amount = mv_amount * iv_times iv_currency = mv_currency ).
  ENDMETHOD.

  METHOD yif_expression~equals.
    rv_is_equal = xsdbool( ( mv_amount = io_money->get_amount( ) ) AND
                           ( cl_abap_classdescr=>get_class_name( me ) = cl_abap_classdescr=>get_class_name( io_money ) ) ).
  ENDMETHOD.

  METHOD yif_expression~currency.
    rv_currency = mv_currency.
  ENDMETHOD.

  METHOD dollar.
    ro_dollar = NEW ycl_money( iv_amount = iv_amount iv_currency = |USD| ).
  ENDMETHOD.

  METHOD franc.
    ro_franc = NEW ycl_money( iv_amount = iv_amount iv_currency = |CHF| ).
  ENDMETHOD.

  METHOD yif_expression~plus.
    ro_sum = NEW ycl_sum( io_augend = me io_addend = io_money ).
  ENDMETHOD.

  METHOD yif_expression~reduce.
    DATA(lv_rate) = io_bank->rate( iv_currency_from = mv_currency iv_currency_to = iv_currency ).
    ro_money = NEW ycl_money( iv_amount = mv_amount / lv_rate iv_currency = iv_currency ).
  ENDMETHOD.

ENDCLASS.
