CLASS ycl_code_kata_fizz_buzz DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES
      yif_code_kata_fizzbuzz.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS fizz TYPE string VALUE 'FIZZ' ##NO_TEXT.
    CONSTANTS buzz TYPE string VALUE 'BUZZ' ##NO_TEXT.
    METHODS dividable_by_3
      IMPORTING
        input              TYPE i
      RETURNING
        VALUE(r_dividable) TYPE abap_bool.
    METHODS dividable_by_5
      IMPORTING
        input              TYPE i
      RETURNING
        VALUE(r_dividable) TYPE abap_bool.

ENDCLASS.

CLASS ycl_code_kata_fizz_buzz IMPLEMENTATION.

  METHOD yif_code_kata_fizzbuzz~dividable.
    r_output = COND #( WHEN dividable_by_3( userinput ) AND dividable_by_5( userinput ) THEN fizz && buzz
                       WHEN dividable_by_3( userinput )                                 THEN fizz
                       WHEN dividable_by_5( userinput )                                 THEN buzz
                       ELSE userinput ).
  ENDMETHOD.

  METHOD dividable_by_3.
    r_dividable = boolc( input MOD 3 = 0 ).
  ENDMETHOD.

  METHOD dividable_by_5.
    r_dividable = boolc( input MOD 5 = 0 ).
  ENDMETHOD.

ENDCLASS.
