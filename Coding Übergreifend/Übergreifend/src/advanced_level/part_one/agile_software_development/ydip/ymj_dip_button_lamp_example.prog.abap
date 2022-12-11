*&---------------------------------------------------------------------*
*& Report ymj_dip_button_lamp_example
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_dip_button_lamp_example.

INTERFACE litf_buttonserver.
  METHODS:
    turnoff,
    turnon.
ENDINTERFACE.

CLASS lcl_lamp DEFINITION.
  PUBLIC SECTION.
    INTERFACES litf_buttonserver.
ENDCLASS.

CLASS lcl_lamp IMPLEMENTATION.
  METHOD litf_buttonserver~turnoff.

  ENDMETHOD.

  METHOD litf_buttonserver~turnon.

  ENDMETHOD.
ENDCLASS.

CLASS lcl_button DEFINITION.
  PUBLIC SECTION.
    METHODS:
      poll.
  PRIVATE SECTION.
    DATA:
      mo_buttonserver TYPE REF TO litf_buttonserver.
ENDCLASS.

CLASS lcl_button IMPLEMENTATION.
  METHOD poll.
    " Use mo_buttonserver
  ENDMETHOD.
ENDCLASS.
