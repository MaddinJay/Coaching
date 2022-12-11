*&---------------------------------------------------------------------*
*& Report ymj_insert_paramter_object
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_insert_paramter_object.

CLASS ycl_station DEFINITION FINAL.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_temperature TYPE i,
      get_mv_temperature RETURNING VALUE(rv_temperature) TYPE i.
  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mv_temperature TYPE i.

ENDCLASS.

CLASS ycl_station IMPLEMENTATION.

  METHOD constructor.
    mv_temperature = iv_temperature.
  ENDMETHOD.

  METHOD get_mv_temperature.
    rv_temperature = mv_temperature.
  ENDMETHOD.

ENDCLASS.

CLASS ycl_number_range DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_min TYPE i
          iv_max TYPE i,
      get_max
        RETURNING VALUE(rv_max) TYPE i,
      get_min
        RETURNING VALUE(rv_min) TYPE i,
      contains_temperature
        IMPORTING
                  iv_temperature        TYPE i
        RETURNING VALUE(rv_is_in_range) TYPE abap_bool.

  PRIVATE SECTION.
    TYPES: BEGIN OF ts_data,
             min TYPE i,
             max TYPE i,
           END OF ts_data.
    DATA:
      ms_data TYPE ts_data.
ENDCLASS.

CLASS ycl_number_range IMPLEMENTATION.

  METHOD constructor.
    ms_data-min = iv_min.
    ms_data-max = iv_max.
  ENDMETHOD.

  METHOD get_max.
    rv_max = ms_data-max.
  ENDMETHOD.

  METHOD get_min.
    rv_min = ms_data-min.
  ENDMETHOD.


  METHOD contains_temperature.
    rv_is_in_range = xsdbool( iv_temperature > me->get_min( ) OR iv_temperature < me->get_max( ) ).
  ENDMETHOD.

ENDCLASS.

CLASS ycl_main DEFINITION.

  PUBLIC SECTION.
    METHODS:
      main.

  PRIVATE SECTION.
    METHODS:
      reading_outside_range
        IMPORTING
                  io_station       TYPE REF TO ycl_station
                  io_number_range  TYPE REF TO ycl_number_range
        RETURNING VALUE(rv_alerts) TYPE abap_bool.
ENDCLASS.

CLASS ycl_main IMPLEMENTATION.

  METHOD reading_outside_range.
    rv_alerts = xsdbool( io_number_range->contains_temperature( io_station->get_mv_temperature( ) ) = abap_false ).
  ENDMETHOD.

  METHOD main.
    DATA(lo_number_range) = NEW ycl_number_range( iv_min = 10 iv_max = 20 ).
    DATA(lv_alerts) = reading_outside_range( io_station         = NEW ycl_station( 25 )
                                             io_number_range    = lo_number_range ).
  ENDMETHOD.

ENDCLASS.
