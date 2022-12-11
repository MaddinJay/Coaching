*&---------------------------------------------------------------------*
*& Report ycl_merge_functions_in_transf
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ycl_merge_functions_in_transf.

CLASS ycl_raw_reading DEFINITION FINAL.

  PUBLIC SECTION.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS ycl_raw_reading IMPLEMENTATION.

ENDCLASS.

CLASS ycl_areading DEFINITION FINAL.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          io_raw_reading TYPE REF TO ycl_raw_reading,
      get_base_charge RETURNING VALUE(r_result) TYPE amount,
      set_base_charge IMPORTING io_mv_base_charge TYPE amount.
  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA:
      mv_base_charge TYPE amount.

ENDCLASS.

CLASS ycl_areading IMPLEMENTATION.

  METHOD constructor.

  ENDMETHOD.

  METHOD get_base_charge.
    r_result = me->mv_base_charge.
  ENDMETHOD.

  METHOD set_base_charge.
    me->mv_base_charge = io_mv_base_charge.
  ENDMETHOD.

ENDCLASS.

CLASS ycl_process DEFINITION.
  PUBLIC SECTION.
    METHODS:
      main.
  PRIVATE SECTION.
    METHODS acquire_reading
      RETURNING
        VALUE(ro_raw_reading) TYPE REF TO ycl_raw_reading.
    METHODS enrich_reading
      IMPORTING
        io_rawreading      TYPE REF TO ycl_raw_reading
      RETURNING
        VALUE(ro_areading) TYPE REF TO ycl_areading.
    METHODS calculate_base_charge
      IMPORTING
        io_areading           TYPE REF TO ycl_areading
      RETURNING
        VALUE(rv_base_charge) TYPE amount.
ENDCLASS.

CLASS ycl_process IMPLEMENTATION.

  METHOD main.
    DATA(lo_rawreading)          = acquire_reading( ).
    DATA(lo_areading)            = enrich_reading( lo_rawreading ).
    DATA(lv_basic_change_amount) = lo_areading->get_base_charge( ).
  ENDMETHOD.

  METHOD enrich_reading.
    ro_areading  = NEW ycl_areading( io_rawreading ).
    ro_areading->set_base_charge( calculate_base_charge( ro_areading ) ).
  ENDMETHOD.

  METHOD acquire_reading.

  ENDMETHOD.

  METHOD calculate_base_charge.

  ENDMETHOD.

ENDCLASS.
