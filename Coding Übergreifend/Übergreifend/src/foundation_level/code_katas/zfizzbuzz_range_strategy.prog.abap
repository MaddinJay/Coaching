REPORT zfizzbuzz_range_strategy.

DATA  gv_number TYPE i.

SELECT-OPTIONS: so_num FOR gv_number NO-EXTENSION.

DATA:
  gr_fizz TYPE REF TO zcl_fizzbuzz_range_strat_mod3,
  gr_buzz TYPE REF TO zcl_fizzbuzz_range_strat_mod5,
  gr_fizzbuzz TYPE REF TO zcl_fizzbuzz_range_stratmod15,
  gr_standardstrategy TYPE REF TO zcl_fizzbuzz_range_stratstand,
  gr_strategy_list TYPE TABLE OF REF TO zcl_fizzbuzz_range_strategy,
  gr_strategy TYPE REF TO zcl_fizzbuzz_range_strategy,
  gv_ausgabe TYPE string.


CLASS lcl_application DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS lcl_application IMPLEMENTATION.
  METHOD main.

    DATA lt_object_names TYPE TABLE OF classname.
    DATA lw_object_names TYPE classname.
    DATA lr_strategy_helper TYPE REF TO zcl_fizzbuzz_range_strategy.
    DATA lt_ref_of_strategies TYPE TABLE OF REF TO zcl_fizzbuzz_range_strategy.
    DATA lr_error TYPE REF TO cx_root.

    SELECT clsname FROM seometarel
        INTO TABLE lt_object_names
        WHERE refclsname = 'ZCL_FIZZBUZZ_RANGE_STRATEGY'
          AND state = 1
          AND reltype = 2.

    CHECK sy-subrc = 0.

    TRY.
        LOOP AT lt_object_names INTO lw_object_names.
          lw_object_names = to_upper( lw_object_names ).
          CREATE OBJECT lr_strategy_helper TYPE (lw_object_names).
          APPEND lr_strategy_helper TO lt_ref_of_strategies.
        ENDLOOP.
      CATCH cx_root INTO lr_error.
        MESSAGE lr_error TYPE 'E' DISPLAY LIKE 'I'.
    ENDTRY.

    IF so_num-high IS INITIAL.
      so_num-high = so_num-low.
    ENDIF.

    gv_number = so_num-low.

    WHILE gv_number <= so_num-high.
      LOOP AT lt_ref_of_strategies INTO lr_strategy_helper.
        IF lr_strategy_helper->can_execute( iv_number = gv_number ) = abap_true.
          gv_ausgabe = lr_strategy_helper->execute( ).
          EXIT.
        ENDIF.
      ENDLOOP.

      WRITE: gv_number, ':' , gv_ausgabe. SKIP.
      CLEAR: gv_ausgabe.
      gv_number = gv_number + 1.
    ENDWHILE.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  lcl_application=>main( ).
