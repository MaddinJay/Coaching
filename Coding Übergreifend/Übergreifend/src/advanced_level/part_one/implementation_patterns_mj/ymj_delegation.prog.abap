*&---------------------------------------------------------------------*
*& Report ymj_delegation
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_delegation.

CLASS lcl_rectangle_figure DEFINITION.

ENDCLASS.

CLASS lcl_rectangle_figure IMPLEMENTATION.

ENDCLASS.

CLASS lcl_graphic_editor DEFINITION.
  PUBLIC SECTION.
    METHODS:
      mousedown,
      add
        IMPORTING
          io_rectangle_figure TYPE REF TO lcl_rectangle_figure.
  PRIVATE SECTION.
    DATA mo_rectangle_figure TYPE REF TO lcl_rectangle_figure.

ENDCLASS.

CLASS lcl_rectangletool DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          io_graphic_editor TYPE REF TO lcl_graphic_editor,
      mousedown.
  PRIVATE SECTION.
    DATA: mo_graphic_editor TYPE REF TO lcl_graphic_editor.
ENDCLASS.

CLASS lcl_rectangletool IMPLEMENTATION.

  METHOD constructor.
    mo_graphic_editor = io_graphic_editor.
  ENDMETHOD.

  METHOD mousedown.
    mo_graphic_editor->add( NEW lcl_rectangle_figure( ) ).
  ENDMETHOD.

ENDCLASS.

CLASS lcl_graphic_editor IMPLEMENTATION.

  METHOD mousedown.

  ENDMETHOD.

  METHOD add.
    mo_rectangle_figure = io_rectangle_figure.
  ENDMETHOD.

ENDCLASS.
