CLASS ycl_parameter_y IMPLEMENTATION.

  METHOD constructor.
    mv_sum = mv_y = iv_y.
  ENDMETHOD.

  METHOD notify.
    double_y( ).
    sum_up( iv_x ).
  ENDMETHOD.

  METHOD get_result.
    rv_sum = mv_sum.
  ENDMETHOD.

  METHOD double_y.
    mv_y = mv_y * 2.
  ENDMETHOD.

  METHOD sum_up.
    IF is_not_dividable_by_2( iv_x ).
      mv_sum = mv_sum + mv_y.
    ENDIF.
  ENDMETHOD.

  METHOD is_not_dividable_by_2.
    rv_is_dividable = xsdbool( iv_x MOD 2 <> 0 ).
  ENDMETHOD.

ENDCLASS.

CLASS ycl_parameter_x IMPLEMENTATION.

  METHOD constructor.
    mv_x = iv_x.
    mo_parameter_y = io_parameter_y.
  ENDMETHOD.

  METHOD divide.
    WHILE mv_x > 1.
      divide_x( ).
      notify_y( ).
    ENDWHILE.
  ENDMETHOD.

  METHOD divide_x.
    mv_x =  round( val  = ( mv_x / 2 )
                   dec  = 0
                   mode = cl_abap_math=>round_down ).
  ENDMETHOD.

  METHOD notify_y.
    mo_parameter_y->notify( mv_x ).
  ENDMETHOD.

ENDCLASS.
