REPORT ymj_leap_year_first_version.

INTERFACE yif_leap_year.
  "! this is the entry method for calculating the leap year
  METHODS is_leap_year
    IMPORTING
      iv_year TYPE i
    RETURNING
      value(rv_is_leap_year) TYPE abap_bool.
ENDINTERFACE.

CLASS lcl_leap_year DEFINITION.
*  PUBLIC " Lokal in Report
*  FINAL " könnten erweitert werden, daher nicht
*  CREATE PUBLIC " Instanz könnte überall angelegt werden.

  PUBLIC SECTION.
    INTERFACES yif_leap_year.
    ALIASES is_leap_year FOR yif_leap_year~is_leap_year.

  PROTECTED SECTION.

    METHODS is_normal_leap_year
      IMPORTING
        iv_year TYPE i
      RETURNING
        value(rv_is_normal_leap_year) TYPE abap_bool.
    METHODS is_special_leap_year
          IMPORTING
          iv_year TYPE i
        RETURNING
          value(rv_is_special_leap_year) TYPE abap_bool.

    METHODS is_dividable
      IMPORTING
        iv_digit          TYPE i
        iv_modulo_divider TYPE i
      RETURNING
        value(rv_is_dividable) TYPE abap_bool.
  PRIVATE SECTION.


ENDCLASS.

CLASS lcl_leap_year IMPLEMENTATION.

  METHOD is_leap_year.
    " case oder if oder BOOLC
*    rv_is_leap_year = boolc( iv_year = 1996 OR iv_year = 2000 ).
    rv_is_leap_year = boolc( is_normal_leap_year( iv_year ) = abap_true OR is_special_leap_year( iv_year ) = abap_true  ).
*    IF iv_year = 1996 OR iv_year = 2000.
*      rv_is_leap_year = abap_true.
*    ELSEIF iv_year = 2001 OR iv_year = 1900.
*      rv_is_leap_year = abap_false.
*    ENDIF.
  ENDMETHOD.


  METHOD is_normal_leap_year.
    rv_is_normal_leap_year = boolc( is_dividable( iv_digit = iv_year iv_modulo_divider = 4 )   = abap_true
                               AND  is_dividable( iv_digit = iv_year iv_modulo_divider = 100 ) = abap_false ).
  ENDMETHOD.

  METHOD is_special_leap_year.
    rv_is_special_leap_year = boolc( is_dividable( iv_digit = iv_year iv_modulo_divider = 4 )    = abap_true
                                AND  is_dividable( iv_digit = iv_year iv_modulo_divider = 100 )  = abap_true
                                AND  is_dividable(  iv_digit = iv_year iv_modulo_divider = 400 ) = abap_true ).
  ENDMETHOD.


  METHOD is_dividable.
    rv_is_dividable = boolc( iv_digit MOD iv_modulo_divider = 0 ).
  ENDMETHOD.
ENDCLASS.

CLASS ltcl_leap_year DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      m_cut TYPE REF TO lcl_leap_year.
    METHODS:
      setup,
      " it should be...
      leap_year_for_1996        FOR TESTING,  " so sprechend wie möglich
      not_be_leap_year_for_2001 FOR TESTING,
      leap_year_for_2000        FOR TESTING,
      not_be_leap_year_for_1900 FOR TESTING.
ENDCLASS.


CLASS ltcl_leap_year IMPLEMENTATION.

  METHOD setup.
    CREATE OBJECT m_cut.
  ENDMETHOD.

  METHOD leap_year_for_1996.
    cl_abap_unit_assert=>assert_equals(
               EXPORTING
                 exp = abap_true
                 act = m_cut->is_leap_year( 1996 )
             ).
  ENDMETHOD.


  METHOD not_be_leap_year_for_2001.
    cl_abap_unit_assert=>assert_equals(
               EXPORTING
                 exp = abap_false
                 act = m_cut->is_leap_year( 2001 )
             ).
  ENDMETHOD.

  METHOD leap_year_for_2000.
    cl_abap_unit_assert=>assert_equals(
               EXPORTING
                 exp = abap_true
                 act = m_cut->is_leap_year( 2000 )
             ).

  ENDMETHOD.

  METHOD not_be_leap_year_for_1900.
    cl_abap_unit_assert=>assert_equals(
               EXPORTING
                 exp = abap_false
                 act = m_cut->is_leap_year( 1900 )
             ).
  ENDMETHOD.
ENDCLASS.
