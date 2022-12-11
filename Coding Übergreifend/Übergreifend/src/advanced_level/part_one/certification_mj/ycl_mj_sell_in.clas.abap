CLASS ycl_mj_sell_in DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES yif_mj_sell_in.

    METHODS:
      constructor
        IMPORTING
          iv_sell_in TYPE yif_mj_sell_in=>tv_sell_in
          io_quality TYPE REF TO yif_mj_quality.

  PRIVATE SECTION.
    DATA:
      mv_sell_in TYPE yif_mj_sell_in=>tv_sell_in,
      mo_quality TYPE REF TO yif_mj_quality.

    METHODS:
      subtract,
      is_negative
        RETURNING
          VALUE(rv_is_negative) TYPE abap_bool,
      update_sell_in,
      notify_quality.
ENDCLASS.

CLASS ycl_mj_sell_in IMPLEMENTATION.

  METHOD constructor.
    mv_sell_in = iv_sell_in.
    mo_quality = io_quality.
  ENDMETHOD.

  METHOD yif_mj_sell_in~update.
    update_sell_in( ).
    notify_quality( ).
  ENDMETHOD.

  METHOD yif_mj_sell_in~get.
    rv_sell_in = mv_sell_in.
  ENDMETHOD.

  METHOD update_sell_in.
    subtract( ).
  ENDMETHOD.

  METHOD is_negative.
    rv_is_negative = boolc( mv_sell_in < 0 ).
  ENDMETHOD.

  METHOD subtract.
    mv_sell_in = mv_sell_in - 1.
  ENDMETHOD.

  METHOD notify_quality.
    CHECK is_negative( ).
    mo_quality->notify( ).
  ENDMETHOD.

ENDCLASS.
