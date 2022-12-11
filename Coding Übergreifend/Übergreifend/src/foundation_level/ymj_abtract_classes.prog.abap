REPORT ymj_abtract_classes.

CLASS lcl_stack DEFINITION ABSTRACT.
  " Stackbearbeitung
  PUBLIC SECTION.
    " Gebe Wert aus Stack zurück (Implementierung in Sub-Klassen
    METHODS return ABSTRACT
      RETURNING
        value(rv_result) TYPE numc4.
    " Setze Wert in Stack an oberster Position
    METHODS put
      IMPORTING
        iv_number TYPE numc4.

  PROTECTED SECTION.
    DATA:
      mt_stack_of_numbers TYPE STANDARD TABLE OF numc4 WITH DEFAULT KEY.

ENDCLASS.

CLASS lcl_stack IMPLEMENTATION.
  METHOD put.
    INSERT iv_number INTO mt_stack_of_numbers INDEX 1.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_stack_last_in_first_out DEFINITION
  INHERITING FROM lcl_stack.

  PUBLIC SECTION.
    METHODS return REDEFINITION.

ENDCLASS.

CLASS lcl_stack_last_in_first_out IMPLEMENTATION.

  METHOD return.
    READ TABLE mt_stack_of_numbers INTO rv_result INDEX 1.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_stack_first_in_first_out DEFINITION
  INHERITING FROM lcl_stack.

  PUBLIC SECTION.
    METHODS return REDEFINITION.

ENDCLASS.

CLASS lcl_stack_first_in_first_out IMPLEMENTATION.

  METHOD return.
    READ TABLE mt_stack_of_numbers INTO rv_result INDEX lines( mt_stack_of_numbers ).
  ENDMETHOD.
ENDCLASS.


CLASS ltcl_stack_last_in_first_out DEFINITION FOR TESTING
                 RISK LEVEL HARMLESS
                 DURATION SHORT.
  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO lcl_stack.

    METHODS:
      setup,
      " it should be ...
      return_last_added_value FOR TESTING.
ENDCLASS.

CLASS ltcl_stack_last_in_first_out IMPLEMENTATION.

  METHOD return_last_added_value.
    mo_cut->put( 1 ).
    mo_cut->put( 2 ).
    mo_cut->put( 3 ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  = '3'
        act                  = mo_cut->return( ) ).
  ENDMETHOD.

  METHOD setup.
    CREATE OBJECT mo_cut TYPE lcl_stack_last_in_first_out.
  ENDMETHOD.
ENDCLASS.

CLASS ltcl_stack_first_in_first_out DEFINITION FOR TESTING
                 RISK LEVEL HARMLESS
                 DURATION SHORT.
  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO lcl_stack.

    METHODS:
      setup,
      " it should be ...
      return_first_added_value FOR TESTING.
ENDCLASS.

CLASS ltcl_stack_first_in_first_out IMPLEMENTATION.

  METHOD return_first_added_value.
    mo_cut->put( 1 ).
    mo_cut->put( 2 ).
    mo_cut->put( 3 ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  = '1'
        act                  = mo_cut->return( ) ).
  ENDMETHOD.

  METHOD setup.
    CREATE OBJECT mo_cut TYPE lcl_stack_first_in_first_out.
  ENDMETHOD.
ENDCLASS.
