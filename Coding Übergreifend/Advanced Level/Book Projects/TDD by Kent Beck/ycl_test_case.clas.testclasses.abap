CLASS ltcl_test_case_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_test      TYPE REF TO ycl_test_case.

    METHODS test_template_method            FOR TESTING.
    METHODS test_suite                      FOR TESTING.
    METHODS test_failed_result_formatting   FOR TESTING.

ENDCLASS.

CLASS ltcl_test_case_test IMPLEMENTATION.

  METHOD test_template_method.
    mo_test = NEW #( 'TEST_TEMPLATE_METHOD' ).
    mo_test->run( ).
  ENDMETHOD.

  METHOD test_failed_result_formatting.
    mo_test = NEW #( 'TEST_FAILED_RESULT_FORMATTING' ).
    mo_test->run( ).
  ENDMETHOD.

  METHOD test_suite.
    mo_test = NEW #( 'TEST_SUITE' ).
    mo_test->run( ).
  ENDMETHOD.

ENDCLASS.
