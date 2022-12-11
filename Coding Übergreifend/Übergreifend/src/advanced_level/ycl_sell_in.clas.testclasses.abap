CLASS ltcl_sell_in DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      decrement_sell_in_by_one     FOR TESTING,
      check_sell_in_negative_false FOR TESTING,
      check_sell_in_negative_true  FOR TESTING.
ENDCLASS.


CLASS ltcl_sell_in IMPLEMENTATION.

  METHOD decrement_sell_in_by_one.
    DATA(lo_sell_in) = NEW ycl_sell_in( 10 ).
    lo_sell_in->decrement( ).
    cl_abap_unit_assert=>assert_equals( exp = 9
                                        act = lo_sell_in->get_sell_in( ) ).
  ENDMETHOD.

  METHOD check_sell_in_negative_false.
    DATA(lo_cut) = NEW ycl_sell_in( 0 ).
    cl_abap_unit_assert=>assert_false( lo_cut->is_sell_in_negative( ) ).
  ENDMETHOD.

  METHOD check_sell_in_negative_true.
    DATA(lo_cut) = NEW ycl_sell_in( -1 ).
    cl_abap_unit_assert=>assert_true( lo_cut->is_sell_in_negative( ) ).
  ENDMETHOD.

ENDCLASS.
