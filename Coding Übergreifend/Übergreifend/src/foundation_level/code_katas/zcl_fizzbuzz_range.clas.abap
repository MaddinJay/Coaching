CLASS ZCL_FIZZBUZZ_RANGE DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
     constructor.
    INTERFACES: zif_fizzbuzz_range.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: mt_fizzbuzz TYPE TABLE OF zsw_fizzbuzz.

    METHODS: get_modulo IMPORTING iv_number TYPE i
                                  iv_modulo TYPE i
                        RETURNING value(ev_result) TYPE boolean.
ENDCLASS.



CLASS ZCL_FIZZBUZZ_RANGE IMPLEMENTATION.


  METHOD constructor.
    SELECT * FROM zsw_fizzbuzz INTO TABLE mt_fizzbuzz.
  ENDMETHOD.


  METHOD get_modulo.
    IF iv_number MOD iv_modulo = 0.
      ev_result = abap_true.
    ELSE.
      ev_result = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD zif_fizzbuzz_range~convert_number_to_fizzbuzz.
    DATA: lt_number_range TYPE RANGE OF i,
          lw_number_range_line LIKE LINE OF lt_number_range,
          lv_number_for_conversion TYPE i,
          lw_fizzbuzz TYPE zsw_fizzbuzz,
          lw_value_to_number LIKE LINE OF ev_value_to_number.

    READ TABLE  iv_number   INTO lw_number_range_line INDEX 1. "solange nur die Aufgabe ist, eine Zahl oder von-bis einzugeben

    lv_number_for_conversion = lw_number_range_line-low.

    IF lw_number_range_line-high IS INITIAL.
      lw_number_range_line-high = lw_number_range_line-low.
    ENDIF.

    WHILE lv_number_for_conversion <= lw_number_range_line-high. "Jede Zahl im Range durchgehen und FIZZBUZZ berechnen
      LOOP AT mt_fizzbuzz INTO lw_fizzbuzz.
        IF me->get_modulo(
             iv_number   =  lv_number_for_conversion
             iv_modulo = lw_fizzbuzz-zahl
         ) = abap_true.

          lw_value_to_number-bezeichnung = lw_value_to_number-bezeichnung && lw_fizzbuzz-bezeichnung.

        ENDIF.

      ENDLOOP.

      if lw_value_to_number-bezeichnung is initial.
                lw_value_to_number-bezeichnung = lv_number_for_conversion.
      endif.

      lw_value_to_number-zahl = lv_number_for_conversion.
      APPEND lw_value_to_number TO ev_value_to_number.
      CLEAR lw_value_to_number.

      lv_number_for_conversion = lv_number_for_conversion + 1.
    ENDWHILE.



  ENDMETHOD.
ENDCLASS.
