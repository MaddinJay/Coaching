*&---------------------------------------------------------------------*
*& Report ymj_substitutable_factories
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_substitutable_factories.

INTERFACE litf_employee.
ENDINTERFACE.

INTERFACE litf_timecard.
ENDINTERFACE.


CLASS lcl_oracle_employee_proxy DEFINITION.
  PUBLIC SECTION.
    INTERFACES: litf_employee.
ENDCLASS.

CLASS lcl_oracle_timecard_proxy DEFINITION.
  PUBLIC SECTION.
    INTERFACES: litf_timecard.
ENDCLASS.

CLASS lcl_flatfile_employee_proxy DEFINITION.
  PUBLIC SECTION.
    INTERFACES: litf_employee.
ENDCLASS.

CLASS lcl_flatfile_timecard_proxy DEFINITION.
  PUBLIC SECTION.
    INTERFACES: litf_timecard.
ENDCLASS.

INTERFACE litf_employee_factory.
  METHODS:
    make_employee
      RETURNING VALUE(ro_employee) TYPE REF TO litf_employee,
    make_timecard
      RETURNING VALUE(ro_timecard) TYPE REF TO litf_timecard.
ENDINTERFACE.

CLASS lcl_orcale_employee_factory DEFINITION.
  PUBLIC SECTION.
    INTERFACES: litf_employee_factory.
ENDCLASS.

CLASS lcl_orcale_employee_factory IMPLEMENTATION.

  METHOD litf_employee_factory~make_employee.
    ro_employee = NEW lcl_oracle_employee_proxy( ).
  ENDMETHOD.

  METHOD litf_employee_factory~make_timecard.
    ro_timecard = NEW lcl_oracle_timecard_proxy( ).
  ENDMETHOD.

ENDCLASS.

CLASS lcl_orcale_timecard_factory DEFINITION.
  PUBLIC SECTION.
    INTERFACES: litf_employee_factory.
ENDCLASS.

CLASS lcl_orcale_timecard_factory IMPLEMENTATION.

  METHOD litf_employee_factory~make_employee.
    ro_employee = NEW lcl_flatfile_employee_proxy( ).
  ENDMETHOD.

  METHOD litf_employee_factory~make_timecard.
    ro_timecard = NEW lcl_flatfile_timecard_proxy( ).
  ENDMETHOD.

ENDCLASS.

CLASS lcl_application DEFINITION.
  PUBLIC SECTION.
    METHODS:
      main.
ENDCLASS.

CLASS lcl_application IMPLEMENTATION.
  METHOD main.

  ENDMETHOD.
ENDCLASS.
