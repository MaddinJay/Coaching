CLASS ycl_bapi_user DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: yif_bapi_user.
ENDCLASS.



CLASS ycl_bapi_user IMPLEMENTATION.

  METHOD yif_bapi_user~get_lock_data.
    DATA lt_return TYPE bapiret2_tab.

    CALL FUNCTION 'BAPI_USER_GET_DETAIL'
      EXPORTING
        username = iv_user
      IMPORTING
        islocked = rs_lock_data
      TABLES
        return   = lt_return.
  ENDMETHOD.

ENDCLASS.
