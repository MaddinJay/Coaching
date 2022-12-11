CLASS ltc_gilded_rose DEFINITION FINAL FOR TESTING RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    METHODS:
      foo FOR TESTING,
      foo_quality_zero FOR TESTING,
      method_age_brie FOR TESTING.
ENDCLASS.

CLASS ltc_gilded_rose IMPLEMENTATION.

  METHOD foo.
    DATA(lt_items) = VALUE ycl_gilded_rose=>tt_items( ( NEW #( iv_name    = |foo|
                                                               iv_sell_in = 10
                                                               iv_quality = 10 ) ) ).

    DATA(lo_app) = NEW ycl_gilded_rose( it_items = lt_items ).
    lo_app->update_quality( ).

    cl_abap_unit_assert=>assert_equals(
                   act = CAST ycl_item( lt_items[ 1 ] )->mv_name
                   exp = |foo| ).

    cl_abap_unit_assert=>assert_equals( exp = 9
                                        act = CAST ycl_item( lt_items[ 1 ] )->mv_quality ).
  ENDMETHOD.

  METHOD foo_quality_zero.
    DATA(lt_items) = VALUE ycl_gilded_rose=>tt_items( ( NEW #( iv_name    = |foo|
                                                             iv_sell_in = 10
                                                             iv_quality = 0 ) ) ).

    DATA(lo_app) = NEW ycl_gilded_rose( it_items = lt_items ).
    lo_app->update_quality( ).

    cl_abap_unit_assert=>assert_equals(
                   act = CAST ycl_item( lt_items[ 1 ] )->mv_name
                   exp = |foo| ).

    cl_abap_unit_assert=>assert_equals( exp = 0
                                        act = CAST ycl_item( lt_items[ 1 ] )->mv_quality ).
  ENDMETHOD.

  METHOD method_age_brie.
*    DATA(lo_age_brie) = NEW ycl_age_brie( iv_quality = 0 iv_sell_in = 10 ).


*    lo_age_brie->update( ).

    "ob es stimmt Konstelation 1.

  ENDMETHOD.

ENDCLASS.
