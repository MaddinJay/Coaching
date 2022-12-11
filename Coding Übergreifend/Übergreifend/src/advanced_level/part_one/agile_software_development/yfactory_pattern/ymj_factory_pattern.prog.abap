*&---------------------------------------------------------------------*
*& Report ymj_factory_pattern
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_factory_pattern.

INTERFACE litf_shape.
ENDINTERFACE.

CLASS lcl_square DEFINITION.
  PUBLIC SECTION.
    INTERFACES litf_shape.
ENDCLASS.

CLASS lcl_circle DEFINITION.
  PUBLIC SECTION.
    INTERFACES litf_shape.
ENDCLASS.

CLASS lcl_some_app DEFINITION.
  PUBLIC SECTION.
    METHODS main.
ENDCLASS.

INTERFACE litf_shape_factory.
  CLASS-METHODS:
    make_square
      RETURNING VALUE(ro_square) TYPE REF TO litf_shape,
    make_circle
      RETURNING VALUE(ro_circle) TYPE REF TO litf_shape,
    make_shape
      IMPORTING
                iv_class_name   TYPE string
      RETURNING VALUE(ro_shape) TYPE REF TO litf_shape
      RAISING
                ycx_mj_static_check.
ENDINTERFACE.

CLASS lcl_shape_factory DEFINITION.
  PUBLIC SECTION.
    INTERFACES litf_shape_factory.
ENDCLASS.

CLASS lcl_shape_factory IMPLEMENTATION.

  METHOD litf_shape_factory~make_circle.
    ro_circle = NEW lcl_circle( ).
  ENDMETHOD.

  METHOD litf_shape_factory~make_square.
    ro_square = NEW lcl_square( ).
  ENDMETHOD.

  METHOD litf_shape_factory~make_shape.
    IF iv_class_name = 'Circle'.
      ro_shape = litf_shape_factory~make_circle( ). " Dann noch Privat machen
    ELSEIF iv_class_name = 'Square'.
      ro_shape = litf_shape_factory~make_square( ).
    ELSE.
      DATA(lv_message) = 'Can not create Shape ' && iv_class_name.
      RAISE EXCEPTION TYPE ycx_mj_static_check
        EXPORTING
          iv_message = 'Can not create Shape Circle'.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_some_app IMPLEMENTATION.

  METHOD main.
    DATA(lo_circle) = NEW lcl_circle( ). " Concrete Class, maybe volatile, Dependency

    DATA(lo_circle_fact) = lcl_shape_factory=>litf_shape_factory~make_circle( ).
  ENDMETHOD.

ENDCLASS.

CLASS ltcl_shape_creation DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      test_create_circle FOR TESTING.
ENDCLASS.


CLASS ltcl_shape_creation IMPLEMENTATION.

  METHOD test_create_circle.
    TRY.
        cl_abap_unit_assert=>assert_bound( lcl_shape_factory=>litf_shape_factory~make_shape( 'Circle' ) ). "Enumeration verwenden
      CATCH ycx_mj_static_check.
        cl_abap_unit_assert=>fail( ).
    ENDTRY.
  ENDMETHOD.

ENDCLASS.
