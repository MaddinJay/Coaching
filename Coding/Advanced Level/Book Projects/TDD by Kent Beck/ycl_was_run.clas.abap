CLASS ycl_was_run DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA:
      mv_was_setup TYPE abap_bool,
      mv_log       TYPE string.

    METHODS:
      constructor
        IMPORTING
          iv_test_method TYPE string.
    METHODS run
      IMPORTING io_result TYPE REF TO ycl_test_result.
    METHODS: setup.

  PRIVATE SECTION.
    DATA mv_test_method TYPE string.

    METHODS:
      test_method,

      tear_down,

      test_broken_method
        RAISING
          ycx_mj_static_check.
ENDCLASS.

CLASS ycl_was_run IMPLEMENTATION.

  METHOD constructor.
    mv_test_method = iv_test_method.
  ENDMETHOD.

  METHOD run.
    io_result->test_started( ).
    setup( ).
    TRY.
        CALL METHOD me->(mv_test_method).
      CATCH ycx_mj_static_check.
        io_result->test_failed( ).
    ENDTRY.
    tear_down( ).
  ENDMETHOD.

  METHOD setup.
    mv_was_setup = abap_true.
    mv_log       = 'setUp'.
  ENDMETHOD.

  METHOD test_broken_method.
    RAISE EXCEPTION TYPE ycx_mj_static_check.
  ENDMETHOD.

  METHOD test_method.
    mv_log     = |{ mv_log } { mv_test_method }|.
  ENDMETHOD.

  METHOD tear_down.
    mv_log     = |{ mv_log } TEAR_DOWN|.
  ENDMETHOD.
ENDCLASS.
