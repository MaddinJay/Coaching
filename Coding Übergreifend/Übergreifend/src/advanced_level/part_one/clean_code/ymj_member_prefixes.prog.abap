*&---------------------------------------------------------------------*
*& Report ymj_member_prefixes
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_member_prefixes.

CLASS part DEFINITION.
  PUBLIC SECTION.
    METHODS:
      set_description
        IMPORTING
          description TYPE string.
  PRIVATE SECTION.
    DATA: description TYPE string.
ENDCLASS.

CLASS part IMPLEMENTATION.

  METHOD set_description.
    me->description = description.
  ENDMETHOD.

ENDCLASS.
