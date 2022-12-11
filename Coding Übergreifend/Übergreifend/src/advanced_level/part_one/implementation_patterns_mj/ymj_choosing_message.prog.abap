*&---------------------------------------------------------------------*
*& Report ymj_choosing_message
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_choosing_message.

CLASS lcl_brush DEFINITION.
  PUBLIC SECTION.
    METHODS:
      display
        IMPORTING
          io_subject TYPE REF TO data.
ENDCLASS.

CLASS lcl_brush IMPLEMENTATION.

  METHOD display.
    " do something else
  ENDMETHOD.

ENDCLASS.

CLASS lcl_choosing_msg DEFINITION.

  PUBLIC SECTION.
    METHODS:
      display_shape
        IMPORTING
          io_subject TYPE REF TO data
          io_brush   TYPE REF TO lcl_brush.
ENDCLASS.

CLASS lcl_choosing_msg IMPLEMENTATION.

  METHOD display_shape.
    io_brush->display( io_subject ).
  ENDMETHOD.

ENDCLASS.
