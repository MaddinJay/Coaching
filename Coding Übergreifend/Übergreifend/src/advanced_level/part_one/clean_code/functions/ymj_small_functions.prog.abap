*&---------------------------------------------------------------------*
*& Report ymj_small_functions
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_small_functions.

CLASS lcl_pagedata DEFINITION.

  PUBLIC SECTION.
    METHODS:
      gethtml
        RETURNING VALUE(rv_html) TYPE string.

ENDCLASS.

CLASS lcl_pagedata IMPLEMENTATION.

  METHOD gethtml.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_webpage DEFINITION.

  PUBLIC SECTION.
    CLASS-METHODS:
      render_withsetupsandteardowns
        IMPORTING
          io_pagedata    TYPE REF TO lcl_pagedata
          iv_issuite     TYPE abap_bool
        RETURNING
          VALUE(rv_html) TYPE string
        RAISING
          zcx_mj_dynamic_check.

  PRIVATE SECTION.
    CLASS-METHODS:
      is_testpage
        IMPORTING
          io_pagedata           TYPE REF TO lcl_pagedata
        RETURNING
          VALUE(rv_is_testpage) TYPE abap_bool,
      includesetupandteardownpages
        IMPORTING
          io_pagedata TYPE REF TO lcl_pagedata
          iv_issuite  TYPE abap_bool.

ENDCLASS.

CLASS lcl_webpage IMPLEMENTATION.

  METHOD render_withsetupsandteardowns.
    IF is_testpage( io_pagedata ).
      includesetupandteardownpages( io_pagedata = io_pagedata
                                    iv_issuite  = iv_issuite ).
    ENDIF.
    rv_html = io_pagedata->gethtml( ).
  ENDMETHOD.

  METHOD is_testpage.

  ENDMETHOD.

  METHOD includesetupandteardownpages.

  ENDMETHOD.

ENDCLASS.
