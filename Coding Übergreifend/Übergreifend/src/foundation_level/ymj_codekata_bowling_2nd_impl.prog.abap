*&---------------------------------------------------------------------*
*& Report ymj_codekata_bowling_2nd_impl
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_codekata_bowling_2nd_impl.

CLASS lx_bowling DEFINITION INHERITING FROM cx_static_check.
  PUBLIC SECTION.
    INTERFACES: yif_message_mj.
    ALIASES get_message FOR yif_message_mj~get_message.

    METHODS constructor
      IMPORTING
        iv_textid   LIKE textid   OPTIONAL
        iv_previous LIKE previous OPTIONAL
        iv_message  TYPE string   OPTIONAL.

  PRIVATE SECTION.
    DATA: mv_message TYPE string.
ENDCLASS.

CLASS lx_bowling IMPLEMENTATION.
  METHOD yif_message_mj~get_message.
    rv_message = mv_message.
  ENDMETHOD.

  METHOD constructor.
    super->constructor(
      EXPORTING
        textid   = iv_textid
        previous = iv_previous
    ).
    mv_message = iv_message.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_frame DEFINITION.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        iv_previous_frame TYPE REF TO lcl_frame OPTIONAL.
    METHODS get_score
      RETURNING
        VALUE(rv_score) TYPE i.
    METHODS add_roll
      IMPORTING
                iv_roll_count TYPE i
      RAISING   lx_bowling.

  PRIVATE SECTION.
    TYPES: BEGIN OF ts_pins_rolled,
             first_roll  TYPE i,
             second_roll TYPE i,
             third_roll  TYPE i,
           END OF ts_pins_rolled.

    DATA:
      ms_pins_rolled    TYPE ts_pins_rolled,
      mv_score          TYPE i,
      mo_previous_frame TYPE REF TO lcl_frame,
      mv_roll_number    TYPE i.

    METHODS add_roll_to_score
      IMPORTING
        iv_roll_count TYPE i.
    METHODS set_first_roll
      IMPORTING
        iv_roll_count TYPE i
      RAISING
        lx_bowling.
    METHODS set_second_roll
      IMPORTING
        iv_roll_count TYPE i
      RAISING
        lx_bowling.
    METHODS set_extra_roll
      IMPORTING
        iv_roll_count TYPE i
      RAISING
        lx_bowling.
    METHODS add_roll_for_spare
      IMPORTING
        iv_roll_count TYPE i.
    METHODS add_roll_for_strike
      IMPORTING
        iv_roll_count TYPE i.
    METHODS add_roll_for_pre_strike
      IMPORTING
        iv_roll_count TYPE i.
    METHODS is_strike
      IMPORTING
                iv_roll_count       TYPE i
      RETURNING VALUE(rv_is_strike) TYPE abap_bool.
    METHODS frame_is_strike
      RETURNING
        VALUE(rv_frame_is_strike) TYPE abap_bool.
    METHODS roll_is_strike
      IMPORTING
        iv_roll_count            TYPE i
      RETURNING
        VALUE(rv_roll_is_strike) TYPE abap_bool.
    METHODS close_pre_frame_if_strike
      RAISING
        lx_bowling.
    METHODS is_first_roll_of_frame
      RETURNING VALUE(rv_is_first_roll) TYPE abap_bool.
    METHODS frame_is_spare
      RETURNING
        VALUE(rv_frame_is_spare) TYPE abap_bool.
    METHODS is_second_roll_of_frame
      RETURNING
        VALUE(rv_is_second_roll) TYPE abap_bool.
    METHODS set_extra_roll_last_frame
      IMPORTING
        iv_roll_count TYPE i
      RAISING
        lx_bowling.
    METHODS am_i_last_frame
      RETURNING
        VALUE(rv_i_am_last_frame) TYPE abap_bool.
    METHODS set_third_roll
      IMPORTING
        iv_roll_count TYPE i
      RAISING
        lx_bowling.
    METHODS is_third_roll_of_frame
      RETURNING
        VALUE(rv_is_third_roll) TYPE abap_bool.
    METHODS set_extra_roll_pre_frames
      IMPORTING
        iv_roll_count TYPE i
      RAISING
        lx_bowling.
    METHODS set_roll
      IMPORTING
        iv_roll_count TYPE i
      RAISING
        lx_bowling.
    METHODS set_bonus_rolls_last_frame
      IMPORTING
        iv_roll_count TYPE i
      RAISING
        lx_bowling.
    METHODS check_close_frame
      RAISING
        lx_bowling.
    METHODS second_roll_of_frame
      RETURNING
        VALUE(rv_is_second_roll) TYPE abap_bool.
    METHODS set_roll_number.
    METHODS set_bonus_for_strike
      IMPORTING
        iv_roll_count TYPE i
      RAISING
        lx_bowling.
    METHODS set_bonus_for_spare
      IMPORTING
        iv_roll_count TYPE i
      RAISING
        lx_bowling.
    METHODS close_pre_frame_if_full
      RAISING
        lx_bowling.
    METHODS close_last_frame
      RAISING
        lx_bowling.
    METHODS close_pre_frames
      RAISING
        lx_bowling.
    METHODS is_max_roll_numer
      RETURNING
        VALUE(rv_is_max_roll_number) TYPE abap_bool.
ENDCLASS.

CLASS lcl_frame IMPLEMENTATION.

  METHOD get_score.
    rv_score = mv_score.
  ENDMETHOD.


  METHOD add_roll.
    set_roll_number( ).
    set_roll( iv_roll_count ).
    set_extra_roll( iv_roll_count ).
    check_close_frame( ).
  ENDMETHOD.

  METHOD set_second_roll.
    CHECK second_roll_of_frame( ) = abap_true.
    ms_pins_rolled-second_roll = iv_roll_count.
    add_roll_to_score( iv_roll_count ).
  ENDMETHOD.

  METHOD add_roll_to_score.
    ##TODO " Spaces einheitlich
    mv_score = mv_score + iv_roll_count.
  ENDMETHOD.

  METHOD set_first_roll.
    CHECK is_first_roll_of_frame(  ) = abap_true.
    ms_pins_rolled-first_roll = iv_roll_count.
    add_roll_to_score( iv_roll_count ).
  ENDMETHOD.

  METHOD set_extra_roll.
    set_extra_roll_last_frame( iv_roll_count ).
    set_extra_roll_pre_frames( iv_roll_count ).
  ENDMETHOD.

  METHOD constructor.
    CHECK iv_previous_frame IS SUPPLIED.
    mo_previous_frame = iv_previous_frame.
  ENDMETHOD.


  METHOD add_roll_for_spare.
    CHECK frame_is_spare( ) = abap_true.
    add_roll_to_score( iv_roll_count ).
  ENDMETHOD.


  METHOD add_roll_for_strike.
    CHECK me->frame_is_strike( ) = abap_true.
    me->add_roll_to_score( iv_roll_count ).
    me->add_roll_for_pre_strike( iv_roll_count ).

  ENDMETHOD.

  METHOD add_roll_for_pre_strike.
    CHECK mo_previous_frame IS BOUND.
    CHECK mo_previous_frame->mv_score <= 20.
    mo_previous_frame->add_roll_to_score( iv_roll_count ).
  ENDMETHOD.


  METHOD is_strike.
    rv_is_strike = boolc( iv_roll_count = 10 ).
  ENDMETHOD.


  METHOD frame_is_strike.
    rv_frame_is_strike = boolc( ms_pins_rolled-first_roll = 10 ).
  ENDMETHOD.


  METHOD roll_is_strike.
    rv_roll_is_strike = boolc( iv_roll_count = 10 ).
  ENDMETHOD.


  METHOD close_pre_frame_if_strike.
    IF frame_is_strike( ) = abap_true AND
       am_i_last_frame( ) = abap_false.
      RAISE EXCEPTION TYPE lx_bowling.
    ENDIF.
  ENDMETHOD.


  METHOD is_first_roll_of_frame.
    rv_is_first_roll = boolc( mv_roll_number = 1 ).
  ENDMETHOD.


  METHOD frame_is_spare.
    rv_frame_is_spare = boolc( ms_pins_rolled-first_roll <> 0 AND ms_pins_rolled-second_roll <> 0 AND
       (  mv_score = 10 ) ).
  ENDMETHOD.


  METHOD is_second_roll_of_frame.
    rv_is_second_roll = boolc( ms_pins_rolled-first_roll <> 0 AND ms_pins_rolled-second_roll = 0 ).
  ENDMETHOD.


  METHOD set_extra_roll_last_frame.
    CHECK am_i_last_frame( ) = abap_true.

    set_bonus_rolls_last_frame( iv_roll_count ).
    CHECK mv_roll_number <= 2.
    mo_previous_frame->add_roll_for_strike( iv_roll_count ).
  ENDMETHOD.


  METHOD am_i_last_frame.
    DATA: lv_count TYPE i.

    DATA(lo_previous_frame) = mo_previous_frame.
    WHILE lo_previous_frame IS BOUND.
      lo_previous_frame = lo_previous_frame->mo_previous_frame.
      lv_count = lv_count + 1.
    ENDWHILE.
    rv_i_am_last_frame = boolc( lv_count = 9 ).

  ENDMETHOD.


  METHOD set_third_roll.
    CHECK is_third_roll_of_frame( ) = abap_true.
    ms_pins_rolled-third_roll = iv_roll_count.
    add_roll_to_score( iv_roll_count ).
  ENDMETHOD.


  METHOD is_third_roll_of_frame.
    rv_is_third_roll = boolc( mv_roll_number = 3 ).
  ENDMETHOD.


  METHOD set_extra_roll_pre_frames.
    CHECK am_i_last_frame( ) = abap_false.

    CHECK mo_previous_frame IS BOUND.
    mo_previous_frame->add_roll_for_spare( iv_roll_count ).
    mo_previous_frame->add_roll_for_strike( iv_roll_count ).
  ENDMETHOD.


  METHOD set_roll.
    set_first_roll( iv_roll_count ).

    CHECK frame_is_strike( ) = abap_false.
    set_second_roll( iv_roll_count ).
  ENDMETHOD.


  METHOD set_bonus_rolls_last_frame.
    set_bonus_for_strike( iv_roll_count ).
    set_bonus_for_spare( iv_roll_count ).
  ENDMETHOD.


  METHOD check_close_frame.
    close_pre_frames( ).
    close_last_frame( ).
  ENDMETHOD.

  METHOD close_pre_frames.
    close_pre_frame_if_strike( ).
    close_pre_frame_if_full( ).
  ENDMETHOD.

  METHOD second_roll_of_frame.
    rv_is_second_roll = boolc( mv_roll_number = 2 ).
  ENDMETHOD.


  METHOD set_roll_number.
    mv_roll_number = mv_roll_number + 1.
  ENDMETHOD.

  METHOD set_bonus_for_strike.
    CHECK frame_is_strike( ) = abap_true.

    set_second_roll( iv_roll_count ).
    set_third_roll( iv_roll_count ).

  ENDMETHOD.


  METHOD set_bonus_for_spare.
    CHECK frame_is_spare( ) = abap_true.
    set_third_roll( iv_roll_count ).

  ENDMETHOD.


  METHOD close_pre_frame_if_full.
    CHECK am_i_last_frame( ) = abap_false AND
          mv_roll_number = 2.
    RAISE EXCEPTION TYPE lx_bowling. " Frame voll -> Abbruch
  ENDMETHOD.


  METHOD close_last_frame.
    CHECK am_i_last_frame( ) = abap_true AND
          is_max_roll_numer( ) = abap_true.
    RAISE EXCEPTION TYPE lx_bowling. " Frame voll -> Abbruch
  ENDMETHOD.


  METHOD is_max_roll_numer.
    rv_is_max_roll_number = boolc( mv_roll_number = 3 ).
  ENDMETHOD.

ENDCLASS.

CLASS lcl_game DEFINITION.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        iv_previous_frame TYPE any OPTIONAL.
    "! Hauptfunktion: Setzt die Pins im Frame
    METHODS add_roll
      IMPORTING
                iv_roll_count TYPE i
      RAISING   lx_bowling.
    "! Gibt den Score des Spiels wieder
    METHODS total_score
      RETURNING VALUE(rv_total_score) TYPE i.

    METHODS over
      RETURNING VALUE(rv_is_over) TYPE abap_bool.

  PRIVATE SECTION.
    DATA:
      mt_frames       TYPE STANDARD TABLE OF REF TO lcl_frame,
      mo_actual_frame TYPE REF TO lcl_frame.
    METHODS close_frame.
    METHODS is_strike
      IMPORTING
                iv_roll_count       TYPE i
      RETURNING VALUE(rv_is_strike) TYPE abap_bool.
    METHODS frame_is_last_frame
      RETURNING
        VALUE(rv_is_last_frame) TYPE abap_bool.
    METHODS check_game_closed
      RAISING
        lx_bowling.

ENDCLASS.

CLASS lcl_game IMPLEMENTATION.
  METHOD add_roll.
    check_game_closed( ).

    TRY.
        mo_actual_frame->add_roll( iv_roll_count ).
      CATCH lx_bowling.
        close_frame( ).
    ENDTRY.
  ENDMETHOD.

  METHOD close_frame.
    APPEND mo_actual_frame TO mt_frames.
    mo_actual_frame = NEW lcl_frame( mo_actual_frame ).
  ENDMETHOD.



  METHOD total_score.
    LOOP AT mt_frames INTO DATA(lo_frame).
      rv_total_score = rv_total_score + lo_frame->get_score( ).
    ENDLOOP.
    rv_total_score = rv_total_score + mo_actual_frame->get_score( ).
  ENDMETHOD.

  METHOD over.

  ENDMETHOD.

  METHOD constructor.
    mo_actual_frame = NEW lcl_frame( ).
  ENDMETHOD.


  METHOD is_strike.
    rv_is_strike = boolc( iv_roll_count = 10 ).
  ENDMETHOD.


  METHOD frame_is_last_frame.
    rv_is_last_frame = boolc( lines( mt_frames ) = 9 ).
  ENDMETHOD.


  METHOD check_game_closed.
    IF lines( mt_frames ) = 10.
      RAISE EXCEPTION TYPE lx_bowling
        EXPORTING
          iv_message = 'Spiel ist geschlossen!'.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
**********************************************************************
CLASS ltcl_game DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT
                INHERITING FROM lcl_game.
  PRIVATE SECTION.
    DATA: mo_cut TYPE REF TO lcl_game.

    METHODS:
      setup,

      " It should be added ...
      first_roll_to_first_frame         FOR TESTING,
      second_roll_to_first_frame        FOR TESTING,
      first_roll_to_second_frame        FOR TESTING,
      first_roll_after_spare            FOR TESTING,
      first_roll_after_strike           FOR TESTING,
      strike_after_strike               FOR TESTING,
      three_strikes_afterwards          FOR TESTING,
      four_strikes_afterwards           FOR TESTING,
      spare_after_strike                FOR TESTING,
      " It should be ...
      finished_game_with_strikes        FOR TESTING,
      finished_game_with_spare          FOR TESTING,
      raise_exception_if_game_closed    FOR TESTING.
ENDCLASS.

CLASS ltcl_game IMPLEMENTATION.
  METHOD setup.
    mo_cut = NEW lcl_game( ).
  ENDMETHOD.

  METHOD first_roll_to_first_frame.
    TRY.
        mo_cut->add_roll( iv_roll_count = 5 ).
      CATCH lx_bowling.
    ENDTRY.
    ##TODO "Exporting eleimieren und Spaces wegräumen
    cl_aunit_assert=>assert_equals( exp = 5 act = mo_cut->total_score( ) ).

  ENDMETHOD.

  METHOD second_roll_to_first_frame.
    TRY.
        mo_cut->add_roll( iv_roll_count = 5 ).
        mo_cut->add_roll( iv_roll_count = 4 ).
      CATCH lx_bowling.
    ENDTRY.

    cl_aunit_assert=>assert_equals(
      EXPORTING
        exp                  = 9
        act                  = mo_cut->total_score( )
    ).

  ENDMETHOD.

  METHOD first_roll_to_second_frame.
    TRY.
        mo_cut->add_roll( iv_roll_count = 5 ).
        mo_cut->add_roll( iv_roll_count = 4 ).
        mo_cut->add_roll( iv_roll_count = 5 ).
      CATCH lx_bowling.
    ENDTRY.

    cl_aunit_assert=>assert_equals(
      EXPORTING
        exp                  = 14
        act                  = mo_cut->total_score( )
    ).
  ENDMETHOD.

  METHOD first_roll_after_spare.
    TRY.
        mo_cut->add_roll( iv_roll_count = 5 ).
        mo_cut->add_roll( iv_roll_count = 5 ). " Spare -> Next Roll is counted double
        mo_cut->add_roll( iv_roll_count = 5 ).
      CATCH lx_bowling.
    ENDTRY.

    cl_aunit_assert=>assert_equals(
      EXPORTING
        exp                  = 20
        act                  = mo_cut->total_score( )
    ).
  ENDMETHOD.

  METHOD first_roll_after_strike.
    TRY.
        mo_cut->add_roll( iv_roll_count = 10 ). " Strike -> Next Roll is counted double
        mo_cut->add_roll( iv_roll_count = 5 ).
      CATCH lx_bowling.
    ENDTRY.
    cl_aunit_assert=>assert_equals(
      EXPORTING
        exp                  = 20
        act                  = mo_cut->total_score( )
    ).
  ENDMETHOD.

  METHOD strike_after_strike.
    TRY.
        mo_cut->add_roll( iv_roll_count = 10 ). " Strike -> Next Roll is counted double
        mo_cut->add_roll( iv_roll_count = 10 ).
      CATCH lx_bowling.
    ENDTRY.
    cl_aunit_assert=>assert_equals(
      EXPORTING
        exp                  = 30
        act                  = mo_cut->total_score( )
    ).
  ENDMETHOD.

  METHOD three_strikes_afterwards.
    TRY.
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 20 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 10 Points
      CATCH lx_bowling.
    ENDTRY.

    cl_aunit_assert=>assert_equals(
      EXPORTING
        exp                  = 60
        act                  = mo_cut->total_score( )
    ).
  ENDMETHOD.

  METHOD four_strikes_afterwards.
    TRY.
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 20 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 10 Points
      CATCH lx_bowling.
    ENDTRY.
    cl_aunit_assert=>assert_equals(
      EXPORTING
        exp                  = 90
        act                  = mo_cut->total_score( )
    ).
  ENDMETHOD.

  METHOD spare_after_strike.
    TRY.
        mo_cut->add_roll( iv_roll_count = 10 ). " 25 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 20 Points
        mo_cut->add_roll( iv_roll_count = 5 ).  " 10 Points
        mo_cut->add_roll( iv_roll_count = 5 ).
      CATCH lx_bowling.
    ENDTRY.
    cl_aunit_assert=>assert_equals(
      EXPORTING
        exp                  = 55
        act                  = mo_cut->total_score( )
    ).
  ENDMETHOD.

  METHOD finished_game_with_strikes.
    TRY.
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        " Last to shots
        mo_cut->add_roll( iv_roll_count = 10 ). " Added to last frame
        mo_cut->add_roll( iv_roll_count = 10 ). " Added to last frame
      CATCH lx_bowling.
    ENDTRY.

    cl_aunit_assert=>assert_equals(
      EXPORTING
        exp                  = 300
        act                  = mo_cut->total_score( )
    ).

  ENDMETHOD.

  METHOD finished_game_with_spare.
    TRY.
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 25 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 20 Points
        " Last to shots
        mo_cut->add_roll( iv_roll_count = 5 ). " Added to last frame
        mo_cut->add_roll( iv_roll_count = 5 ). " Added to last frame
      CATCH lx_bowling.
    ENDTRY.

    cl_aunit_assert=>assert_equals(
      EXPORTING
        exp                  = 285
        act                  = mo_cut->total_score( )
    ).
  ENDMETHOD.

  METHOD raise_exception_if_game_closed.
    TRY.
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 30 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 25 Points
        mo_cut->add_roll( iv_roll_count = 10 ). " 20 Points
        " Last to shots
        mo_cut->add_roll( iv_roll_count = 5 ). " Added to last frame
        mo_cut->add_roll( iv_roll_count = 5 ). " Added to last frame
      CATCH lx_bowling.
    ENDTRY.

    TRY.
        mo_cut->add_roll( iv_roll_count = 4 ).

      CATCH lx_bowling INTO DATA(lo_bowling).
        DATA(lv_message) = lo_bowling->get_message( ).
        cl_abap_unit_assert=>assert_equals( exp = 'Spiel ist geschlossen!' act = lv_message ).
    ENDTRY.
    cl_aunit_assert=>assert_equals(
      EXPORTING
        exp                  = 285
        act                  = mo_cut->total_score( )
    ).
  ENDMETHOD.

ENDCLASS.
