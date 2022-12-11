*&---------------------------------------------------------------------*
*& Report ymj_inner_class
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_inner_class.

CLASS lcl_inner DEFINITION.

  PUBLIC SECTION.
    METHODS:
      example
        RETURNING VALUE(rv_string) TYPE string.

ENDCLASS.

CLASS lcl_inner IMPLEMENTATION.

  METHOD example.
    rv_string = mv_field.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_innerclass DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  PUBLIC SECTION.
    DATA: mo_inner TYPE REF TO lcl_inner.
    METHODS:
      passes FOR TESTING.

  PRIVATE SECTION.
    DATA: mv_field TYPE string.
ENDCLASS.

CLASS lcl_innerclass IMPLEMENTATION.

  METHOD passes.
    mv_field = 'abc'.
    mo_inner = NEW lcl_inner( ).
    cl_abap_unit_assert=>assert_equals( exp = 'abc' act = mo_inner->example( ) ).
  ENDMETHOD.

ENDCLASS.
