*&---------------------------------------------------------------------*
*& Report ymj_telldontask_example
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_telldontask_example.

CLASS lcl_best_of_product DEFINITION.
  PUBLIC SECTION.
    METHODS set_best_of_date
      IMPORTING
        iv_date TYPE datum.

    METHODS get_best_of_date
      RETURNING VALUE(rv_date) TYPE datum.

    METHODS set_product_name
      IMPORTING
        iv_name TYPE string.

    METHODS get_product_name
      RETURNING VALUE(rv_name) TYPE string.

    METHODS warn_is_old
      RETURNING VALUE(rv_old_text) TYPE string.

    METHODS info_is_not_old
      RETURNING
        VALUE(rv_info) TYPE string.

  PRIVATE SECTION.
    DATA mv_best_of_date TYPE datum.
    DATA mv_name TYPE string.

ENDCLASS.

CLASS lcl_best_of_product IMPLEMENTATION.

  METHOD set_best_of_date.
    mv_best_of_date = iv_date.
  ENDMETHOD.

  METHOD get_best_of_date.
    rv_date = mv_best_of_date.
  ENDMETHOD.

  METHOD get_product_name.
    rv_name = mv_name.
  ENDMETHOD.

  METHOD set_product_name.
    mv_name = iv_name.
  ENDMETHOD.

  METHOD warn_is_old.
    rv_old_text = mv_name && ' ist zu alt.'.
  ENDMETHOD.

  METHOD info_is_not_old.
    rv_info = mv_name &&' ist noch gut.'.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_ask_monitor_best_of DEFINITION.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        iv_name TYPE string
        iv_date TYPE datum.
    METHODS ask_best_of_status
      RETURNING VALUE(rv_answer) TYPE string.

  PRIVATE SECTION.
    DATA mo_best_of_product TYPE REF TO lcl_best_of_product.

    METHODS is_product_old
      RETURNING VALUE(rv_old_flag) TYPE abap_bool.

ENDCLASS.

CLASS lcl_ask_monitor_best_of IMPLEMENTATION.

  METHOD is_product_old.
    IF mo_best_of_product->get_best_of_date( ) < sy-datum.
      rv_old_flag = abap_true.
    ENDIF.
  ENDMETHOD.



  METHOD constructor.
    CREATE OBJECT mo_best_of_product.

    mo_best_of_product->set_product_name( iv_name ).
    mo_best_of_product->set_best_of_date( iv_date ).

  ENDMETHOD.

  METHOD ask_best_of_status.
    IF abap_true = is_product_old( ).                 " Erst Object fragen
      rv_answer = mo_best_of_product->warn_is_old( ). " dann Objekt erzählen, was zu tun -> Mies
    ELSE.
      rv_answer = mo_best_of_product->info_is_not_old( ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS ltcl_askmonitor DEFINITION FOR TESTING
                      RISK LEVEL HARMLESS
                      DURATION SHORT.
  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO lcl_ask_monitor_best_of.

    METHODS:
      " It should be answered ...
      product_is_too_old     FOR TESTING,
      product_is_not_too_old FOR TESTING.
ENDCLASS.

CLASS ltcl_askmonitor IMPLEMENTATION.
  METHOD product_is_not_too_old.
    DATA(mo_cut) = NEW lcl_ask_monitor_best_of( iv_date = '21991231' iv_name = 'Lecker Joghurt' ).

    cl_abap_unit_assert=>assert_equals( exp = 'Lecker Joghurt ist noch gut.' act = mo_cut->ask_best_of_status( ) ).
  ENDMETHOD.

  METHOD product_is_too_old.
    DATA(mo_cut) = NEW lcl_ask_monitor_best_of( iv_date = '20190101' iv_name = 'Oller Joghurt').

    cl_abap_unit_assert=>assert_equals( exp = 'Oller Joghurt ist zu alt.' act = mo_cut->ask_best_of_status( ) ).
  ENDMETHOD.

ENDCLASS.

SELECTION-SCREEN BEGIN OF BLOCK one.
PARAMETERS: p_name TYPE string.
PARAMETERS: p_date TYPE datum.
SELECTION-SCREEN END OF BLOCK one.

START-OF-SELECTION.

  DATA: go_ask_monitor TYPE REF TO lcl_ask_monitor_best_of,
        gv_answer      TYPE string.

  CREATE OBJECT go_ask_monitor
    EXPORTING
      iv_date = p_date
      iv_name = p_name.

  gv_answer = go_ask_monitor->ask_best_of_status( ).

  WRITE gv_answer.
