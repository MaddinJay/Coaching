*&---------------------------------------------------------------------*
*& Report ymj_exception_handling
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_exception_handling.

CLASS lcl_page DEFINITION.

  PUBLIC SECTION.
ENDCLASS.

CLASS lcl_page IMPLEMENTATION.

ENDCLASS.

CLASS lcl_page_handling DEFINITION.

  PUBLIC SECTION.
    METHODS:
      deletepageandallreferences
        IMPORTING
          io_page TYPE REF TO lcl_page.
  PRIVATE SECTION.
    METHODS delete
      IMPORTING
        io_page TYPE REF TO lcl_page.
    METHODS logerror
      IMPORTING
        io_dyn_check TYPE REF TO zcx_mj_dynamic_check.
ENDCLASS.

CLASS lcl_page_handling IMPLEMENTATION.

  METHOD deletepageandallreferences.
    TRY.
        delete( io_page ).
      CATCH zcx_mj_dynamic_check INTO DATA(lo_dyn_check).
        logerror( lo_dyn_check ).
    ENDTRY.
  ENDMETHOD.

  METHOD delete.
    " Do something
  ENDMETHOD.

  METHOD logerror.
    " Schreibe Log
*    mo_logger->log( io_dyn_check->get_text( ) ).
  ENDMETHOD.

ENDCLASS.
