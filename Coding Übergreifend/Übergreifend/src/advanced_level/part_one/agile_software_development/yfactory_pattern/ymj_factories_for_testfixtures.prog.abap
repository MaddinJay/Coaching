*&---------------------------------------------------------------------*
*& Report ymj_factories_for_testfixtures
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_factories_for_testfixtures.

INTERFACE litf_database.
ENDINTERFACE.

INTERFACE litf_database_factory.
  METHODS:
    create_database_instance
      RETURNING VALUE(ro_database) TYPE REF TO litf_database.
ENDINTERFACE.


CLASS lcl_database_factory_test DEFINITION FINAL.

  PUBLIC SECTION.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_database_factory_test IMPLEMENTATION.

ENDCLASS.

CLASS lcl_database DEFINITION.
  PUBLIC SECTION.
    INTERFACES: litf_database.

ENDCLASS.

CLASS lcl_database IMPLEMENTATION.

ENDCLASS.

CLASS lcl_payroll DEFINITION.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          io_database_factory TYPE REF TO litf_database_factory.
  PRIVATE SECTION.
    DATA: mo_database TYPE REF TO litf_database.
ENDCLASS.

CLASS lcl_payroll IMPLEMENTATION.

  METHOD constructor.
    mo_database = io_database_factory->create_database_instance( ).
  ENDMETHOD.

ENDCLASS.

CLASS lcl_database_factory DEFINITION.
  PUBLIC SECTION.
    INTERFACES litf_database_factory.
ENDCLASS.

CLASS lcl_database_factory IMPLEMENTATION.

  METHOD litf_database_factory~create_database_instance.
    " Some Implementation
  ENDMETHOD.

ENDCLASS.

CLASS lcl_database_factorytest DEFINITION.
  PUBLIC SECTION.
    INTERFACES litf_database_factory.
ENDCLASS.

CLASS lcl_database_factorytest IMPLEMENTATION.

  METHOD litf_database_factory~create_database_instance.
    " Some other Implementation
  ENDMETHOD.

ENDCLASS.

CLASS ltcl_payroll_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      use_database_factory FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS ltcl_payroll_test IMPLEMENTATION.

  METHOD use_database_factory.
    DATA(lo_payroll_test) = NEW lcl_payroll( NEW lcl_database_factorytest( ) ).
  ENDMETHOD.

ENDCLASS.
