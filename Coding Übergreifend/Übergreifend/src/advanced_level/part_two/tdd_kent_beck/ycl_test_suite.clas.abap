CLASS ycl_test_suite DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS add
      IMPORTING
        io_was_run TYPE REF TO ycl_was_run.
    METHODS run
      IMPORTING io_result TYPE REF TO ycl_test_result.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      mt_tests TYPE STANDARD TABLE OF REF TO ycl_was_run.
ENDCLASS.



CLASS ycl_test_suite IMPLEMENTATION.

  METHOD add.
    APPEND io_was_run TO mt_tests.
  ENDMETHOD.

  METHOD run.
    LOOP AT mt_tests INTO DATA(lo_test).
      lo_test->run( io_result ).
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
