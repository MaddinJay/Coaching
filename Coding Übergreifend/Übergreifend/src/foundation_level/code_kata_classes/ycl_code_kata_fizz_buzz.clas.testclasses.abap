CLASS ltcl_code_kata_fizz_buzz DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
            mo_cut TYPE REF TO yif_code_kata_fizzbuzz.

    METHODS:
      result_is_4 FOR TESTING RAISING cx_static_check,
      result_is_fizz_dividable_by_3 FOR TESTING RAISING cx_static_check,
      result_is_buzz_dividable_by_5 FOR TESTING RAISING cx_static_check,
      result_fizzbuzz_dividable_15 FOR TESTING RAISING cx_static_check,
      setup.
ENDCLASS.


CLASS ltcl_code_kata_fizz_buzz IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW ycl_code_kata_fizz_buzz( ).
  ENDMETHOD.

  METHOD result_is_4.
    cl_abap_unit_assert=>assert_equals( act = mo_cut->dividable( 4 ) exp = 4 ).
  ENDMETHOD.

  METHOD result_is_fizz_dividable_by_3.
    cl_abap_unit_assert=>assert_equals( act = mo_cut->dividable( 3 ) exp = 'FIZZ' ).
  ENDMETHOD.
  METHOD result_is_buzz_dividable_by_5.
    cl_abap_unit_assert=>assert_equals( act = mo_cut->dividable( 5 ) exp = 'BUZZ' ).
  ENDMETHOD.

  METHOD result_fizzbuzz_dividable_15.
    cl_abap_unit_assert=>assert_equals( act = mo_cut->dividable( 15 ) exp = 'FIZZBUZZ' ).
  ENDMETHOD.

ENDCLASS.
