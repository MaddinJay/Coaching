*"* use this source file for your ABAP unit test classes
CLASS ltcl_ DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS:

            one_returns_can_execute_false FOR TESTING,
            three_returns_can_execute_true FOR TESTING,
            execute_returns_fizz FOR TESTING.
ENDCLASS.


CLASS ltcl_ IMPLEMENTATION.


  METHOD one_returns_can_execute_false.
    DATA: lr_mod3 TYPE REF TO ZCL_FIZZBUZZ_RANGE_STRAT_MOD3.
    CREATE OBJECT lr_mod3.
    cl_abap_unit_assert=>assert_false(
      EXPORTING
        act              = lr_mod3->can_execute( iv_number = 1 )

    ).
  ENDMETHOD.




  METHOD three_returns_can_execute_true.
    DATA: lr_mod3 TYPE REF TO ZCL_FIZZBUZZ_RANGE_STRAT_MOD3.
    CREATE OBJECT lr_mod3.

    cl_abap_unit_assert=>assert_true(
      EXPORTING
        act              = lr_mod3->can_execute( iv_number = 3 )

    ).
  ENDMETHOD.

  METHOD execute_returns_fizz.
    DATA: lr_mod3 TYPE REF TO ZCL_FIZZBUZZ_RANGE_STRAT_MOD3.
    CREATE OBJECT lr_mod3.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  =   'Fizz'  " Data Object with Expected Type
        act                  = lr_mod3->execute( ) " Data Object with Current Value

    ).
  ENDMETHOD.
ENDCLASS.
