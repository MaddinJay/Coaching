REPORT yif_expl_abap_bool_represent.

INTERFACE lif_abap_bool.
  METHODS get_state
       RETURNING
         value(rv_state) TYPE abap_bool.
ENDINTERFACE.

CLASS lcl_abap_bool DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_abap_bool.
    ALIASES get_state FOR lif_abap_bool~get_state.

ENDCLASS.

CLASS lcl_abap_bool IMPLEMENTATION.

  METHOD lif_abap_bool~get_state.

  ENDMETHOD.
ENDCLASS.

CLASS lcl_abap_true DEFINITION
  INHERITING FROM lcl_abap_bool.

  PUBLIC SECTION.

    METHODS get_state REDEFINITION.

  PROTECTED SECTION.

ENDCLASS.

CLASS lcl_abap_true IMPLEMENTATION.

  METHOD get_state.
    rv_state = abap_true.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_abap_false DEFINITION
  INHERITING FROM lcl_abap_bool.

  PUBLIC SECTION.

    METHODS get_state REDEFINITION.

  PROTECTED SECTION.

ENDCLASS.

CLASS lcl_abap_false IMPLEMENTATION.

  METHOD get_state.
    rv_state = abap_false.
  ENDMETHOD.

ENDCLASS.

CLASS ltcl_abap_bool DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mi_cut TYPE REF TO lif_abap_bool.
    METHODS:
      setup,
      " it should be set...
      abap_true_by_object  FOR TESTING,
      abap_false_by_object FOR TESTING.
ENDCLASS.


CLASS ltcl_abap_bool IMPLEMENTATION.
  METHOD setup.
    CREATE OBJECT mi_cut TYPE lcl_abap_bool.
  ENDMETHOD.

  METHOD abap_true_by_object.
    DATA:
      lo_abap_true TYPE REF TO lcl_abap_true.

    CREATE OBJECT lo_abap_true.

    mi_cut = lo_abap_true. " Down-Cast / Widening-Cast

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  = 'X'
        act                  = mi_cut->get_state( )
    ).

  ENDMETHOD.


  METHOD abap_false_by_object.
    DATA:
      lo_abap_false TYPE REF TO lcl_abap_false.

    CREATE OBJECT lo_abap_false.

    mi_cut = lo_abap_false. " Down-Cast / Widening-Cast

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        exp                  = ' '
        act                  = mi_cut->get_state( )
    ).

  ENDMETHOD.
ENDCLASS.
