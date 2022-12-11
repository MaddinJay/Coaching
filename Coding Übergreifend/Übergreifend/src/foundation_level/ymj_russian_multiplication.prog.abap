*&---------------------------------------------------------------------*
*& Report  ZMJ_RUSSIAN_MULTIPLICATION
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT zmj_russian_multiplication NO STANDARD PAGE HEADING.

CLASS lcl_russian_multiplication DEFINITION.

  PUBLIC SECTION.
    INTERFACES zif_russian_peasant_multipl.
    ALIASES multiplicate FOR zif_russian_peasant_multipl~multiplicate.
    ALIASES print        FOR zif_russian_peasant_multipl~print.

  PROTECTED SECTION.
    TYPES: BEGIN OF ts_numbers,
             column_left TYPE int4,
             column_right TYPE int4,
           END OF ts_numbers.
    TYPES: tt_numbers TYPE STANDARD TABLE OF ts_numbers WITH NON-UNIQUE KEY column_left.
    METHODS delete_not_relevant_numbers
      CHANGING
        ct_numbers TYPE tt_numbers.

    METHODS is_left_number_dividable_by_2
      IMPORTING
        iv_number TYPE int4
      RETURNING
        value(rv_result) TYPE abap_bool.

    METHODS calculate_result
      IMPORTING
        it_numbers TYPE tt_numbers
      RETURNING
        value(rv_result) TYPE int4.

    METHODS calculate_left_number
      IMPORTING
        iv_number TYPE int4
      RETURNING
        value(rv_result) TYPE int4.

    METHODS round_off_number
      IMPORTING
        iv_number TYPE decfloat16
      RETURNING
        value(rv_result) TYPE int4.

    METHODS add_numbers_table
      CHANGING
        ct_numbers TYPE tt_numbers
      RAISING
        zcx_russian_peasant_multipl.

    METHODS continue_algorithm
      IMPORTING
        iv_number TYPE int4
      RETURNING
        value(rv_result) TYPE abap_bool.

    METHODS create_1th_line_numbers_table
      IMPORTING
        iv_number_one TYPE int4
        iv_number_two TYPE int4
      RETURNING
        value(rt_numbers_table) TYPE tt_numbers.

    METHODS check_input_numbers_are_valid
      IMPORTING
        iv_number_one TYPE int4
        iv_number_two TYPE int4
    RAISING zcx_russian_peasant_multipl.
  PRIVATE SECTION.

    METHODS calculate_right_number
      IMPORTING
        iv_number TYPE int4
      RETURNING
        value(rv_result) TYPE int4
      RAISING
        zcx_russian_peasant_multipl.
ENDCLASS.

CLASS lcl_russian_multiplication IMPLEMENTATION.
  METHOD multiplicate.

    DATA: lt_numbers TYPE tt_numbers.

    check_input_numbers_are_valid(
      iv_number_one = iv_number_one
      iv_number_two = iv_number_two ).

    lt_numbers = create_1th_line_numbers_table( iv_number_one = iv_number_one
                                                iv_number_two = iv_number_two ).

    add_numbers_table( CHANGING ct_numbers = lt_numbers ).

    delete_not_relevant_numbers( CHANGING ct_numbers = lt_numbers ).

    rv_result = calculate_result( lt_numbers ).

  ENDMETHOD.

  METHOD delete_not_relevant_numbers.
    DATA:
      ls_numbers TYPE ts_numbers,
      lv_tabix   TYPE sy-tabix.

    LOOP AT ct_numbers INTO ls_numbers.
      lv_tabix = sy-tabix.
      CHECK is_left_number_dividable_by_2( ls_numbers-column_left ) = abap_true.
      DELETE ct_numbers INDEX lv_tabix.
    ENDLOOP.
  ENDMETHOD.

  METHOD is_left_number_dividable_by_2.
    IF iv_number MOD 2 = 0.
      rv_result = abap_true.
    ELSE.
      rv_result = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD calculate_result.
    DATA:
      ls_numbers TYPE ts_numbers.

    LOOP AT it_numbers INTO ls_numbers.
      rv_result = rv_result + ls_numbers-column_right.
    ENDLOOP.

  ENDMETHOD.

  METHOD calculate_left_number.
    rv_result          = round_off_number( ( iv_number / 2 ) ).
  ENDMETHOD.

  METHOD round_off_number.
    CALL FUNCTION 'ROUND'
      EXPORTING
        decimals     = 0
        input        = iv_number
        sign         = '-'
      IMPORTING
        output       = rv_result
      EXCEPTIONS
        input_invald = 01
        overflow     = 02
        type_invalid = 03.
    IF sy-subrc <> 0.
      ##todo " Fehlerhandling
    ENDIF.
  ENDMETHOD.

  METHOD add_numbers_table.
    DATA:
      ls_numbers TYPE ts_numbers.

    LOOP AT ct_numbers INTO ls_numbers.
      CHECK continue_algorithm( ls_numbers-column_left ) = abap_true.
      ls_numbers-column_left  = calculate_left_number( ls_numbers-column_left ).
      ls_numbers-column_right = calculate_right_number( ls_numbers-column_right ).
      APPEND ls_numbers TO ct_numbers.
    ENDLOOP.
  ENDMETHOD.

  METHOD calculate_right_number.
    DATA:
      lv_msg TYPE string.
    TRY.
        rv_result = iv_number * 2.
      CATCH cx_root.
        MESSAGE i007(z_coaching_mj) INTO lv_msg.
        RAISE EXCEPTION TYPE zcx_russian_peasant_multipl
          EXPORTING
            message = lv_msg.
    ENDTRY.
  ENDMETHOD.

  METHOD continue_algorithm.
    IF iv_number > 1.
      rv_result = abap_true.
    ELSE.
      rv_result = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD create_1th_line_numbers_table.
    DATA:
      ls_numbers TYPE ts_numbers.

    ls_numbers-column_left  = iv_number_one.
    ls_numbers-column_right = iv_number_two.
    APPEND ls_numbers TO rt_numbers_table.

  ENDMETHOD.

  METHOD check_input_numbers_are_valid.

    DATA:
      lv_message TYPE string.

    IF iv_number_one <= 0.
      MESSAGE i006(z_coaching_mj) INTO lv_message WITH 'Links'.
      RAISE EXCEPTION TYPE zcx_russian_peasant_multipl
        EXPORTING
          message = lv_message.
    ENDIF.

    IF iv_number_two <= 0.
      MESSAGE i006(z_coaching_mj) INTO lv_message WITH 'Rechts'.
      RAISE EXCEPTION TYPE zcx_russian_peasant_multipl
        EXPORTING
          message = lv_message.
    ENDIF.
  ENDMETHOD.

  METHOD print.
    WRITE: 'Das Ergebnis lautet:', 30 iv_number.
  ENDMETHOD.

ENDCLASS.

CLASS ltcl_russian_multiplication DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.
  PRIVATE SECTION.
    CONSTANTS:
      cv_class_name TYPE string VALUE 'LCL_RUSSIAN_MULTIPLICATION'.
    DATA:
      go_cut TYPE REF TO zif_russian_peasant_multipl.

    METHODS:
    setup                          FOR TESTING,
    check_multiplicate_1_30        FOR TESTING,
    check_multiplicate_2_30        FOR TESTING,
    check_multiplicate_47_42       FOR TESTING,
    check_input_left_invalid       FOR TESTING,
    check_input_right_invalid      FOR TESTING,
    check_input_overload           FOR TESTING,
    check_input_left_max_number    FOR TESTING,
    check_multiplicate_3456_7898   FOR TESTING.
ENDCLASS.

CLASS ltcl_russian_multiplication IMPLEMENTATION.

  METHOD setup.
    CREATE OBJECT go_cut TYPE (cv_class_name).
  ENDMETHOD.

  METHOD check_multiplicate_1_30.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  = 30
        act                  = go_cut->multiplicate( iv_number_one = 1
                                                     iv_number_two = 30 )
    ).

  ENDMETHOD.

  METHOD check_multiplicate_2_30.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  = 60
        act                  = go_cut->multiplicate( iv_number_one = 2
                                                     iv_number_two = 30 )
    ).

  ENDMETHOD.

  METHOD check_multiplicate_47_42.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  = 1974
        act                  = go_cut->multiplicate( iv_number_one = 47
                                                     iv_number_two = 42 )
    ).

  ENDMETHOD.


  METHOD check_input_left_invalid.
    DATA:
      lo_exc     TYPE REF TO zcx_russian_peasant_multipl,
      lv_message TYPE string.
    TRY.
        go_cut->multiplicate( iv_number_one = 0
                              iv_number_two = 30 ).
      CATCH zcx_russian_peasant_multipl INTO lo_exc.
        lv_message = lo_exc->get_message( ).
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  = 'Zahl Links ist ungültig. Bitte Zahlen grösser 0 eingeben.'
        act                  = lv_message
    ).
  ENDMETHOD.

  METHOD check_input_right_invalid.
    DATA:
      lo_exc     TYPE REF TO zcx_russian_peasant_multipl,
      lv_message TYPE string.
    TRY.
        go_cut->multiplicate( iv_number_one = 1
                              iv_number_two = 0 ).
      CATCH zcx_russian_peasant_multipl INTO lo_exc.
        lv_message = lo_exc->get_message( ).
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  = 'Zahl Rechts ist ungültig. Bitte Zahlen grösser 0 eingeben.'
        act                  = lv_message
    ).
  ENDMETHOD.

  METHOD check_input_overload.
    " 2147483647 grösste Zahl in INT4
    DATA:
      lo_exc     TYPE REF TO zcx_russian_peasant_multipl,
      lv_message TYPE string.
    TRY.
        go_cut->multiplicate( iv_number_one = 2
                              iv_number_two = 2147483647 ).
      CATCH zcx_russian_peasant_multipl INTO lo_exc.
        lv_message = lo_exc->get_message( ).
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  = 'Overflow bei Berechnung Rechte Zahl in Numbers-Table.'
        act                  = lv_message
    ).
  ENDMETHOD.

  METHOD check_multiplicate_3456_7898.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  = 27295488
        act                  = go_cut->multiplicate( iv_number_one = 3456
                                                     iv_number_two = 7898 )
    ).
  ENDMETHOD.

  METHOD check_input_left_max_number.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  = 2147483647
        act                  = go_cut->multiplicate( iv_number_one = 2147483647
                                                     iv_number_two = 1 )
    ).
  ENDMETHOD.
ENDCLASS.

**********************************************************************
DATA: go_russian_multipl TYPE REF TO zif_russian_peasant_multipl,
      gv_result          TYPE int4,
      gc_class_name      TYPE string VALUE 'LCL_RUSSIAN_MULTIPLICATION',
      go_exc             TYPE REF TO zcx_russian_peasant_multipl,
      gv_message         TYPE string.

PARAMETER: p_l_no TYPE int4,
           p_r_no TYPE int4.

START-OF-SELECTION.
  CREATE OBJECT go_russian_multipl TYPE (gc_class_name).

END-OF-SELECTION.

  TRY.
      gv_result = go_russian_multipl->multiplicate( iv_number_one = p_l_no
                                                    iv_number_two = p_r_no ).
    CATCH zcx_russian_peasant_multipl INTO go_exc.  " Exception Class Russian Peasant Multipl.
      gv_message = go_exc->get_message( ).
      WRITE gv_message.
      EXIT.
  ENDTRY.

  go_russian_multipl->print( gv_result ).
