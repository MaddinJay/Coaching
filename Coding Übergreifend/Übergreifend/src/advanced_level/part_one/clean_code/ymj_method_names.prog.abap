*&---------------------------------------------------------------------*
*& Report ymj_method_names
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_method_names.

CLASS lcl_employee DEFINITION.
  PUBLIC SECTION.
    METHODS:
      get_name
        RETURNING VALUE(rv_name) TYPE string,
      set_name
        IMPORTING
          iv_name TYPE string,
      is_posted
        RETURNING
          VALUE(rv_is_posted) TYPE abap_bool.
ENDCLASS.

CLASS lcl_employee IMPLEMENTATION.

  METHOD get_name.

  ENDMETHOD.

  METHOD set_name.

  ENDMETHOD.


  METHOD is_posted.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_complex DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      from_real_number
        IMPORTING
                  iv_real_number   TYPE dec23_2
        RETURNING VALUE(rv_number) TYPE float.

ENDCLASS.

CLASS lcl_complex IMPLEMENTATION.

  METHOD from_real_number.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA(lo_employee) = NEW lcl_employee( ).
  DATA(lv_name) = lo_employee->get_name( ).
  lo_employee->set_name( 'Gerd' ).
  IF lo_employee->is_posted( ).
    DATA(lv_fulscrum_point) = lcl_complex=>from_real_number( '23.0' ).
  ENDIF.
