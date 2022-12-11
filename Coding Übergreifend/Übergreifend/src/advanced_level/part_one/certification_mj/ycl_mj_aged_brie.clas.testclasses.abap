CLASS ltcl_aged_brie DEFINITION DEFERRED.
CLASS ycl_mj_aged_brie DEFINITION LOCAL FRIENDS ltcl_aged_brie.

CLASS ltcl_aged_brie DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO ycl_mj_aged_brie.
    METHODS:
      "GIVEN: Any Quality lower 50 WHEN: Update THEN: ...
      add_quality FOR TESTING,
      "GIVEN: Quality 50 WHEN: Update THEN: ...
      max_quality_reached FOR TESTING,
      "GIVEN: Any Sell In WHEN: Update THEN: ...
      subtract_sell_in FOR TESTING,
      "GIVEN: Sell In lower or equal 0 WHEN: Update THEN: ...
      add_quality_by_two FOR TESTING.
ENDCLASS.

CLASS ltcl_aged_brie IMPLEMENTATION.

  METHOD add_quality.
    "GIVEN
    DATA(lo_quality) = NEW ycl_mj_quality( 10 ).
    mo_cut = NEW ycl_mj_aged_brie( io_quality = lo_quality
                                   io_sell_in = NEW ycl_mj_sell_in( iv_sell_in = 10
                                                                    io_quality = lo_quality ) ).
    "WHEN
    mo_cut->yif_mj_item~update( ).
    "THEN
    cl_abap_unit_assert=>assert_equals( exp = 11
                                        act = mo_cut->mo_quality->get( ) ).
  ENDMETHOD.

  METHOD max_quality_reached.
    "GIVEN
    DATA(lo_quality) = NEW ycl_mj_quality( 50 ).
    mo_cut = NEW ycl_mj_aged_brie( io_quality = lo_quality
                                   io_sell_in = NEW ycl_mj_sell_in( iv_sell_in = 10
                                                                    io_quality = lo_quality ) ).
    "WHEN
    mo_cut->yif_mj_item~update( ).
    "THEN
    cl_abap_unit_assert=>assert_equals( exp = 50
                                        act = mo_cut->mo_quality->get( ) ).
  ENDMETHOD.

  METHOD subtract_sell_in.
    "GIVEN
    DATA(lo_quality) = NEW ycl_mj_quality( 10 ).
    mo_cut = NEW ycl_mj_aged_brie( io_quality = lo_quality
                                   io_sell_in = NEW ycl_mj_sell_in( iv_sell_in = 10
                                                                    io_quality = lo_quality ) ).
    "WHEN
    mo_cut->yif_mj_item~update( ).
    "THEN
    cl_abap_unit_assert=>assert_equals( exp = 9
                                        act = mo_cut->mo_sell_in->get( ) ).
  ENDMETHOD.

  METHOD add_quality_by_two.
    "GIVEN
    DATA(lo_quality) = NEW ycl_mj_quality( 10 ).
    mo_cut = NEW ycl_mj_aged_brie( io_quality = lo_quality
                                   io_sell_in = NEW ycl_mj_sell_in( iv_sell_in = 0
                                                                    io_quality = lo_quality ) ).
    "WHEN
    mo_cut->yif_mj_item~update( ).
    "THEN
    cl_abap_unit_assert=>assert_equals( exp = 12
                                        act = mo_cut->mo_quality->get( ) ).
  ENDMETHOD.

ENDCLASS.
