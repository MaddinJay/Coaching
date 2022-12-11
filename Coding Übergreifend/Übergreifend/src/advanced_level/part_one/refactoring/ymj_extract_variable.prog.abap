*&---------------------------------------------------------------------*
*& Report ymj_extract_variable
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_extract_variable.

CLASS ycl_record DEFINITION FINAL.

  PUBLIC SECTION.
    DATA:
      mv_item_price TYPE amount,
      mv_quantity   TYPE int1.
  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS ycl_record IMPLEMENTATION.

ENDCLASS.



CLASS ycl_order DEFINITION.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          io_record TYPE REF TO ycl_record.
    METHODS: get_price
      RETURNING VALUE(rv_price) TYPE amount.
  PRIVATE SECTION.
    TYPES: ty_helper_type   TYPE p LENGTH 8 DECIMALS 0,
           ty_helper_type_1 TYPE p LENGTH 8 DECIMALS 0.
    DATA mo_data TYPE REF TO ycl_record.
    METHODS get_base_price
      RETURNING
        VALUE(rv_base_price) TYPE amount.
    METHODS get_item_price
      RETURNING VALUE(rv_item_price) TYPE amount.
    METHODS get_quantity
      RETURNING
        VALUE(rv_quantity) TYPE int1.
    METHODS get_quantity_discount
      RETURNING
        VALUE(rv_quantity_discount) TYPE amount.
    METHODS get_shipping_fee
      RETURNING
        VALUE(rv_shipping_fee) TYPE amount.

ENDCLASS.

CLASS ycl_order IMPLEMENTATION.

  METHOD constructor.
    mo_data = io_record.
  ENDMETHOD.

  METHOD get_price.
    rv_price = get_base_price( ) - get_quantity_discount( ) + get_shipping_fee( ).
  ENDMETHOD.


  METHOD get_base_price.
    rv_base_price = get_quantity( ) * get_item_price( ).
  ENDMETHOD.


  METHOD get_item_price.
    rv_item_price = mo_data->mv_item_price.
  ENDMETHOD.


  METHOD get_quantity.
    rv_quantity = mo_data->mv_item_price.
  ENDMETHOD.


  METHOD get_quantity_discount.
    rv_quantity_discount = nmax( val1 = 0 val2 = ( get_quantity( ) - 500 ) ) * get_item_price( ) * '0.05'.
  ENDMETHOD.


  METHOD get_shipping_fee.
    rv_shipping_fee = nmin( val1 = ( get_base_price( ) * '0.1' ) val2 = 100 ).
  ENDMETHOD.

ENDCLASS.
