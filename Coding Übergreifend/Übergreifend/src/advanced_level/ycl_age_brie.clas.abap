CLASS ycl_age_brie DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES yif_item.
    METHODS
      constructor
        IMPORTING
          io_quality TYPE yif_item=>to_quality
          io_sell_in TYPE yif_item=>tv_sell_in.

  PRIVATE SECTION.
    DATA:
      mo_quality TYPE yif_item=>to_quality,
      mo_sell_in TYPE yif_item=>tv_sell_in.

    METHODS:
      update_sell_in,
      update_quality.
ENDCLASS.

CLASS ycl_age_brie IMPLEMENTATION.

  METHOD constructor.
    mo_quality = io_quality.
    mo_sell_in = io_sell_in.
  ENDMETHOD.

  METHOD yif_item~update.
    update_sell_in( ).
    update_quality( ).
  ENDMETHOD.

  METHOD update_sell_in.
    mo_sell_in->decrement( ).
  ENDMETHOD.

  METHOD update_quality.
    mo_quality->increase_quality( ).
    CHECK mo_sell_in->is_sell_in_negative( ).
    mo_quality->increase_quality( ).
  ENDMETHOD.

ENDCLASS.
