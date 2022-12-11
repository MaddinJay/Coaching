*&---------------------------------------------------------------------*
*& Report ymj_pluggable_selector
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_pluggable_selector.

CLASS lcl_cut_abstract DEFINITION.
  PUBLIC SECTION.

ENDCLASS.

CLASS lcl_cut_abstract IMPLEMENTATION.

ENDCLASS.
CLASS lcl_testing DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    TYPES: tv_class TYPE REF TO lcl_cut_abstract.
    TYPES: tt_class TYPE STANDARD TABLE OF tv_class.
    DATA:
      mv_method_name TYPE string,
      mt_class_list  TYPE tt_class.

    METHODS:
      run_tests FOR TESTING.
ENDCLASS.

CLASS lcl_testing IMPLEMENTATION.

  METHOD run_tests.
    TRY.
        LOOP AT mt_class_list INTO DATA(lo_class).
          CALL METHOD lo_class->(mv_method_name).
        ENDLOOP.
      CATCH zcx_fs_as_account_printing.
        cl_abap_unit_assert=>fail( msg = 'This Error should not occurre.' ).
    ENDTRY.
  ENDMETHOD.

ENDCLASS.
