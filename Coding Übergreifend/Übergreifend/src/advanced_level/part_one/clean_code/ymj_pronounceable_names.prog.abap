*&---------------------------------------------------------------------*
*& Report ymj_pronounceable_names
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_pronounceable_names.

CLASS lcl_customer DEFINITION.

  PRIVATE SECTION.
    DATA:
      generationtimestamp   TYPE datum,
      modificationtimestamp TYPE datum,
      recordid              TYPE string VALUE '102'.
ENDCLASS.

CLASS lcl_customer IMPLEMENTATION.

ENDCLASS.
