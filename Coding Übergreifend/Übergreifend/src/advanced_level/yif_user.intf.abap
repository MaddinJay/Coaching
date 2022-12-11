INTERFACE yif_user PUBLIC.
  METHODS:
    is_locked
      RETURNING VALUE(rv_is_locked) TYPE abap_bool.
ENDINTERFACE.
