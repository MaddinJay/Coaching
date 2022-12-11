REPORT ymj_fizzbuzz_event_driven.

" Ausnahmeklasse
CLASS lcx_fizzbuzz DEFINITION
                   INHERITING FROM cx_dynamic_check.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        iv_textid   LIKE textid   OPTIONAL
        io_previous LIKE previous OPTIONAL
        iv_message  TYPE string   OPTIONAL.

    METHODS get_message
      RETURNING value(rv_message) TYPE string.
  PRIVATE SECTION.
    DATA:
      mv_message TYPE string.
ENDCLASS.

CLASS lcx_fizzbuzz IMPLEMENTATION.

  METHOD constructor.
    super->constructor( textid = iv_textid previous = io_previous ).
    mv_message = iv_message.
  ENDMETHOD.

  METHOD get_message.
    rv_message = mv_message.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_fizzbuzz_eventhandler DEFINITION DEFERRED.

CLASS lcl_fizzbuzz DEFINITION.
  PUBLIC SECTION.
    " Event deklarieren
    EVENTS: convert_number
              EXPORTING value(iv_number) TYPE int4.     " Dem Event können Informationen mitgegeben werden, welche in der Event-Handler-Methode verarbeitet werden

    METHODS constructor.
    METHODS convert
      IMPORTING
        iv_number TYPE int4
      RETURNING
        value(rv_result) TYPE string
      RAISING
        lcx_fizzbuzz.
  PRIVATE SECTION.

    DATA:
      mo_event_handler TYPE REF TO lcl_fizzbuzz_eventhandler.

    METHODS raise_event
      IMPORTING
        iv_number TYPE int4.


    METHODS check_input_is_valid
      IMPORTING
        iv_number TYPE int4
      RAISING
        lcx_fizzbuzz.

    METHODS create_event_handler.
ENDCLASS.

CLASS lcl_fizzbuzz_eventhandler DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          io_raiser TYPE REF TO lcl_fizzbuzz.
    " Ereignishandler ist diese Methode
    METHODS
      handle_event_convert_number FOR EVENT convert_number OF lcl_fizzbuzz
        IMPORTING
          iv_number.

    METHODS get_converted_number
      RETURNING
        value(rv_converted_number) TYPE string.
  PRIVATE SECTION.
    DATA:
      mv_number           TYPE int4,
      mv_converted_number TYPE string.

    METHODS is_dividable_by_15
      RETURNING
        value(rv_is_dividable) TYPE abap_bool.

    METHODS is_dividable_by_3
      RETURNING
        value(rv_is_dividable) TYPE abap_bool.

    METHODS is_dividable_by_5
      RETURNING
        value(rv_is_dividable) TYPE abap_bool.
ENDCLASS.

CLASS lcl_fizzbuzz IMPLEMENTATION.

  METHOD convert.

    check_input_is_valid( iv_number ).

    create_event_handler(  ).

    me->raise_event( iv_number ).

    rv_result = mo_event_handler->get_converted_number( ).
  ENDMETHOD.

  METHOD constructor.

  ENDMETHOD.

  METHOD raise_event.
    RAISE EVENT convert_number
      EXPORTING
        iv_number = iv_number.
  ENDMETHOD.


  METHOD check_input_is_valid.
    IF iv_number <= 0.
      RAISE EXCEPTION TYPE lcx_fizzbuzz
        EXPORTING
          iv_message = 'Keine gültige Eingabe'.
    ENDIF.
  ENDMETHOD.

  METHOD create_event_handler.
    CREATE OBJECT mo_event_handler
      EXPORTING
        io_raiser = me.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_fizzbuzz_eventhandler IMPLEMENTATION.

  METHOD constructor.
    " Ereignishandler registieren (Methode, die das Event verarbeitet, wird dem Event-Raiser bekannt gemacht)
    SET HANDLER handle_event_convert_number FOR io_raiser.
  ENDMETHOD.

  METHOD handle_event_convert_number.
    mv_number = iv_number.
    IF abap_true = is_dividable_by_15( ).
      mv_converted_number = 'FizzBuzz'.
    ELSEIF abap_true = is_dividable_by_3( ).
      mv_converted_number = 'Fizz'.
    ELSEIF abap_true = is_dividable_by_5( ).
      mv_converted_number = 'Buzz'.
    ELSE.
      mv_converted_number = mv_number.
    ENDIF.
  ENDMETHOD.


  METHOD get_converted_number.

    rv_converted_number = mv_converted_number.

  ENDMETHOD.

  METHOD is_dividable_by_15.
    rv_is_dividable = boolc( mv_number MOD 3 = 0 AND mv_number MOD 5 = 0 ).
  ENDMETHOD.

  METHOD is_dividable_by_3.
    rv_is_dividable = boolc( mv_number MOD 3 = 0 ).
  ENDMETHOD.

  METHOD is_dividable_by_5.
    rv_is_dividable = boolc( mv_number MOD 5 = 0 ).
  ENDMETHOD.
ENDCLASS.

CLASS ltcl_fizzbuzz DEFINITION FOR TESTING
                    RISK LEVEL HARMLESS
                    DURATION SHORT.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO lcl_fizzbuzz.

    METHODS:
      setup,
      " It should be printed...
      one_for_one    FOR TESTING,
      fizz_for_three FOR TESTING,
      buzz_for_five  FOR TESTING,
      fizzbuzz_for_fifteen FOR TESTING,
      " It should be raised exception for
      negativ_numbers_and_null FOR TESTING.

ENDCLASS.

CLASS ltcl_fizzbuzz IMPLEMENTATION.

  METHOD setup.
    CREATE OBJECT mo_cut.
  ENDMETHOD.

  METHOD one_for_one.
    DATA:
      lv_result TYPE string.

    lv_result = 1.
    cl_abap_unit_assert=>assert_equals( exp = lv_result act = mo_cut->convert( 1 ) ).
  ENDMETHOD.


  METHOD fizz_for_three.
    cl_abap_unit_assert=>assert_equals( exp = 'Fizz' act = mo_cut->convert( 3 ) ).
  ENDMETHOD.

  METHOD buzz_for_five.
    cl_abap_unit_assert=>assert_equals( exp = 'Buzz' act = mo_cut->convert( 5 ) ).
  ENDMETHOD.

  METHOD fizzbuzz_for_fifteen.
    cl_abap_unit_assert=>assert_equals( exp = 'FizzBuzz' act = mo_cut->convert( 15 ) ).
  ENDMETHOD.

  METHOD negativ_numbers_and_null.
    DATA:
      lv_result   TYPE string,
      lx_fizzbuzz TYPE REF TO lcx_fizzbuzz.

    TRY.
        lv_result = mo_cut->convert( 0 ).
      CATCH lcx_fizzbuzz INTO lx_fizzbuzz.
        cl_abap_unit_assert=>assert_equals( exp = 'Keine gültige Eingabe' act = lx_fizzbuzz->get_message( ) ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
