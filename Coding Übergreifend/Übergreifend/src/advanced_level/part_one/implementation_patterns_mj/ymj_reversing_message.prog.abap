*&---------------------------------------------------------------------*
*& Report ymj_reversing_message
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_reversing_message.

CLASS lcl_helper DEFINITION FINAL.

  PUBLIC SECTION.
    METHODS:
      compute.

  PRIVATE SECTION.
    METHODS:
      input,
      output,
      process.

ENDCLASS.

CLASS lcl_helper IMPLEMENTATION.

  METHOD process.
    " Do Something
  ENDMETHOD.

  METHOD compute.
    input( ).
    process( ).
    output( ).
  ENDMETHOD.

  METHOD input.

  ENDMETHOD.

  METHOD output.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_main DEFINITION.

  PUBLIC SECTION.
    METHODS:
      compute.

ENDCLASS.

CLASS lcl_main IMPLEMENTATION.

  METHOD compute.
    NEW lcl_helper( )->compute( ). "process( ).
  ENDMETHOD.

ENDCLASS.
