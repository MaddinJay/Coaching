*&---------------------------------------------------------------------*
*& Report ymj_linked_list
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_linked_list.

CLASS lcx_linked_list DEFINITION INHERITING FROM ycx_mj_static_check.

  PUBLIC SECTION.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcx_linked_list IMPLEMENTATION.

ENDCLASS.

CLASS lcl_linked_list DEFINITION DEFERRED.

INTERFACE lif_linked_list.

  TYPES: tt_linked_list TYPE STANDARD TABLE OF REF TO lcl_linked_list WITH DEFAULT KEY.

  METHODS:
    get_list
      RETURNING VALUE(rt_list) TYPE tt_linked_list,
    get_distinct_value
      IMPORTING iv_value       TYPE string
      RETURNING VALUE(ro_node) TYPE REF TO lcl_linked_list
      RAISING   lcx_linked_list,
    delete_node
      IMPORTING iv_value          TYPE string
      RETURNING VALUE(rv_deleted) TYPE abap_bool
      RAISING   lcx_linked_list,
    add_node
      IMPORTING
        iv_value TYPE string.

ENDINTERFACE.

CLASS lcl_linked_list DEFINITION.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_value TYPE string,
      set_next
        IMPORTING
          io_node TYPE REF TO lcl_linked_list,
      get_next
        RETURNING
          VALUE(ro_linked_list) TYPE REF TO lcl_linked_list,
      get_value
        RETURNING
          VALUE(rv_value) TYPE string.
  PRIVATE SECTION.
    DATA mv_value TYPE string.
    DATA mv_next  TYPE REF TO lcl_linked_list.
ENDCLASS.

CLASS lcl_linked_list IMPLEMENTATION.
  METHOD constructor.
    mv_value = iv_value.
  ENDMETHOD.

  METHOD set_next.
    me->mv_next = io_node.
  ENDMETHOD.

  METHOD get_next.
    ro_linked_list = me->mv_next.
  ENDMETHOD.

  METHOD get_value.
    rv_value = me->mv_value.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_linked_list_api DEFINITION.

  PUBLIC SECTION.
    INTERFACES lif_linked_list.
    ALIASES:
      get_list           FOR lif_linked_list~get_list,
      get_distinct_value FOR lif_linked_list~get_distinct_value,
      delete_node        FOR lif_linked_list~delete_node,
      add_node           FOR lif_linked_list~add_node,
      tt_linked_list     FOR lif_linked_list~tt_linked_list.

  PRIVATE SECTION.
    DATA:
      mt_linked_list TYPE tt_linked_list.
    DATA: mv_previous_node  TYPE REF TO lcl_linked_list,
          mo_node_to_delete TYPE REF TO lcl_linked_list,
          mo_distinct_node  TYPE REF TO lcl_linked_list.

    METHODS:
      add_node_to_list
        IMPORTING
          io_actual_node TYPE REF TO lcl_linked_list,
      set_next_in_previous_node
        IMPORTING
          io_actual_node TYPE REF TO lcl_linked_list,
      get_previous_node
        RETURNING
          VALUE(ro_linked_list) TYPE REF TO lcl_linked_list,
      does_previous_node_exist
        RETURNING VALUE(rv_previous_node_exists) TYPE abap_bool,
      is_node_to_delete
        IMPORTING
          iv_value               TYPE string
          io_node                TYPE REF TO lcl_linked_list
        RETURNING
          VALUE(rv_is_to_delete) TYPE abap_bool,
      change_next_in_previous_node
        IMPORTING
          io_node_to_delete TYPE REF TO lcl_linked_list,
      delete_node_from_list
        IMPORTING
          io_node_to_delete TYPE REF TO lcl_linked_list,
      notice_previous_node
        IMPORTING
          io_actual_node TYPE REF TO lcl_linked_list,
      set_node_to_delete
        IMPORTING
          iv_value TYPE string,
      raise_exception_not_existing
        IMPORTING
          iv_value TYPE string
        RAISING
          lcx_linked_list,
      execute_delete
        RETURNING VALUE(rv_deleted) TYPE abap_bool,
      find_node_to_delete
        IMPORTING
          iv_value             TYPE any
        RETURNING
          VALUE(rv_node_found) TYPE abap_bool,
      is_node_found
        IMPORTING
          io_node              TYPE REF TO lcl_linked_list
        RETURNING
          VALUE(rv_node_found) TYPE abap_bool,
      notice_node_to_delete
        IMPORTING
          io_actual_node TYPE REF TO lcl_linked_list,
      is_requested_node
        IMPORTING
          io_actual_node              TYPE REF TO lcl_linked_list
          iv_value                    TYPE string
        RETURNING
          VALUE(rv_is_requested_node) TYPE abap_bool,
      set_distinct_node
        IMPORTING
          iv_value TYPE string,
      get_distinct_node
        RETURNING
          VALUE(ro_node) TYPE REF TO lcl_linked_list.

ENDCLASS.

CLASS lcl_linked_list_api IMPLEMENTATION.
  METHOD lif_linked_list~add_node.
    DATA(lo_actual_node) = NEW lcl_linked_list( iv_value ).

    set_next_in_previous_node( lo_actual_node ).
    add_node_to_list( lo_actual_node ).
  ENDMETHOD.

  METHOD add_node_to_list.
    APPEND io_actual_node TO mt_linked_list.
  ENDMETHOD.

  METHOD lif_linked_list~delete_node.
    IF find_node_to_delete( iv_value ).
      execute_delete( ).
    ELSE.
      raise_exception_not_existing( iv_value ).
    ENDIF.
  ENDMETHOD.

  METHOD raise_exception_not_existing.
    MESSAGE i008(ymj_coaching) INTO DATA(lv_message) WITH iv_value.
    RAISE EXCEPTION TYPE lcx_linked_list
      EXPORTING
        iv_message = lv_message.
  ENDMETHOD.

  METHOD lif_linked_list~get_distinct_value.
    set_distinct_node( iv_value ).
    IF is_node_found( get_distinct_node( ) ).
      ro_node = get_distinct_node( ).
    ELSE.
      raise_exception_not_existing( iv_value ).
    ENDIF.
  ENDMETHOD.

  METHOD lif_linked_list~get_list.
    rt_list = mt_linked_list.
  ENDMETHOD.

  METHOD set_next_in_previous_node.
    CHECK does_previous_node_exist(  ).
    get_previous_node( )->set_next( io_actual_node ).
  ENDMETHOD.

  METHOD get_previous_node.
    READ TABLE mt_linked_list ASSIGNING FIELD-SYMBOL(<lo_linked_list>) INDEX lines( mt_linked_list ).
    ro_linked_list = <lo_linked_list>.
  ENDMETHOD.

  METHOD does_previous_node_exist.
    rv_previous_node_exists = boolc( mt_linked_list IS NOT INITIAL ).
  ENDMETHOD.

  METHOD is_node_to_delete.
    rv_is_to_delete = boolc( iv_value = io_node->get_value( ) ).
  ENDMETHOD.

  METHOD change_next_in_previous_node.
    CHECK mv_previous_node IS BOUND.
    mv_previous_node->set_next( io_node_to_delete->get_next( ) ).
  ENDMETHOD.

  METHOD delete_node_from_list.
    DELETE TABLE mt_linked_list FROM io_node_to_delete.
  ENDMETHOD.

  METHOD notice_previous_node.
    mv_previous_node = io_actual_node.
  ENDMETHOD.

  METHOD set_node_to_delete.
    LOOP AT mt_linked_list INTO DATA(lo_actual_node).
      IF is_node_to_delete( iv_value = iv_value
                            io_node  = lo_actual_node ).
        notice_node_to_delete( lo_actual_node ).
        RETURN.
      ELSE.
        notice_previous_node( lo_actual_node ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD notice_node_to_delete.
    mo_node_to_delete = io_actual_node.
  ENDMETHOD.

  METHOD execute_delete.
    change_next_in_previous_node( mo_node_to_delete ).
    delete_node_from_list( mo_node_to_delete ).
    rv_deleted = abap_true.
  ENDMETHOD.

  METHOD find_node_to_delete.
    set_node_to_delete( iv_value ).
    rv_node_found = is_node_found( mo_node_to_delete ).
  ENDMETHOD.

  METHOD is_node_found.
    rv_node_found = boolc( io_node IS BOUND ).
  ENDMETHOD.

  METHOD is_requested_node.
    rv_is_requested_node = boolc( io_actual_node->get_value( ) = iv_value ).
  ENDMETHOD.

  METHOD set_distinct_node.
    LOOP AT mt_linked_list INTO DATA(lo_actual_node).
      IF is_requested_node( io_actual_node = lo_actual_node iv_value = iv_value ).
        mo_distinct_node = lo_actual_node.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_distinct_node.
    ro_node = mo_distinct_node.
  ENDMETHOD.

ENDCLASS.

CLASS ltcl_linked_list DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CONSTANTS first_node TYPE i VALUE 1.
    DATA:
      mo_cut TYPE REF TO lcl_linked_list_api.

    METHODS:
      setup,
**********************************************************************
      " It should be ...
      delete_and_change_prev_next   FOR TESTING,
      raise_exception_delete_failed FOR TESTING,
      get_distinct_value            FOR TESTING,
      raise_exception_get_distinct  FOR TESTING,
**********************************************************************
      get_node_by_index
        IMPORTING
          iv_index       TYPE i
        RETURNING
          VALUE(ro_node) TYPE REF TO lcl_linked_list.
ENDCLASS.

CLASS ltcl_linked_list IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW #( ).
  ENDMETHOD.

  METHOD delete_and_change_prev_next.
    mo_cut->add_node( 'Erster Knoten' ).
    mo_cut->add_node( 'Zweiter Knoten' ).
    mo_cut->add_node( 'Dritter Knoten' ).
    mo_cut->delete_node( 'Zweiter Knoten' ).

    cl_abap_unit_assert=>assert_equals( exp = 'Dritter Knoten' act = get_node_by_index( first_node )->get_next( )->get_value( ) ).
  ENDMETHOD.

  METHOD raise_exception_delete_failed.
    TRY.
        mo_cut->delete_node( 'Erster Knoten' ).
      CATCH lcx_linked_list INTO DATA(lo_linked_list).
        cl_abap_unit_assert=>assert_equals( exp = 'Knoten "Erster Knoten" existiert in der Liste nicht.' act = lo_linked_list->get_message( ) ).
    ENDTRY.
  ENDMETHOD.

  METHOD get_distinct_value.
    mo_cut->add_node( 'Erster Knoten' ).
    mo_cut->add_node( 'Zweiter Knoten' ).

    cl_abap_unit_assert=>assert_bound( act = mo_cut->get_distinct_value( 'Zweiter Knoten' ) ).
  ENDMETHOD.

  METHOD raise_exception_get_distinct.
    TRY.
        DATA(lo_node) = mo_cut->get_distinct_value( 'Erster Knoten' ).
      CATCH lcx_linked_list INTO DATA(lo_linked_list).
        cl_abap_unit_assert=>assert_equals( exp = 'Knoten "Erster Knoten" existiert in der Liste nicht.' act = lo_linked_list->get_message( ) ).
    ENDTRY.
  ENDMETHOD.

  METHOD get_node_by_index.
    DATA(lt_list) = mo_cut->get_list( ).
    READ TABLE lt_list INTO ro_node INDEX first_node.
  ENDMETHOD.

ENDCLASS.
