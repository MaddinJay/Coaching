*&---------------------------------------------------------------------*
*& Report ymj_bowling_first_implement
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_bowling_first_implement.

CLASS lcx_game DEFINITION INHERITING FROM cx_dynamic_check.
  PUBLIC SECTION.
    INTERFACES yif_message_mj.
    ALIASES mv_message   FOR yif_message_mj~mv_message.
    ALIASES get_message  FOR yif_message_mj~get_message.
    METHODS constructor
      IMPORTING
        iv_message TYPE string.
ENDCLASS.

CLASS lcx_game IMPLEMENTATION.

  METHOD constructor.
    super->constructor( ).
    mv_message = iv_message.
  ENDMETHOD.

  METHOD yif_message_mj~get_message.
    rv_message = mv_message.
  ENDMETHOD.

ENDCLASS.
"-----------------------------------------------------------------------
INTERFACE litf_game.

  METHODS add_roll
    IMPORTING
      iv_number_of_pins TYPE int1
    RAISING
      lcx_game.

  METHODS total_score
    RETURNING VALUE(rv_count) TYPE int1.

ENDINTERFACE.
"-----------------------------------------------------------------------
CLASS lcl_frame DEFINITION.
  PUBLIC SECTION.
    METHODS add_roll_to_frame
      IMPORTING
        iv_number_of_pins TYPE int1.

    METHODS get_score
      RETURNING VALUE(rv_total_score) TYPE int1.

    METHODS is_full
      RETURNING VALUE(rv_is_full) TYPE abap_bool.

    METHODS is_spare
      RETURNING VALUE(rv_is_spare) TYPE abap_bool.

    METHODS is_strike
      RETURNING VALUE(rv_is_spare) TYPE abap_bool.

    METHODS add_roll_to_count
      IMPORTING iv_number_of_pins TYPE int1.

    METHODS add_roll_4_strike
      IMPORTING
        iv_number_of_pins TYPE int1.

    METHODS add_roll_4_spare
      IMPORTING
        iv_number_of_pins TYPE int1.

    METHODS is_first_roll_in_frame
      RETURNING VALUE(rv_is_first_roll) TYPE abap_bool.
    METHODS is_last_frame_to_close
      RETURNING
        VALUE(rv_is_to_close) TYPE abap_bool.
    METHODS is_not_last_frame_to_close
      RETURNING
        VALUE(rv_is_frame_to_close) TYPE abap_bool.

  PRIVATE SECTION.
    TYPES: BEGIN OF ts_frame,
             first_roll  TYPE int1,
             second_roll TYPE int1,
           END OF ts_frame.

    DATA:
      ms_frame TYPE ts_frame,
      mv_count TYPE int1,
      mv_rolls TYPE int1.

    METHODS is_first_roll
      RETURNING
        VALUE(rv_is_first_roll) TYPE abap_bool.
    METHODS add_pins_4_first_roll
      IMPORTING
        iv_number_of_pins TYPE int1.
    METHODS add_pins_to_frame_count
      IMPORTING
        iv_number_of_pins TYPE int1.
    METHODS add_pins_4_second_roll
      IMPORTING
        iv_number_of_pins TYPE int1.
    METHODS has_extra_roll
      RETURNING
        VALUE(rv_has_extra_roll) TYPE abap_bool.
    METHODS max_rolls_reached
      RETURNING
        VALUE(rv_max_rolls_reached) TYPE abap_bool.

ENDCLASS.

CLASS lcl_frame IMPLEMENTATION.
  METHOD add_roll_to_frame.

    IF is_first_roll( ) = abap_true.
      add_pins_4_first_roll( iv_number_of_pins ).
    ELSE.
      add_pins_4_second_roll( iv_number_of_pins ).
    ENDIF.

    add_pins_to_frame_count( iv_number_of_pins ).
    ##TODO "Extrahieren
    mv_rolls = mv_rolls + 1.

  ENDMETHOD.

  METHOD get_score.
    rv_total_score = mv_count.
  ENDMETHOD.


  METHOD is_full.
    rv_is_full = boolc( ms_frame-second_roll IS NOT INITIAL ).
  ENDMETHOD.

  METHOD is_spare.
    rv_is_spare = boolc( ms_frame-first_roll <> 10 AND ( ms_frame-first_roll + ms_frame-second_roll ) = 10 ).
  ENDMETHOD.

  METHOD is_first_roll.
    ##TODO " Entscheidung über Roll-Counter machen
    rv_is_first_roll = boolc( ms_frame-first_roll IS INITIAL ).
  ENDMETHOD.


  METHOD add_pins_4_first_roll.
    ms_frame-first_roll = iv_number_of_pins.
  ENDMETHOD.


  METHOD add_pins_to_frame_count.
    mv_count = iv_number_of_pins + mv_count.
  ENDMETHOD.


  METHOD add_pins_4_second_roll.
    ms_frame-second_roll = ms_frame-second_roll + iv_number_of_pins .
  ENDMETHOD.

  METHOD add_roll_to_count.
    mv_count = mv_count + iv_number_of_pins.
  ENDMETHOD.

  METHOD is_strike.
    rv_is_spare = boolc( ms_frame-first_roll = 10 ).
  ENDMETHOD.

  METHOD add_roll_4_strike.
    CHECK abap_true = me->is_strike( ).
    me->add_roll_to_count( iv_number_of_pins ).
  ENDMETHOD.

  METHOD add_roll_4_spare.
    CHECK me->is_spare( ).
    me->add_roll_to_count( iv_number_of_pins ).
  ENDMETHOD.

  METHOD is_first_roll_in_frame.
    rv_is_first_roll = boolc( me->ms_frame-second_roll IS INITIAL ).
  ENDMETHOD.


  METHOD is_last_frame_to_close.
    ##TODO "if else endif mittels COND umsetzen
    rv_is_to_close = COND #( WHEN has_extra_roll( ) THEN max_rolls_reached( )
                             ELSE is_full( ) ).
  ENDMETHOD.


  METHOD has_extra_roll.
    rv_has_extra_roll = boolc( is_spare( ) OR is_strike( ) ).
  ENDMETHOD.


  METHOD max_rolls_reached.
    rv_max_rolls_reached = boolc( mv_rolls = 3 ).
  ENDMETHOD.


  METHOD is_not_last_frame_to_close.
    rv_is_frame_to_close = boolc( is_full( ) = abap_true OR is_strike( ) = abap_true ).
  ENDMETHOD.

ENDCLASS.

CLASS lcl_game DEFINITION.
  PUBLIC SECTION.
    INTERFACES litf_game.
    ALIASES add_roll       FOR litf_game~add_roll.
    ALIASES total_score    FOR litf_game~total_score.

    METHODS constructor.
    METHODS over
      RETURNING
        VALUE(rv_is_game_over) TYPE abap_bool.

  PRIVATE SECTION.
    DATA:
      mt_frames       TYPE STANDARD TABLE OF REF TO lcl_frame,
      mo_actual_frame TYPE REF TO lcl_frame.

    METHODS close_frame.

    METHODS is_roll_strike
      IMPORTING
        iv_number_of_pins        TYPE int1
      RETURNING
        VALUE(rv_is_roll_strike) TYPE abap_bool.

    METHODS get_xth_frame_before
      IMPORTING
                iv_counter_frames_before TYPE int1
      RETURNING VALUE(ro_last_frame)     TYPE REF TO lcl_frame.

    METHODS add_roll_to_actual_frame
      IMPORTING
        iv_number_of_pins TYPE int1.

    METHODS add_roll_4_spare
      IMPORTING
        iv_number_of_pins TYPE int1.

    METHODS add_roll_4_strike
      IMPORTING
        iv_counter_frames_before TYPE int1
        iv_number_of_pins        TYPE int1.
    METHODS is_frame_to_close
      IMPORTING
                iv_number_of_pins     TYPE int1
      RETURNING VALUE(rv_is_to_close) TYPE abap_bool.
    METHODS add_roll_4_last_strike
      IMPORTING
        iv_number_of_pins TYPE int1.
    METHODS is_last_frame
      RETURNING
        VALUE(rv_is_last_frame) TYPE abap_bool.
    METHODS check_game_is_over
      RAISING
        lcx_game.
    METHODS get_score_old_frames
      RETURNING
        VALUE(rv_count) TYPE int1.

ENDCLASS.

CLASS lcl_game IMPLEMENTATION.
  METHOD litf_game~add_roll.

    check_game_is_over( ).

    add_roll_to_actual_frame( iv_number_of_pins ).

    add_roll_4_spare( iv_number_of_pins ).
    ##TODO " Counter weg oder als Konstante deklarieren
    add_roll_4_strike( iv_counter_frames_before = 1 iv_number_of_pins = iv_number_of_pins ).

    CHECK is_frame_to_close( iv_number_of_pins ) = abap_true.

    close_frame(  ).


  ENDMETHOD.

  METHOD litf_game~total_score.

    rv_count = get_score_old_frames( ).

    rv_count = rv_count + mo_actual_frame->get_score( ).

  ENDMETHOD.

  METHOD get_score_old_frames.

    LOOP AT mt_frames INTO DATA(lo_frame).
      rv_count = rv_count + lo_frame->get_score( ).
    ENDLOOP.

  ENDMETHOD.

  METHOD constructor.
    mo_actual_frame = NEW #( ).
  ENDMETHOD.


  METHOD over.
    rv_is_game_over = boolc( lines( mt_frames ) = 10 ).
  ENDMETHOD.


  METHOD close_frame.
    APPEND mo_actual_frame TO mt_frames.
    mo_actual_frame = NEW #( ).
  ENDMETHOD.

  METHOD is_roll_strike.
    rv_is_roll_strike = boolc( iv_number_of_pins = 10 ).
  ENDMETHOD.


  METHOD get_xth_frame_before.
    READ TABLE mt_frames ASSIGNING FIELD-SYMBOL(<lo_last_frame>) INDEX ( lines( mt_frames ) - iv_counter_frames_before + 1 ).
    CHECK sy-subrc = 0.
    ro_last_frame = <lo_last_frame>.
  ENDMETHOD.


  METHOD add_roll_to_actual_frame.
    mo_actual_frame->add_roll_to_frame( iv_number_of_pins ).
  ENDMETHOD.


  METHOD add_roll_4_spare.
    ##TODO " ABAP_TRUE als Vergleich weglassen
    CHECK mo_actual_frame->is_first_roll_in_frame( ).

    DATA(lo_frame) = get_xth_frame_before( 1 ).
    CHECK lo_frame IS NOT INITIAL.
    ASSIGN lo_frame TO FIELD-SYMBOL(<lo_frame>).

    <lo_frame>->add_roll_4_spare( iv_number_of_pins ).

  ENDMETHOD.


  METHOD add_roll_4_strike.

    DATA(lo_frame) = get_xth_frame_before( iv_counter_frames_before ).
    CHECK lo_frame IS NOT INITIAL.
    ASSIGN lo_frame TO FIELD-SYMBOL(<lo_frame>).

    <lo_frame>->add_roll_4_strike( iv_number_of_pins ).

    CHECK <lo_frame>->is_strike( ) = abap_true.
    ##TODO " Magic Numbers
    add_roll_4_strike( iv_counter_frames_before = ( iv_counter_frames_before + 1 )
                       iv_number_of_pins        = iv_number_of_pins ).
  ENDMETHOD.


  METHOD is_frame_to_close.
    IF is_last_frame( ) = abap_true.
      rv_is_to_close = mo_actual_frame->is_last_frame_to_close( ).
    ELSE.
      rv_is_to_close = mo_actual_frame->is_not_last_frame_to_close( ).
    ENDIF.

  ENDMETHOD.


  METHOD add_roll_4_last_strike.

  ENDMETHOD.


  METHOD is_last_frame.
    ##TODO " Magische Ziffern und Strings in Konstanten überführen
    rv_is_last_frame = boolc( lines( mt_frames ) = 9 ).
  ENDMETHOD.


  METHOD check_game_is_over.
    CHECK over( ) = abap_true.

    RAISE EXCEPTION TYPE lcx_game
      EXPORTING
        iv_message = 'Das Spiel ist zu Ende, Wurf ungültig!'.
  ENDMETHOD.

ENDCLASS.

CLASS ltcl_game DEFINITION FOR TESTING
                DURATION SHORT
                RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      " It should be added ...
      first_roll_first_frame   FOR TESTING,
      second_roll_first_frame  FOR TESTING,
      first_roll_second_frame  FOR TESTING,
      second_roll_second_frame FOR TESTING,
      first_roll_after_spare   FOR TESTING,
      second_roll_after_spare  FOR TESTING,
      first_roll_is_strike     FOR TESTING,
      first_roll_after_strike         FOR TESTING,
      second_roll_after_strike        FOR TESTING,
      two_strikes_after_strike        FOR TESTING,
      " It should be added in last frame ...
      last_rolls_after_strike          FOR TESTING,
      last_roll_after_spare            FOR TESTING,
      " It shoulde be answered ...
      game_is_not_over            FOR TESTING,
      game_is_over                FOR TESTING,
      exception_if_game_is_over   FOR TESTING.
ENDCLASS.

CLASS ltcl_game IMPLEMENTATION.
  METHOD first_roll_first_frame.
    DATA(mo_game) = NEW lcl_game( ).

    mo_game->add_roll( 5 ).
    cl_abap_unit_assert=>assert_equals(  exp = 5 act = mo_game->total_score( ) ).

  ENDMETHOD.

  METHOD second_roll_first_frame.
    DATA(mo_game) = NEW lcl_game( ).

    mo_game->add_roll( 5 ).
    mo_game->add_roll( 4 ).
    cl_abap_unit_assert=>assert_equals(  exp = 9 act = mo_game->total_score( ) ).

  ENDMETHOD.

  METHOD first_roll_second_frame.
    DATA(mo_game) = NEW lcl_game( ).

    mo_game->add_roll( 5 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 6 ).
    cl_abap_unit_assert=>assert_equals(  exp = 15 act = mo_game->total_score( ) ).

  ENDMETHOD.

  METHOD second_roll_second_frame.
    DATA(mo_game) = NEW lcl_game( ).

    mo_game->add_roll( 5 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 6 ).
    mo_game->add_roll( 4 ).
    cl_abap_unit_assert=>assert_equals(  exp = 19 act = mo_game->total_score( ) ).

  ENDMETHOD.

  METHOD first_roll_after_spare.
    DATA(mo_game) = NEW lcl_game( ).

    mo_game->add_roll( 5 ).
    mo_game->add_roll( 5 ).
    mo_game->add_roll( 6 ).
    cl_abap_unit_assert=>assert_equals(  exp = 22 act = mo_game->total_score( ) ).
  ENDMETHOD.

  METHOD game_is_not_over.
    DATA(mo_game) = NEW lcl_game( ).
    cl_abap_unit_assert=>assert_equals( exp = abap_false act = mo_game->over( ) ).
  ENDMETHOD.

  METHOD game_is_over.
    DATA(mo_game) = NEW lcl_game( ).

    mo_game->add_roll( 5 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 6 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 5 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 6 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 5 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 6 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 5 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 6 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 5 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 6 ).
    mo_game->add_roll( 3 ).
    cl_abap_unit_assert=>assert_equals( exp = abap_true act = mo_game->over( ) ).
  ENDMETHOD.

  METHOD second_roll_after_spare.
    DATA(mo_game) = NEW lcl_game( ).

    mo_game->add_roll( 5 ).
    mo_game->add_roll( 5 ).
    mo_game->add_roll( 6 ).
    mo_game->add_roll( 2 ).
    cl_abap_unit_assert=>assert_equals(  exp = 24 act = mo_game->total_score( ) ).
  ENDMETHOD.

  METHOD first_roll_is_strike.
    DATA(mo_game) = NEW lcl_game( ).

    mo_game->add_roll( 10 ).
    cl_abap_unit_assert=>assert_equals(  exp = 10 act = mo_game->total_score( ) ).
  ENDMETHOD.

  METHOD first_roll_after_strike.
    DATA(mo_game) = NEW lcl_game( ).

    mo_game->add_roll( 10 ).
    mo_game->add_roll( 5 ).
    cl_abap_unit_assert=>assert_equals(  exp = 20 act = mo_game->total_score( ) ).
  ENDMETHOD.

  METHOD second_roll_after_strike.
    DATA(mo_game) = NEW lcl_game( ).

    mo_game->add_roll( 10 ).
    mo_game->add_roll( 5 ).
    mo_game->add_roll( 4 ).
    cl_abap_unit_assert=>assert_equals(  exp = 28 act = mo_game->total_score( ) ).
  ENDMETHOD.

  METHOD two_strikes_after_strike.
    DATA(mo_game) = NEW lcl_game( ).

    mo_game->add_roll( 10 ).
    mo_game->add_roll( 10 ).
    mo_game->add_roll( 10 ).
    cl_abap_unit_assert=>assert_equals(  exp = 60 act = mo_game->total_score( ) ).
  ENDMETHOD.

  METHOD last_rolls_after_strike.
    DATA(mo_game) = NEW lcl_game( ).

    mo_game->add_roll( 1 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 1 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 1 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 1 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 1 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 1 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 1 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 1 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 1 ).
    mo_game->add_roll( 4 ).  " Points 9 * 5 Pt = 45 Pt
    mo_game->add_roll( 10 ). " 10 Frame, 1th Roll is strike
    mo_game->add_roll( 10 ).
    mo_game->add_roll( 10 ).
    cl_abap_unit_assert=>assert_equals( exp = 75 act = mo_game->total_score( ) ).
  ENDMETHOD.



  METHOD exception_if_game_is_over.
    DATA(mo_game) = NEW lcl_game( ).

    TRY.
        mo_game->add_roll( 5 ).
        mo_game->add_roll( 4 ).
        mo_game->add_roll( 6 ).
        mo_game->add_roll( 4 ).
        mo_game->add_roll( 5 ).
        mo_game->add_roll( 4 ).
        mo_game->add_roll( 6 ).
        mo_game->add_roll( 4 ).
        mo_game->add_roll( 5 ).
        mo_game->add_roll( 4 ).
        mo_game->add_roll( 6 ).
        mo_game->add_roll( 4 ).
        mo_game->add_roll( 5 ).
        mo_game->add_roll( 4 ).
        mo_game->add_roll( 6 ).
        mo_game->add_roll( 4 ).
        mo_game->add_roll( 5 ).
        mo_game->add_roll( 4 ).
        mo_game->add_roll( 6 ).
        mo_game->add_roll( 3 ).
        mo_game->add_roll( 3 ).
      CATCH lcx_game INTO DATA(lx_game).
        cl_abap_unit_assert=>assert_equals( exp = 'Das Spiel ist zu Ende, Wurf ungültig!' act = lx_game->get_message( ) ).
        RETURN.
    ENDTRY.

    cl_abap_unit_assert=>fail( msg = 'Testfall unerwartet beendet. Keine Exception geworfen.' ).

  ENDMETHOD.

  METHOD last_roll_after_spare.
    DATA(mo_game) = NEW lcl_game( ).

    mo_game->add_roll( 1 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 1 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 1 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 1 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 1 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 1 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 1 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 1 ).
    mo_game->add_roll( 4 ).
    mo_game->add_roll( 1 ).
    mo_game->add_roll( 4 ).  " Points 9 * 5 Pt = 45 Pt
    mo_game->add_roll( 5 ). " 10th Frame is Spare
    mo_game->add_roll( 5 ).
    mo_game->add_roll( 10 ).
    cl_abap_unit_assert=>assert_equals( exp = 65 act = mo_game->total_score( ) ).
  ENDMETHOD.

ENDCLASS.
