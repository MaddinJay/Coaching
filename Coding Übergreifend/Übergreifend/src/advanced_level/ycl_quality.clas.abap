CLASS ycl_quality DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_quality TYPE i,

      "! Increase Quality by One while lower than 50
      increase_quality,

      "! Get Parameter Quality
      "! @parameter rv_quality |
      get_quality
        RETURNING
          VALUE(rv_quality) TYPE i.

  PRIVATE SECTION.
    DATA:
      mv_quality TYPE i.
    METHODS:
      is_max_quality_not_reached
        RETURNING
          VALUE(rv_result) TYPE abap_bool,
      increment_quality.

ENDCLASS.

CLASS ycl_quality IMPLEMENTATION.

  METHOD constructor.
    mv_quality = iv_quality.
  ENDMETHOD.

  METHOD increase_quality.
    CHECK is_max_quality_not_reached( ).
    increment_quality( ).
  ENDMETHOD.

  METHOD is_max_quality_not_reached.
    rv_result = boolc( mv_quality < 50 ).
  ENDMETHOD.

  METHOD increment_quality.
    mv_quality = mv_quality + 1.
  ENDMETHOD.

  METHOD get_quality.
    rv_quality = mv_quality.
  ENDMETHOD.

ENDCLASS.
