*&---------------------------------------------------------------------*
*& Report ymj_switch_statement
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_switch_statement.

CLASS lcl_employee DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_employee_record TYPE string,
      is_payday
        RETURNING VALUE(rv_is_payday) TYPE abap_bool,
      calculate_pay
        RETURNING VALUE(rv_pay) TYPE curr17_2,
      deliver_pay
        IMPORTING
          iv_pay TYPE curr17_2.
ENDCLASS.

CLASS lcx_invalidemployeetype DEFINITION INHERITING FROM lcl_employee.
ENDCLASS.

CLASS lcx_invalidemployeetype IMPLEMENTATION.
ENDCLASS.

CLASS commisionedemployee DEFINITION INHERITING FROM lcl_employee.
ENDCLASS.

CLASS commisionedemployee IMPLEMENTATION.
ENDCLASS.

CLASS slariedemployee DEFINITION INHERITING FROM lcl_employee.
ENDCLASS.

CLASS slariedemployee IMPLEMENTATION.
ENDCLASS.

CLASS hourlyemployee DEFINITION INHERITING FROM lcl_employee.
ENDCLASS.

CLASS hourlyemployee IMPLEMENTATION.
ENDCLASS.

CLASS lcl_employee IMPLEMENTATION.

  METHOD is_payday.

  ENDMETHOD.

  METHOD calculate_pay.

  ENDMETHOD.

  METHOD deliver_pay.

  ENDMETHOD.

  METHOD constructor.

  ENDMETHOD.

ENDCLASS.

INTERFACE lif_employeefactory.
  METHODS:
    makeemployee
      IMPORTING
        iv_employee_record TYPE string
      RETURNING
        VALUE(ro_employee) TYPE REF TO lcl_employee.

ENDINTERFACE.

CLASS lcl_employeefactory DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_employeefactory.
ENDCLASS.

CLASS lcl_employeefactory IMPLEMENTATION.

  METHOD lif_employeefactory~makeemployee.
    ro_employee = SWITCH #( iv_employee_record
                            WHEN 'COMMISSIONED' THEN NEW commisionedemployee( iv_employee_record )
                            WHEN 'HOURLY'       THEN NEW hourlyemployee( iv_employee_record )
                            WHEN 'SALARIED'     THEN NEW slariedemployee( iv_employee_record )
                            ELSE NEW lcx_invalidemployeetype( iv_employee_record ) ).
  ENDMETHOD.

ENDCLASS.
