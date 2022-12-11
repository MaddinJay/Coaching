CLASS ycl_russian_multipl DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: yif_russian_multiplication.

ENDCLASS.

CLASS ycl_russian_multipl IMPLEMENTATION.

  METHOD yif_russian_multiplication~calculate.
    DATA(lo_parameter_y) = NEW ycl_parameter_y( iv_value_y ).
    DATA(lo_parameter_x) = NEW ycl_parameter_x( iv_x = iv_value_x io_parameter_y = lo_parameter_y ).
    lo_parameter_x->divide( ).
    rv_sum = lo_parameter_y->get_result( ).
  ENDMETHOD.

ENDCLASS.
