CLASS ycl_pair DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING iv_from TYPE string
                            iv_to   TYPE string.

    METHODS equals      IMPORTING io_pair            TYPE REF TO ycl_pair
                        RETURNING VALUE(rv_is_equal) TYPE abap_bool.

    METHODS hash_code   RETURNING VALUE(rv_hash_code) TYPE int1.

  PRIVATE SECTION.
    DATA:
      mv_from TYPE string,
      mv_to   TYPE string.

ENDCLASS.

CLASS ycl_pair IMPLEMENTATION.

  METHOD constructor.
    mv_from = iv_from.
    mv_to   = iv_to.
  ENDMETHOD.

  METHOD equals.
    rv_is_equal = xsdbool( io_pair->mv_from = mv_from AND io_pair->mv_to = mv_to ).
  ENDMETHOD.

  METHOD hash_code.
    rv_hash_code = 0.
  ENDMETHOD.

ENDCLASS.
