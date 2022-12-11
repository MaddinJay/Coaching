*"* use this source file for your ABAP unit test classes
CLASS ltcl_ DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS:

            one_returns_can_execute_false FOR TESTING,
            fifteen_returns_can_exec_true FOR TESTING,
            execute_returns_fizzbuzz FOR TESTING.
ENDCLASS.


CLASS ltcl_ IMPLEMENTATION.


  METHOD one_returns_can_execute_false.
    DATA: lr_mod15 TYPE REF TO zcl_fizzbuzz_range_stratmod15.
    CREATE OBJECT lr_mod15.
    cl_abap_unit_assert=>assert_false(
      EXPORTING
        act              = lr_mod15->can_execute( iv_number = 1 )

    ).
  ENDMETHOD.




  METHOD fifteen_returns_can_exec_true.
    DATA: lr_mod15 TYPE REF TO zcl_fizzbuzz_range_stratmod15.
    CREATE OBJECT lr_mod15.

    cl_abap_unit_assert=>assert_true(
      EXPORTING
        act              = lr_mod15->can_execute( iv_number = 15 )

    ).
  ENDMETHOD.

  METHOD execute_returns_fizzbuzz.
    DATA: lr_mod15 TYPE REF TO zcl_fizzbuzz_range_stratmod15.
    CREATE OBJECT lr_mod15.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  =   'FizzBuzz'  " Data Object with Expected Type
        act                  = lr_mod15->execute( ) " Data Object with Current Value

    ).
  ENDMETHOD.
ENDCLASS.
