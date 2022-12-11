INTERFACE yif_code_cracker
  PUBLIC .
  METHODS:
    descript
      IMPORTING
        iv_text                   TYPE string
      RETURNING
        VALUE(rv_descripted_text) TYPE string.

ENDINTERFACE.
