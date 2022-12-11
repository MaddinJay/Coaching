*&---------------------------------------------------------------------*
*& Report ycl_command_pattern_transact
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ycl_command_pattern_transact.


INTERFACE lif_pay_classification.
  METHODS:
    calculate_pay.
ENDINTERFACE.

CLASS ycl_employee DEFINITION.

  PRIVATE SECTION.
    DATA:
      mv_name    TYPE string,
      mv_address TYPE string.
ENDCLASS.

CLASS ycl_employee IMPLEMENTATION.

ENDCLASS.

CLASS ycl_salaried_classification DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_pay_classification.
  PRIVATE SECTION.
    DATA:
      mv_monthly_pay TYPE betrh_kk.
ENDCLASS.

CLASS ycl_salaried_classification IMPLEMENTATION.

  METHOD lif_pay_classification~calculate_pay.

  ENDMETHOD.

ENDCLASS.

INTERFACE lif_transaction.
  METHODS:
    validate,
    execute.
ENDINTERFACE.
CLASS ycl_add_employee_trans DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_transaction.
  PRIVATE SECTION.
    DATA:
      mv_name    TYPE string,
      mv_address TYPE string.
ENDCLASS.

CLASS ycl_add_employee_trans IMPLEMENTATION.

  METHOD lif_transaction~execute.

  ENDMETHOD.

  METHOD lif_transaction~validate.

  ENDMETHOD.

ENDCLASS.
