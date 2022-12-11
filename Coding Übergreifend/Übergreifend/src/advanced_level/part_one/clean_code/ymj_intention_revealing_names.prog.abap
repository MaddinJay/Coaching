*&---------------------------------------------------------------------*
*& Report ymj_intention_revealing_names
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_intention_revealing_names.

CLASS lcl_cell DEFINITION.
  PUBLIC SECTION.
    METHODS is_flagged
      RETURNING
        value(rv_is_flagged) TYPE abap_bool.
ENDCLASS.

CLASS lcl_cell IMPLEMENTATION.


  METHOD is_flagged.

  ENDMETHOD.

ENDCLASS.
CLASS lcl_array_list DEFINITION.

  PUBLIC SECTION.
    METHODS:
      add
        IMPORTING
          iv_value TYPE ref to lcl_cell.

  PRIVATE SECTION.
    DATA: mt_array_list TYPE int_tab1.

ENDCLASS.

CLASS lcl_array_list IMPLEMENTATION.

  METHOD add.
*    APPEND iv_value TO mt_array_list.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_public_list DEFINITION.

  PUBLIC SECTION.
    METHODS get_flagged_cells "get_them
      RETURNING VALUE(rt_list1) TYPE int_tab.
  PRIVATE SECTION.
    METHODS is_cell_flagged
      IMPORTING
        iv_cell              TYPE i
      RETURNING
        VALUE(rv_is_flagged) TYPE abap_bool.
ENDCLASS.

CLASS lcl_public_list IMPLEMENTATION.

  METHOD get_flagged_cells.
    DATA lt_gameboard TYPE STANDARD TABLE OF ref to lcl_cell.
    DATA(lo_flagged_cells) = NEW lcl_array_list( ).
    LOOP AT lt_gameboard INTO DATA(lo_cell).
      IF lo_cell->is_flagged( ).
        lo_flagged_cells->add( lo_cell ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD is_cell_flagged.
    rv_is_flagged = boolc( iv_cell = 4 ).
  ENDMETHOD.

ENDCLASS.
