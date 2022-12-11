*&---------------------------------------------------------------------*
*& Report ymj_function_declaration
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_function_declaration.

CLASS ycl_customer DEFINITION FINAL.

  PUBLIC SECTION.
    METHODS:
      get_state
        RETURNING VALUE(rv_state) TYPE char2.
  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS ycl_customer IMPLEMENTATION.

  METHOD get_state.
  ENDMETHOD.

ENDCLASS.

CLASS ycl_check DEFINITION.

  PUBLIC SECTION.
    METHODS:
      innewengland
        IMPORTING
                  io_customer              TYPE REF TO ycl_customer
        RETURNING VALUE(rv_in_new_england) TYPE abap_bool.
  PRIVATE SECTION.
    METHODS is_state_in_new_england
      IMPORTING
        iv_state                 TYPE char2
      RETURNING
        value(rv_is_new_england) TYPE abap_bool.
ENDCLASS.

CLASS ycl_check IMPLEMENTATION.

  METHOD innewengland.
    rv_in_new_england = is_state_in_new_england( io_customer->get_state( ) ).
  ENDMETHOD.

  METHOD is_state_in_new_england.
    rv_is_new_england = xsdbool( iv_state = 'ME' ).
  ENDMETHOD.

ENDCLASS.
