CLASS ltcl_sell_in DEFINITION DEFERRED.
CLASS ycl_mj_sell_in DEFINITION LOCAL FRIENDS ltcl_sell_in.

CLASS ltcl_sell_in DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut     TYPE REF TO yif_mj_sell_in,
      mo_quality TYPE REF TO yif_mj_quality.
    METHODS:
      "GIVEN: Any Sell in WHEN: Update THEN: ...
      subtract_sell_in FOR TESTING,
      "GIVEN: Sell In lower or equal 0 WHEN: Update THEN: ...
      notify_quality FOR TESTING.
ENDCLASS.

CLASS ltcl_sell_in IMPLEMENTATION.

  METHOD subtract_sell_in.
    "GIVEN
    mo_cut = NEW ycl_mj_sell_in( iv_sell_in = 10
                                 io_quality = NEW ycl_mj_quality( 10 ) ).
    "WHEN
    mo_cut->update( ).
    "THEN
    cl_abap_unit_assert=>assert_equals( exp = 9
                                        act = mo_cut->get( ) ).
  ENDMETHOD.

  METHOD notify_quality.
    "GIVEN
    DATA(lo_cut) = NEW ycl_mj_sell_in( iv_sell_in = 0
                                 io_quality = NEW ltd_mj_quality( 99 ) ).
    "WHEN
    lo_cut->yif_mj_sell_in~update( ).
    "THEN
    cl_abap_unit_assert=>assert_equals( exp = 100
                                        act = lo_cut->mo_quality->get( ) ).
  ENDMETHOD.

ENDCLASS.
