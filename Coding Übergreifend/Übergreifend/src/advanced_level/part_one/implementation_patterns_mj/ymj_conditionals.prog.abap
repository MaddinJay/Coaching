*&---------------------------------------------------------------------*
*& Report ymj_conditionals
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_conditionals.

CLASS lcl_delegation DEFINITION.

  PUBLIC SECTION.
    METHODS:
      case_study.
ENDCLASS.

CLASS lcl_delegation IMPLEMENTATION.

  METHOD case_study.
    " Do Case Study
  ENDMETHOD.

ENDCLASS.

CLASS lcl_conditionals DEFINITION.

  PRIVATE SECTION.
    METHODS:
      cases
        RETURNING VALUE(rv_result) TYPE string,
      conditional
        RETURNING VALUE(rv_result) TYPE string,
      delegation,
      get_language
        RETURNING
          VALUE(rv_type) TYPE string,
      get_delegation
        RETURNING
          VALUE(ro_delegation) TYPE REF TO lcl_delegation.
ENDCLASS.

CLASS lcl_conditionals IMPLEMENTATION.

  METHOD cases.
    CASE get_language( ).
      WHEN 'DE'.
        rv_result = 'Hallo'.
      WHEN 'IT'.
        rv_result = 'Ciao'.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

  METHOD get_language.
    " Liefer Sprache
  ENDMETHOD.

  METHOD conditional.
    rv_result = SWITCH #( get_language( )
                          WHEN 'DE' THEN 'Hallo'
                          WHEN 'IT' THEN 'Ciao' ).
  ENDMETHOD.

  METHOD delegation.
    get_delegation( )->case_study( ).
  ENDMETHOD.


  METHOD get_delegation.
    ro_delegation = NEW lcl_delegation( ).
  ENDMETHOD.

ENDCLASS.
