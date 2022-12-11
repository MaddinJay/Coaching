CLASS ltd_mj_quality DEFINITION FINAL FOR TESTING.

  PUBLIC SECTION.
    INTERFACES yif_mj_quality.

    METHODS:
      constructor
        IMPORTING
          iv_quality TYPE yif_mj_quality=>tv_quality.

  PRIVATE SECTION.
    DATA mv_quality TYPE yif_mj_quality=>tv_quality.

ENDCLASS.

CLASS ltd_mj_quality IMPLEMENTATION.

  METHOD yif_mj_quality~get.
    rv_quality = mv_quality.
  ENDMETHOD.

  METHOD yif_mj_quality~notify.
    IF mv_quality = 99.
      mv_quality = 100.
    ENDIF.
  ENDMETHOD.

  METHOD yif_mj_quality~update.

  ENDMETHOD.

  METHOD constructor.
    mv_quality = iv_quality.
  ENDMETHOD.

ENDCLASS.
