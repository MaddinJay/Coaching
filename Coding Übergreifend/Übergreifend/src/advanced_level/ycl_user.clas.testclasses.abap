CLASS ltcl_user DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut       TYPE REF TO yif_user,
      mo_bapi_user TYPE REF TO yif_bapi_user.
    METHODS:
      setup,
      user_is_locked FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltcl_user IMPLEMENTATION.

  METHOD setup.
    mo_bapi_user ?= cl_abap_testdouble=>create( 'yif_bapi_user' ).

    mo_cut = NEW ycl_user( iv_user      = 'P17171'
                           io_bapi_user = mo_bapi_user ).
  ENDMETHOD.

  METHOD user_is_locked.
    cl_abap_testdouble=>configure_call( mo_bapi_user )->returning( VALUE bapislockd( glob_lock = abap_true ) ).
    mo_bapi_user->get_lock_data( 'P17171' ).
    cl_abap_unit_assert=>assert_true( act = mo_cut->is_locked( ) ).
  ENDMETHOD.

ENDCLASS.
