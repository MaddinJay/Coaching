CLASS ycl_item DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      constructor
        IMPORTING iv_name    TYPE string
                  iv_sell_in TYPE i
                  iv_quality TYPE i,
      description
        RETURNING VALUE(rv_string) TYPE string,
      check_name
        IMPORTING iv_name          TYPE string
        RETURNING VALUE(rv_result) TYPE abap_bool,
      minimize_quality.

    DATA:
      mv_name    TYPE string,
      mv_sell_in TYPE i,
      mv_quality TYPE i.
  PRIVATE SECTION.
    METHODS is_condition4minimize_okay
      RETURNING VALUE(rv_result) TYPE abap_bool.

ENDCLASS.

CLASS ycl_item IMPLEMENTATION.
  METHOD constructor.
    mv_name    = iv_name.
    mv_sell_in = iv_sell_in.
    mv_quality = iv_quality.
  ENDMETHOD.

  METHOD description.
    rv_string = |{ mv_name }, { mv_sell_in }, { mv_quality }|.
  ENDMETHOD.

  METHOD check_name.
    rv_result = xsdbool( mv_name = iv_name ).
  ENDMETHOD.

  METHOD minimize_quality.
    IF is_condition4minimize_okay(  ).
      mv_quality = mv_quality - 1.
    ENDIF.
  ENDMETHOD.

  METHOD is_condition4minimize_okay.
    CHECK mv_quality > 0.
    CHECK check_name( |Aged Brie| ) = abap_false.
    CHECK check_name( |Backstage passes to a TAFKAL80ETC concert| ) = abap_false.
    CHECK check_name( |Sulfuras, Hand of Ragnaros| )                = abap_false.
    rv_result = abap_true.
  ENDMETHOD.
ENDCLASS.
