CLASS ycl_test_result DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor.

    METHODS summary
      RETURNING VALUE(rv_result) TYPE string.
    METHODS test_started.
    METHODS test_failed.

  PRIVATE SECTION.
    DATA mv_run_count TYPE i.
    DATA mv_failure_count TYPE i.

ENDCLASS.

CLASS ycl_test_result IMPLEMENTATION.

  METHOD constructor.
    mv_run_count = 0.
    mv_failure_count = 0.
  ENDMETHOD.

  METHOD test_started.
    mv_run_count = mv_run_count + 1.
  ENDMETHOD.

  METHOD test_failed.
    mv_failure_count = mv_failure_count + 1.
  ENDMETHOD.

  METHOD summary.
    rv_result = |{ mv_run_count } run, { mv_failure_count } failed|.
  ENDMETHOD.

ENDCLASS.
