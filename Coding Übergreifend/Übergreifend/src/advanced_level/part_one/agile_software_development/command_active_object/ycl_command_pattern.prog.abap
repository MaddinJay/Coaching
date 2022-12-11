*&---------------------------------------------------------------------*
*& Report ycl_command_pattern
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ycl_command_pattern.

INTERFACE itf_relayon_command.
  METHODS:
    do.

ENDINTERFACE.

CLASS ycl_relayon_command DEFINITION.

  PUBLIC SECTION.
    INTERFACES: itf_relayon_command.

ENDCLASS.

CLASS ycl_relayon_command IMPLEMENTATION.

  METHOD itf_relayon_command~do.

  ENDMETHOD.

ENDCLASS.

CLASS ycl_motoron_command DEFINITION.

  PUBLIC SECTION.
    INTERFACES: itf_relayon_command.

ENDCLASS.

CLASS ycl_motoron_command IMPLEMENTATION.

  METHOD itf_relayon_command~do.

  ENDMETHOD.

ENDCLASS.

CLASS ycl_sensor DEFINITION.
  PUBLIC SECTION.
    METHODS:
      execute.
  PRIVATE SECTION.
    DATA: mo_relayon_command TYPE REF TO itf_relayon_command.
ENDCLASS.

CLASS ycl_sensor IMPLEMENTATION.

  METHOD execute.
    mo_relayon_command->do( ).
  ENDMETHOD.

ENDCLASS.
