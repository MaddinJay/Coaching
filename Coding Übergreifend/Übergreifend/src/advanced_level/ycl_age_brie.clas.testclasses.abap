CLASS ltcl_age_brie DEFINITION DEFERRED.
CLASS ycl_age_brie DEFINITION LOCAL FRIENDS ltcl_age_brie.

CLASS ltcl_age_brie DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      " GIVEN: Any Sell-In (here zero) WHEN: Update THEN: ...
      decrement_sell_in_by_one FOR TESTING,
      " GIVEN: Sell-In postive WHEN: Update THEN: Sell-In >= 0 and ...
      increment_quality_by_one FOR TESTING,
      " GIVEN: Sell-In zero WHEN: Update THEN: Sell-In < 0 and ...
      increment_quality_by_two FOR TESTING,
      " GIVEN: Max. Quality (=50) and any Sell-In WHEN: Update THEN: ...
      quality_not_changed FOR TESTING.
ENDCLASS.


CLASS ltcl_age_brie IMPLEMENTATION.

  METHOD decrement_sell_in_by_one.
    DATA(lo_cut) = NEW ycl_age_brie( io_quality = NEW ycl_quality( 10 ) io_sell_in = NEW ycl_sell_in( 0 ) ).
    lo_cut->yif_item~update( ).

    cl_abap_unit_assert=>assert_equals( exp = -1
                                        act = lo_cut->mo_sell_in->get_sell_in( ) ).
  ENDMETHOD.

  METHOD increment_quality_by_one.
    DATA(lo_cut) = NEW ycl_age_brie( io_quality = NEW ycl_quality( 10 ) io_sell_in = NEW ycl_sell_in( 1 ) ).
    lo_cut->yif_item~update( ).

    cl_abap_unit_assert=>assert_equals( exp = 11
                                        act = lo_cut->mo_quality->get_quality( ) ).
  ENDMETHOD.

  METHOD increment_quality_by_two.
    DATA(lo_cut) = NEW ycl_age_brie( io_quality = NEW ycl_quality( 10 ) io_sell_in = NEW ycl_sell_in( 0 ) ).
    lo_cut->yif_item~update( ).

    cl_abap_unit_assert=>assert_equals( exp = 12
                                        act = lo_cut->mo_quality->get_quality( ) ).
  ENDMETHOD.

  METHOD quality_not_changed.
    DATA(lo_cut) = NEW ycl_age_brie( io_quality = NEW ycl_quality( 50 ) io_sell_in = NEW ycl_sell_in( 0 ) ).
    lo_cut->yif_item~update( ).

    cl_abap_unit_assert=>assert_equals( exp = 50
                                        act = lo_cut->mo_quality->get_quality( ) ).
  ENDMETHOD.

ENDCLASS.
