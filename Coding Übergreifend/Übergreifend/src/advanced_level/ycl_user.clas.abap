CLASS ycl_user DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: yif_user.
    METHODS constructor
      IMPORTING
        iv_user      TYPE syst_uname
        io_bapi_user TYPE REF TO yif_bapi_user.
  PRIVATE SECTION.
    DATA mv_user TYPE syst_uname.
    DATA mo_bapi_user TYPE REF TO yif_bapi_user.
ENDCLASS.

CLASS ycl_user IMPLEMENTATION.

  METHOD constructor.
    mv_user      = iv_user.
    mo_bapi_user = COND #( WHEN io_bapi_user IS BOUND THEN io_bapi_user
                           ELSE NEW ycl_bapi_user( ) ).
  ENDMETHOD.

  METHOD yif_user~is_locked.
    DATA(ls_lock_data) =  mo_bapi_user->get_lock_data( mv_user ).
    rv_is_locked = xsdbool( ls_lock_data IS NOT INITIAL ).
  ENDMETHOD.

ENDCLASS.
