CLASS ycl_mj_aged_brie DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES yif_mj_item.

    METHODS:
      constructor
        IMPORTING
          io_quality TYPE REF TO yif_mj_quality
          io_sell_in TYPE REF TO yif_mj_sell_in.

  PRIVATE SECTION.
    DATA:
      mo_quality TYPE REF TO yif_mj_quality,
      mo_sell_in TYPE REF TO yif_mj_sell_in.

ENDCLASS.

CLASS ycl_mj_aged_brie IMPLEMENTATION.

  METHOD constructor.
    mo_quality = io_quality.
    mo_sell_in = io_sell_in.
  ENDMETHOD.

  METHOD yif_mj_item~update.
    mo_quality->update( ).
    mo_sell_in->update( ).
  ENDMETHOD.

ENDCLASS.
