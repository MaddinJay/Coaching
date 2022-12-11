*&---------------------------------------------------------------------*
*& Report ymj_dip_furnance_example
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_dip_furnance_example.

INTERFACE litf_thermometer.
  METHODS:
    read
      RETURNING
        VALUE(rv_temperature) TYPE i.
ENDINTERFACE.

CLASS lcl_io_channel_thermometer DEFINITION.
  PUBLIC SECTION.
    INTERFACES litf_thermometer.
ENDCLASS.

CLASS lcl_io_channel_thermometer IMPLEMENTATION.
  METHOD litf_thermometer~read.

  ENDMETHOD.
ENDCLASS.

INTERFACE litf_heater.
  METHODS:
    engage,
    disengage.
ENDINTERFACE.

CLASS lcl_channel_heater DEFINITION.
  PUBLIC SECTION.
    INTERFACES litf_heater.
ENDCLASS.

CLASS lcl_channel_heater IMPLEMENTATION.
  METHOD litf_heater~disengage.

  ENDMETHOD.

  METHOD litf_heater~engage.

  ENDMETHOD.
ENDCLASS.

CLASS lcl_generic_regulator DEFINITION.
  PUBLIC SECTION.
    METHODS:
      regulate
        IMPORTING
          io_thermometer TYPE REF TO litf_thermometer
          io_heater      TYPE REF TO litf_heater
          iv_min_temp    TYPE i
          iv_max_temp    TYPE i.
ENDCLASS.

CLASS lcl_generic_regulator IMPLEMENTATION.
  METHOD regulate.
    WHILE io_thermometer->read( ) > iv_min_temp.
      WAIT UP TO 1 SECONDS.
      io_heater->engage( ).
    ENDWHILE.

    WHILE io_thermometer->read( ) < iv_max_temp.
      WAIT UP TO 1 SECONDS.
      io_heater->disengage( ).
    ENDWHILE.
  ENDMETHOD.
ENDCLASS.
