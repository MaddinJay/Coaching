*&---------------------------------------------------------------------*
*& Report ymj_telldontask_example_tell
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_telldontask_example_tell.

CLASS lcl_tellmonitor_best_of DEFINITION FINAL.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        iv_name TYPE string
        iv_date TYPE datum.

    METHODS tell_best_of_status
      RETURNING
        VALUE(rv_answer) TYPE string.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA:
      mv_name TYPE string,
      mv_date TYPE datum.
    METHODS is_product_old
      RETURNING
        VALUE(rv_is_old) TYPE abap_bool.
    METHODS set_answer_product_is_good
      RETURNING
        VALUE(rv_answer) TYPE string.
    METHODS set_answer_product_is_too_old
      RETURNING
        VALUE(rv_answer) TYPE string.
ENDCLASS.

CLASS lcl_tellmonitor_best_of IMPLEMENTATION.

  METHOD constructor.
    mv_name = iv_name.
    mv_date = iv_date.
  ENDMETHOD.


  METHOD tell_best_of_status.
    IF is_product_old( ) = abap_false.
      rv_answer = set_answer_product_is_good( ).
    ELSE.
      rv_answer = set_answer_product_is_too_old( ).
    ENDIF.
  ENDMETHOD.


  METHOD is_product_old.
    rv_is_old = boolc( mv_date < sy-datum ).
  ENDMETHOD.


  METHOD set_answer_product_is_good.
    rv_answer = mv_name && ' ist noch frisch'.
  ENDMETHOD.


  METHOD set_answer_product_is_too_old.
    rv_answer = mv_name && ' ist zu alt'.
  ENDMETHOD.

ENDCLASS.

CLASS ltcl_tellmonitor_best_of DEFINITION
                               FOR TESTING
                               DURATION SHORT
                               RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    METHODS:
      " it should be answered ...
      product_is_not_too_old FOR TESTING,
      product_is_too_old     FOR TESTING.
ENDCLASS.

CLASS ltcl_tellmonitor_best_of IMPLEMENTATION.
  METHOD product_is_not_too_old.
    DATA(mo_cut) = NEW lcl_tellmonitor_best_of( iv_name = 'Joghurt' iv_date = '21991231' ).
    cl_abap_unit_assert=>assert_equals( exp = 'Joghurt ist noch frisch' act = mo_cut->tell_best_of_status( ) ).

  ENDMETHOD.

  METHOD product_is_too_old.
    DATA(mo_cut) = NEW lcl_tellmonitor_best_of( iv_name = 'Joghurt' iv_date = '20190101' ).
    cl_abap_unit_assert=>assert_equals( exp = 'Joghurt ist zu alt' act = mo_cut->tell_best_of_status( ) ).

  ENDMETHOD.

ENDCLASS.
