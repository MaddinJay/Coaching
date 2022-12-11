*"* use this source file for your ABAP unit test classes
CLASS ltcl_ DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: lr_fizzbuzz_expanded TYPE REF TO ZCL_FIZZBUZZ_RANGE,
        lt_ranges TYPE RANGE OF i,
        lw_ranges LIKE LINE OF lt_ranges,
        lt_result TYPE TABLE OF zsw_fizzbuzz,
        lt_result_expected TYPE TABLE OF zsw_fizzbuzz,
        lw_result_expected TYPE zsw_fizzbuzz.
    constants: co_three type string value 'Fizz',
               co_five type string value 'Buzz'.
    METHODS:
      setup,
      number_one_returns_one FOR TESTING,
      number_three_returns_fizz FOR TESTING,
      number_five_returns_buzz for testing,
      number_fifteen_ret_fizzbuzz for testing.
ENDCLASS.


CLASS ltcl_ IMPLEMENTATION.

  METHOD number_one_returns_one.

    lw_ranges-low = 1.
    lw_ranges-option = 'EQ'.
    lw_ranges-sign = 'I'.
    APPEND lw_ranges TO lt_ranges.

    lr_fizzbuzz_expanded->zif_fizzbuzz_range~convert_number_to_fizzbuzz(
      EXPORTING
        iv_number          = lt_ranges[]
      IMPORTING
        ev_value_to_number = lt_result
    ).

    lw_result_expected-zahl = 1.
    lw_result_expected-bezeichnung = 1.
    APPEND lw_result_expected TO lt_result_expected.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  = lt_result_expected
        act                  = lt_result

    ).
  ENDMETHOD.


  METHOD number_three_returns_fizz.
    lw_ranges-low = 3.
    lw_ranges-option = 'EQ'.
    lw_ranges-sign = 'I'.
    APPEND lw_ranges TO lt_ranges.

    lr_fizzbuzz_expanded->zif_fizzbuzz_range~convert_number_to_fizzbuzz(
      EXPORTING
        iv_number          = lt_ranges[]
      IMPORTING
        ev_value_to_number = lt_result
    ).

    lw_result_expected-zahl = 3.
    lw_result_expected-bezeichnung = co_three.
    APPEND lw_result_expected TO lt_result_expected.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  = lt_result_expected
        act                  = lt_result

    ).
  ENDMETHOD.

  METHOD setup.
    CREATE OBJECT lr_fizzbuzz_expanded.
  ENDMETHOD.

  METHOD number_five_returns_buzz.
    lw_ranges-low = 5.
    lw_ranges-option = 'EQ'.
    lw_ranges-sign = 'I'.
    APPEND lw_ranges TO lt_ranges.

    lr_fizzbuzz_expanded->zif_fizzbuzz_range~convert_number_to_fizzbuzz(
      EXPORTING
        iv_number          = lt_ranges[]
      IMPORTING
        ev_value_to_number = lt_result
    ).

    lw_result_expected-zahl = 5.
    lw_result_expected-bezeichnung = co_five.
    APPEND lw_result_expected TO lt_result_expected.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  = lt_result_expected
        act                  = lt_result

    ).
  ENDMETHOD.

  METHOD number_fifteen_ret_fizzbuzz.
   lw_ranges-low = 15.
    lw_ranges-option = 'EQ'.
    lw_ranges-sign = 'I'.
    APPEND lw_ranges TO lt_ranges.

    lr_fizzbuzz_expanded->zif_fizzbuzz_range~convert_number_to_fizzbuzz(
      EXPORTING
        iv_number          = lt_ranges[]
      IMPORTING
        ev_value_to_number = lt_result
    ).

    lw_result_expected-zahl = 15.
    lw_result_expected-bezeichnung = co_three && co_five .
    APPEND lw_result_expected TO lt_result_expected.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  = lt_result_expected
        act                  = lt_result

    ).
  ENDMETHOD.
ENDCLASS.
