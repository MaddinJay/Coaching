CLASS ycl_test_case DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_method_name TYPE string,
      run.

  PRIVATE SECTION.
    DATA:
      mv_method_name TYPE string,
      mo_was_run     TYPE REF TO ycl_was_run.

    METHODS:
      test_template_method,
      test_result,
      test_failed_result,
      test_suite,
      test_failed_result_formatting.
ENDCLASS.

CLASS ycl_test_case IMPLEMENTATION.

  METHOD constructor.
    mv_method_name = iv_method_name.
  ENDMETHOD.

  METHOD run.
    CALL METHOD me->(mv_method_name).
  ENDMETHOD.

  METHOD test_template_method.
    mo_was_run = NEW ycl_was_run( 'TEST_METHOD' ).
    DATA(lo_result) = NEW ycl_test_result( ).
    mo_was_run->run( lo_result ).
    cl_abap_unit_assert=>assert_equals( exp = 'setUp TEST_METHOD TEAR_DOWN'
                                        act = mo_was_run->mv_log ).
  ENDMETHOD.

  METHOD test_result.
    mo_was_run = NEW ycl_was_run( 'TEST_METHOD' ).
    DATA(lo_result) = NEW ycl_test_result( ).
    mo_was_run->run( lo_result ).
    cl_abap_unit_assert=>assert_equals( exp = '1 run, 0 failed'
                                        act = lo_result->summary( ) ).
  ENDMETHOD.


  METHOD test_failed_result.
    mo_was_run = NEW ycl_was_run( 'TEST_BROKEN_METHOD' ).
    DATA(lo_result) = NEW ycl_test_result( ).
    mo_was_run->run( lo_result ).
    cl_abap_unit_assert=>assert_equals( exp = '1 run, 1 failed'
                                        act = lo_result->summary( ) ).
  ENDMETHOD.

  METHOD test_failed_result_formatting.
    DATA(lo_result) = NEW ycl_test_result( ).
    lo_result->test_started( ).
    lo_result->test_failed( ).
    cl_abap_unit_assert=>assert_equals( exp = |1 run, 1 failed|
                                        act = lo_result->summary( ) ).
  ENDMETHOD.

  METHOD test_suite.
    DATA(lo_test_suite) = NEW ycl_test_suite( ).
    lo_test_suite->add( NEW ycl_was_run( 'TEST_METHOD' ) ).
    lo_test_suite->add( NEW ycl_was_run( 'TEST_BROKEN_METHOD' ) ).
    DATA(lo_result) = NEW ycl_test_result( ).
    lo_test_suite->run( lo_result ).
    cl_abap_unit_assert=>assert_equals( exp = '2 run, 1 failed'
                                        act = lo_result->summary( ) ).
  ENDMETHOD.

ENDCLASS.
