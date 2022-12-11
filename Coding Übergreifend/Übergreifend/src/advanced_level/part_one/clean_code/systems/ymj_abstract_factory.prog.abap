*&---------------------------------------------------------------------*
*& Report ymj_abstract_factory
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_abstract_factory.

INTERFACE lif_line_item_factory.
  METHODS:
    makelineitem
      RETURNING VALUE(rv_line_item) TYPE string.
ENDINTERFACE.

CLASS lcl_line_item_factory DEFINITION FINAL.

  PUBLIC SECTION.
    INTERFACES: lif_line_item_factory.

ENDCLASS.

CLASS lcl_line_item_factory IMPLEMENTATION.

  METHOD lif_line_item_factory~makelineitem.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_order_processing DEFINITION FINAL.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          io_line_item_factory TYPE REF TO lif_line_item_factory.
    METHODS run.

  PRIVATE SECTION.
    DATA: mo_lineitemfactory TYPE REF TO lif_line_item_factory,
          mv_line_item       TYPE string.

ENDCLASS.

CLASS lcl_order_processing IMPLEMENTATION.

  METHOD constructor.
    mo_lineitemfactory = io_line_item_factory.
  ENDMETHOD.

  METHOD run.
    mv_line_item = mo_lineitemfactory->makelineitem( ).
  ENDMETHOD.

ENDCLASS.

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    METHODS main.
ENDCLASS.

CLASS lcl_main IMPLEMENTATION.

  METHOD main.
    DATA(lo_lineitemfactory)  = NEW lcl_line_item_factory( ).
    DATA(lo_order_processing) = NEW lcl_order_processing( lo_lineitemfactory ).
    lo_order_processing->run( ).
  ENDMETHOD.

ENDCLASS.
