CLASS ycl_parameter_y DEFINITION FINAL.

  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING iv_y TYPE int4,
      notify      IMPORTING iv_x TYPE int4,
      get_result     RETURNING VALUE(rv_sum) TYPE int4.

  PRIVATE SECTION.
    DATA:
      mv_y   TYPE int4,
      mv_sum TYPE int4.

    METHODS:
      double_y,
      sum_up                IMPORTING iv_x                   TYPE int4,
      is_not_dividable_by_2 IMPORTING iv_x                   TYPE int4
                            RETURNING VALUE(rv_is_dividable) TYPE abap_bool.

ENDCLASS.

CLASS ycl_parameter_x DEFINITION
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING iv_x           TYPE int4
                            io_parameter_y TYPE REF TO ycl_parameter_y,
      divide.

  PRIVATE SECTION.
    DATA:
      mo_parameter_y TYPE REF TO ycl_parameter_y,
      mv_x           TYPE int4.

    METHODS:
      divide_x,
      notify_y.
ENDCLASS.
