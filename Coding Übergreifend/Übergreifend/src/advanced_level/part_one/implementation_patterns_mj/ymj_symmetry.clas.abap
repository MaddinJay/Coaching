CLASS ymj_symmetry DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      process.
  PRIVATE SECTION.
    DATA:
      mv_counter TYPE i.
    METHODS:
      input,
      output,
      tally.
ENDCLASS.

CLASS ymj_symmetry IMPLEMENTATION.

  METHOD process.
    input( ).
    tally( ). " Describe Intention [ incrementCount( ) <- mv_counter = mv_counter + 1. ]
    output( ).
  ENDMETHOD.

  METHOD input.
    "Do Something
  ENDMETHOD.

  METHOD output.
    " Do Something else
  ENDMETHOD.

  METHOD tally.
*    mv_counter = mv_counter + 1.
  ENDMETHOD.

ENDCLASS.
