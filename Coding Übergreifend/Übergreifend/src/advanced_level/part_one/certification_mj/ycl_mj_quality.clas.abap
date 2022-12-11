CLASS ycl_mj_quality DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES yif_mj_quality.

    METHODS:
      constructor
        IMPORTING
          iv_quality TYPE yif_mj_quality=>tv_quality.

  PRIVATE SECTION.
    CONSTANTS:
      mc_quality_maximum TYPE i VALUE 50.
    DATA:
      mv_quality TYPE yif_mj_quality=>tv_quality.
    METHODS:
      add_quality,
      is_max_not_reached
        RETURNING
          VALUE(r_result) TYPE abap_bool.
ENDCLASS.

CLASS ycl_mj_quality IMPLEMENTATION.

  METHOD constructor.
    mv_quality = iv_quality.
  ENDMETHOD.

  METHOD yif_mj_quality~update.
    add_quality( ).
  ENDMETHOD.

  METHOD add_quality.
    CHECK is_max_not_reached( ).
    mv_quality = mv_quality + 1.
  ENDMETHOD.

  METHOD is_max_not_reached.
    r_result = boolc( mv_quality < mc_quality_maximum ).
  ENDMETHOD.

  METHOD yif_mj_quality~get.
    rv_quality = mv_quality.
  ENDMETHOD.

  METHOD yif_mj_quality~notify.
    add_quality( ).
  ENDMETHOD.

ENDCLASS.
