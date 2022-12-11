CLASS ycl_report DEFINITION
  PUBLIC
  CREATE PUBLIC
  ABSTRACT.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_print_message TYPE string,
      print.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      mv_print_message TYPE string.
    METHODS printhtml.
    METHODS printxml.

ENDCLASS.

CLASS ycl_report IMPLEMENTATION.
  METHOD constructor.
    mv_print_message = iv_print_message.
  ENDMETHOD.

  METHOD print.
*    CASE mv_print_message.
*      WHEN 'printHTML'.
*        printhtml( ).
*      WHEN 'printXML'.
*        printxml( ).
*    ENDCASE.
    CALL METHOD me->(mv_print_message).
  ENDMETHOD.

  METHOD printhtml.

  ENDMETHOD.

  METHOD printxml.

  ENDMETHOD.

ENDCLASS.
