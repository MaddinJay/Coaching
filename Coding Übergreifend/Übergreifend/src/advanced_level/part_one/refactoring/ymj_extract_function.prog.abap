*&---------------------------------------------------------------------*
*& Report ymj_extract_function
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_extract_function.

CLASS ycl_orders DEFINITION.
  PUBLIC SECTION.
    DATA: mv_amount TYPE amount.
ENDCLASS.

CLASS ycl_orders IMPLEMENTATION.

ENDCLASS.

CLASS ycl_invoice DEFINITION.

  PUBLIC SECTION.
    DATA:
      mv_due_date TYPE datum,
      mt_orders   TYPE STANDARD TABLE OF REF TO ycl_orders WITH DEFAULT KEY.

ENDCLASS.

CLASS ycl_invoice IMPLEMENTATION.

ENDCLASS.

CLASS ycl_function_extraction DEFINITION.
  PUBLIC SECTION.
    METHODS function_extract
      IMPORTING
        iv_invoice TYPE REF TO ycl_invoice.
  PRIVATE SECTION.
    METHODS print_log_banner.
    METHODS calculate_open_amount
      IMPORTING
        iv_invoice       TYPE REF TO ycl_invoice
      RETURNING
        VALUE(rv_amount) TYPE i.
    METHODS create_due_date
      IMPORTING
        io_invoice         TYPE REF TO ycl_invoice
      RETURNING
        VALUE(rv_due_date) TYPE datum.
    METHODS print_log_datails
      IMPORTING
        iv_invoice     TYPE REF TO ycl_invoice
        iv_outstanding TYPE i.
ENDCLASS.

CLASS ycl_function_extraction IMPLEMENTATION.

  METHOD function_extract.

    print_log_banner( ).

    DATA(outstanding) = calculate_open_amount( iv_invoice ).
    create_due_date( iv_invoice ).

    print_log_datails( iv_invoice = iv_invoice iv_outstanding = outstanding ).
  ENDMETHOD.

  METHOD print_log_banner.

  ENDMETHOD.

  METHOD calculate_open_amount.
    rv_amount = 0.
    LOOP AT iv_invoice->mt_orders INTO DATA(lo_order).
      rv_amount = rv_amount + lo_order->mv_amount.
    ENDLOOP.
  ENDMETHOD.

  METHOD create_due_date.
    " Do some calculation
  ENDMETHOD.

  METHOD print_log_datails.
    " Print Details in LOG
  ENDMETHOD.

ENDCLASS.
