*&---------------------------------------------------------------------*
*& Report ycl_encapsulate_variable
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ycl_encapsulate_variable.

CLASS ycl_owner_data DEFINITION FINAL.

  PUBLIC SECTION.
    DATA:
      mv_first_name TYPE string,
      mv_last_name  TYPE string.
  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS ycl_owner_data IMPLEMENTATION.

ENDCLASS.



CLASS ycl_person DEFINITION FINAL.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          io_owner TYPE REF TO ycl_owner_data.

  PRIVATE SECTION.
    DATA mv_first_name TYPE string.
    DATA mv_last_name TYPE string.

ENDCLASS.

CLASS ycl_person IMPLEMENTATION.

  METHOD constructor.
    mv_first_name = io_owner->mv_first_name.
    mv_last_name  = io_owner->mv_last_name.
  ENDMETHOD.

ENDCLASS.

CLASS ycl_spaceship DEFINITION FINAL.

  PUBLIC SECTION.
    DATA:
      mv_owner TYPE string.

ENDCLASS.

CLASS ycl_spaceship IMPLEMENTATION.

ENDCLASS.



CLASS ycl_owner DEFINITION.
  PUBLIC SECTION.

    METHODS:
      main.

  PRIVATE SECTION.
    DATA:
      mo_spaceship          TYPE REF TO ycl_spaceship,
      mv_default_owner_data TYPE string.
    METHODS set_default_owner
      IMPORTING
        iv_owner TYPE string.
    METHODS default_owner
      RETURNING
        VALUE(rv_owner) TYPE string. " Kopie des Wertes (Funktionaler Aufruf)
ENDCLASS.

CLASS ycl_owner IMPLEMENTATION.

  METHOD main.
    set_default_owner( |First Name: Martin, Last Name: Jonen| ).

    mo_spaceship->mv_owner = default_owner( ).
  ENDMETHOD.

  METHOD set_default_owner.
    mv_default_owner_data = iv_owner.
  ENDMETHOD.

  METHOD default_owner.
    rv_owner = mv_default_owner_data.
  ENDMETHOD.

ENDCLASS.
