*&---------------------------------------------------------------------*
*& Report ymj_library_class
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_library_class.

CLASS lcl_library DEFINITION FINAL.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_parameter TYPE string,
      instance_method.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_library IMPLEMENTATION.

  METHOD constructor.
    " ... do something ...
  ENDMETHOD.

  METHOD instance_method.
    " .. do something
  ENDMETHOD.

ENDCLASS.

CLASS lcl_static DEFINITION.

  PUBLIC SECTION.
*    CLASS-METHODS:
*      do_something
*        IMPORTING
*          iv_parameter TYPE string.
    METHODS:
      instance_method
        IMPORTING
          iv_parameter TYPE string.

  PRIVATE SECTION.
    CLASS-DATA mo_library TYPE REF TO lcl_library.
ENDCLASS.

CLASS lcl_static IMPLEMENTATION.

*  METHOD do_something.
*    "... mache was ...
*  ENDMETHOD.

  METHOD instance_method.
    NEW lcl_library( iv_parameter )->instance_method(  ).
  ENDMETHOD.
ENDCLASS.
