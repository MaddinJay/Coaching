CLASS ltcl_quality DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      increase_quality_by_one FOR TESTING,
      quality_max_reached     FOR TESTING.

ENDCLASS.

CLASS ltcl_quality IMPLEMENTATION.

  METHOD increase_quality_by_one.
    DATA(lo_quality) = NEW ycl_quality( 10 ).
    lo_quality->increase_quality( ).
    cl_abap_unit_assert=>assert_equals( exp = 11
                                        act = lo_quality->get_quality( ) ).
  ENDMETHOD.


  METHOD quality_max_reached.
    DATA(lo_quality) = NEW ycl_quality( 50 ).
    lo_quality->increase_quality( ).
    cl_abap_unit_assert=>assert_equals( exp = 50
                                        act = lo_quality->get_quality( ) ).
  ENDMETHOD.

ENDCLASS.
