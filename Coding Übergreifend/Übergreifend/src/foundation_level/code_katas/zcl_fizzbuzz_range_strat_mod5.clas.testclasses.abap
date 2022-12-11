*"* use this source file for your ABAP unit test classes
CLASS ltcl_ DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS:

            one_returns_can_execute_false FOR TESTING,
            five_returns_can_execute_true FOR TESTING,
            execute_returns_buzz FOR TESTING.
ENDCLASS.


CLASS ltcl_ IMPLEMENTATION.


  METHOD one_returns_can_execute_false.
    DATA: lr_mod5 TYPE REF TO ZCL_FIZZBUZZ_RANGE_STRAT_MOD5.
    CREATE OBJECT lr_mod5.
    cl_abap_unit_assert=>assert_false(
      EXPORTING
        act              = lr_mod5->can_execute( iv_number = 1 )

    ).
  ENDMETHOD.




  METHOD five_returns_can_execute_true.
    DATA: lr_mod5 TYPE REF TO ZCL_FIZZBUZZ_RANGE_STRAT_MOD5.
    CREATE OBJECT lr_mod5.

    cl_abap_unit_assert=>assert_true(
      EXPORTING
        act              = lr_mod5->can_execute( iv_number = 5 )

    ).
  ENDMETHOD.

  METHOD execute_returns_buzz.
    DATA: lr_mod5 TYPE REF TO ZCL_FIZZBUZZ_RANGE_STRAT_MOD5.
    CREATE OBJECT lr_mod5.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  =   'Buzz'  " Data Object with Expected Type
        act                  = lr_mod5->execute( ) " Data Object with Current Value

    ).
  ENDMETHOD.
ENDCLASS.
