INTERFACE yif_bapi_user
  PUBLIC .
  METHODS
    get_lock_data
      IMPORTING
                iv_user             TYPE syst_uname
      RETURNING VALUE(rs_lock_data) TYPE bapislockd.
ENDINTERFACE.
