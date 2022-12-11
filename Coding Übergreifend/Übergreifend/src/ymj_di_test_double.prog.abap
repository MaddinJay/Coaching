*&---------------------------------------------------------------------*
*& Report ymj_di_test_double
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_di_test_double.

INTERFACE lif_printing.

  METHODS print_text
    RETURNING VALUE(rv_text) TYPE string.

ENDINTERFACE.
**********************************************************************
CLASS lcl_main_class DEFINITION.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING io_printing TYPE REF TO lif_printing,
      method_under_test
        RETURNING VALUE(rv_return_text) TYPE string.

  PRIVATE SECTION.
    DATA:
      mo_printing TYPE REF TO lif_printing.

ENDCLASS.

CLASS lcl_main_class IMPLEMENTATION.

  METHOD method_under_test.
    rv_return_text = mo_printing->print_text( ).
  ENDMETHOD.

  METHOD constructor.
    mo_printing = io_printing.
  ENDMETHOD.

ENDCLASS.
**********************************************************************
CLASS lcl_printing_main DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_printing.
    ALIASES print_text FOR lif_printing~print_text.
  PRIVATE SECTION.
    CONSTANTS mc_printed_text TYPE string VALUE 'Dies ist die Main-Printing-Methode.' ##NO_TEXT.
ENDCLASS.

CLASS lcl_printing_main IMPLEMENTATION.

  METHOD lif_printing~print_text.
    rv_text = mc_printed_text.
  ENDMETHOD.

ENDCLASS.
**********************************************************************
CLASS lcl_printing_main_double DEFINITION.

  PUBLIC SECTION.
    INTERFACES lif_printing.
    ALIASES print_text FOR lif_printing~print_text.
  PRIVATE SECTION.
    CONSTANTS mc_printed_text TYPE string VALUE 'Dies ist die Methode der Double-Klasse.' ##NO_TEXT.

ENDCLASS.

CLASS lcl_printing_main_double IMPLEMENTATION.

  METHOD lif_printing~print_text.
    rv_text = mc_printed_text.
  ENDMETHOD.

ENDCLASS.
**********************************************************************
CLASS ltcl_main_class DEFINITION FOR TESTING
                      RISK LEVEL HARMLESS
                      DURATION SHORT.

  PRIVATE SECTION.
    METHODS:
      " Test Printing with ...
      main_class_method FOR TESTING,
      double_class_method FOR TESTING.

ENDCLASS.

CLASS ltcl_main_class IMPLEMENTATION.

  METHOD double_class_method.
    DATA(lo_printing_main_double) = NEW lcl_printing_main_double( ).
    DATA(lo_main_class)           = NEW lcl_main_class( lo_printing_main_double ).
    cl_abap_unit_assert=>assert_equals( exp = 'Dies ist die Methode der Double-Klasse.' act = lo_main_class->method_under_test( ) ).
  ENDMETHOD.

  METHOD main_class_method.
    DATA(lo_printing_main) = NEW lcl_printing_main( ).
    DATA(lo_main_class)    = NEW lcl_main_class( lo_printing_main ).
    cl_abap_unit_assert=>assert_equals( exp = 'Dies ist die Main-Printing-Methode.' act = lo_main_class->method_under_test( ) ).
  ENDMETHOD.

ENDCLASS.
