CLASS ltcl_gilded_rose DEFINITION DEFERRED.
CLASS ycl_mj_gilded_rose DEFINITION LOCAL FRIENDS ltcl_gilded_rose.

CLASS ltcl_gilded_rose DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      update_aged_brie_success FOR TESTING.
ENDCLASS.


CLASS ltcl_gilded_rose IMPLEMENTATION.

  METHOD update_aged_brie_success.
    DATA(lo_cut) = NEW ycl_mj_gilded_rose( VALUE #( ( NEW ycl_mj_item( iv_name = |Aged Brie| iv_quality = 10 iv_sell_in = 10 ) )
                                                    ( NEW ycl_mj_item( iv_name = |Aged Brie| iv_quality = 50 iv_sell_in = 10 ) )
                                                    ( NEW ycl_mj_item( iv_name = |Aged Brie| iv_quality = 20 iv_sell_in = 0  ) ) ) ).
    lo_cut->update_quality( ).
    cl_abap_unit_assert=>assert_equals( exp = 11
                                        act = lo_cut->mt_items[ 1 ]->mv_quality ).
    cl_abap_unit_assert=>assert_equals( exp = 9
                                        act = lo_cut->mt_items[ 1 ]->mv_sell_in ).
    cl_abap_unit_assert=>assert_equals( exp = 50
                                        act = lo_cut->mt_items[ 2 ]->mv_quality ).
    cl_abap_unit_assert=>assert_equals( exp = 22
                                        act = lo_cut->mt_items[ 3 ]->mv_quality ).
  ENDMETHOD.

ENDCLASS.
