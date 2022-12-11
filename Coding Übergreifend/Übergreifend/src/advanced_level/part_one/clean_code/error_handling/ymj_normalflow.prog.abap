*&---------------------------------------------------------------------*
*& Report ymj_normal_flow
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_normalflow.

CLASS lx_meal_expenses_not_found DEFINITION INHERITING FROM cx_static_check FINAL.

  PUBLIC SECTION.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS lx_meal_expenses_not_found IMPLEMENTATION.

ENDCLASS.



CLASS lcl_employee DEFINITION.

  PUBLIC SECTION.
    METHODS:
      get_id
        RETURNING VALUE(rv_id) TYPE i.
ENDCLASS.

CLASS lcl_employee IMPLEMENTATION.

  METHOD get_id.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_expenses DEFINITION.
  PUBLIC SECTION.
    METHODS:
      get_total
        RETURNING VALUE(rv_total) TYPE i.
ENDCLASS.

CLASS lcl_expenses IMPLEMENTATION.

  METHOD get_total.

  ENDMETHOD.

ENDCLASS.
CLASS lcl_expensereportdao DEFINITION.

  PUBLIC SECTION.
    METHODS: main,
      main2,
      get_meals
        IMPORTING
                  iv_employee_id  TYPE i
        RETURNING VALUE(rt_meals) TYPE string_t,
      get_meals2
        IMPORTING
                  iv_employee_id     TYPE i
        RETURNING VALUE(ro_expenses) TYPE REF TO lcl_expenses.
  PRIVATE SECTION.
    DATA mv_total TYPE i.
    METHODS get_meal_per_diem
      RETURNING VALUE(rv_meal_per_diem) TYPE i.
ENDCLASS.

CLASS lcl_expensereportdao IMPLEMENTATION.

  METHOD main.
    TRY.
        DATA(lo_employee) = NEW lcl_employee( ).
        DATA(lo_expenses) = NEW lcl_expensereportdao( )->get_meals( lo_employee->get_id( ) ).
      CATCH lx_meal_expenses_not_found INTO DATA(lo_meal_expenses_not_found).
        mv_total = mv_total + get_meal_per_diem( ).
    ENDTRY.
  ENDMETHOD.

  METHOD main2.
    DATA(lo_employee) = NEW lcl_employee( ).
    DATA(lo_expenses) = NEW lcl_expensereportdao( )->get_meals2( lo_employee->get_id( ) ).
    mv_total = mv_total + lo_expenses->get_total( ).
  ENDMETHOD.

  METHOD get_meals.

  ENDMETHOD.

  METHOD get_meal_per_diem.

  ENDMETHOD.

  METHOD get_meals2.
    " Return PerDiemDefault
  ENDMETHOD.

ENDCLASS.
