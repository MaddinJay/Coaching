*&---------------------------------------------------------------------*
*& Report ymj_double_dispatch
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_double_dispatch.

INTERFACE lif_display.
  METHODS:
    displaywith
      IMPORTING
        io_brush TYPE REF TO data.
ENDINTERFACE.

CLASS lcl_brush DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS:
      display_oval
        IMPORTING
          io_oval TYPE REF TO data,
      display_rectangle
        IMPORTING
          io_rectangle TYPE REF TO data.
ENDCLASS.

CLASS lcl_brush IMPLEMENTATION.

  METHOD display_oval.

  ENDMETHOD.

  METHOD display_rectangle.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_oval DEFINITION. " INHERITING FROM lcl_brush.
  PUBLIC SECTION.
    METHODS:
      displaywith
        IMPORTING
          io_brush TYPE REF TO lcl_brush.
ENDCLASS.

CLASS lcl_oval IMPLEMENTATION.

  METHOD displaywith.
    io_brush->display_oval( io_oval = REF #( me ) ).
  ENDMETHOD.

ENDCLASS.

CLASS lcl_rectangle DEFINITION.
  PUBLIC SECTION.
    METHODS:
      displaywith
        IMPORTING
          io_brush TYPE REF TO lcl_brush.
ENDCLASS.

CLASS lcl_rectangle IMPLEMENTATION.

  METHOD displaywith.
    io_brush->display_rectangle( io_rectangle = REF #( me ) ).
  ENDMETHOD.

ENDCLASS.
