*&---------------------------------------------------------------------*
*& Report ymj_meaningful_context
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_meaningful_context.

CLASS lcl_guess_statistics_message DEFINITION FINAL.

  PUBLIC SECTION.
    METHODS:
      make
        IMPORTING
                  iv_candidate     TYPE char1
                  iv_count         TYPE i
        RETURNING VALUE(rv_string) TYPE string.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA:
      mv_number         TYPE string,
      mv_verb           TYPE string,
      mv_pluralmodifier TYPE string.

    METHODS:
      createpluraldependentmsgparts
        IMPORTING
          iv_count TYPE i,
      therearenoletters,
      thereisoneletter,
      theraremannyletters
        IMPORTING
          iv_count TYPE i.
ENDCLASS.

CLASS lcl_guess_statistics_message IMPLEMENTATION.

  METHOD make.
    me->createpluraldependentmsgparts( iv_count ).
    rv_string = |There { mv_verb } { mv_number } { iv_candidate }{ mv_pluralmodifier }|.
  ENDMETHOD.

  METHOD createpluraldependentmsgparts.
    IF iv_count = 0.
      me->therearenoletters( ).
    ELSEIF iv_count = 1.
      me->thereisoneletter( ).
    ELSE.
      me->theraremannyletters( iv_count ).
    ENDIF.
  ENDMETHOD.

  METHOD therearenoletters.
    mv_number           = 'no'.
    mv_verb             = 'are'.
    mv_pluralmodifier   = 's'.
  ENDMETHOD.

  METHOD thereisoneletter.
    mv_number           = '1'.
    mv_verb             = 'is'.
    mv_pluralmodifier   = ''.
  ENDMETHOD.

  METHOD theraremannyletters.
    mv_number           = CONV string( iv_count ).
    mv_verb             = 'are'.
    mv_pluralmodifier   = 's'.
  ENDMETHOD.

ENDCLASS.
