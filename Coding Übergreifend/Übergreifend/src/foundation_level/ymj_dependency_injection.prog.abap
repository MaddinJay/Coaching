REPORT ymj_dependency_injection.

*----------------------------------------------------------------------*
* -> INTERFACE IF_LOG_PERSISTENCE
*----------------------------------------------------------------------*
INTERFACE if_log_persistence.

  METHODS : save_log IMPORTING p_message TYPE char128.

ENDINTERFACE.                    "IF_LOG_PERSISTENCE

*----------------------------------------------------------------------*
* -> CLASS lc_log_in_email DEFINITION
*----------------------------------------------------------------------*
CLASS lc_log_in_email DEFINITION.

  PUBLIC SECTION.

    INTERFACES : if_log_persistence.

ENDCLASS.                    "lc_log_in_email DEFINITION

*----------------------------------------------------------------------*
* -> CLASS lc_log_in_email IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lc_log_in_email IMPLEMENTATION.

  METHOD if_log_persistence~save_log.

    WRITE / : 'LOG SEND BY EMAIL',
              '-----------------',
              p_message.

  ENDMETHOD.                    "if_log_persistence~save_log

ENDCLASS.                    "lc_log_in_email IMPLEMENTATION

*----------------------------------------------------------------------*
* -> CLASS lc_log_in_file DEFINITION
*----------------------------------------------------------------------*
CLASS lc_log_in_file DEFINITION.

  PUBLIC SECTION.

    INTERFACES : if_log_persistence.

ENDCLASS.                    "lc_log_in_file DEFINITION

*----------------------------------------------------------------------*
* -> CLASS lc_log_in_file IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lc_log_in_file IMPLEMENTATION.

  METHOD if_log_persistence~save_log.

    WRITE / : 'LOG SEND TO FILE',
              '-----------------',
              p_message.

  ENDMETHOD.                    "if_log_persistence~save_log

ENDCLASS.                    "lc_log_in_file IMPLEMENTATION

*----------------------------------------------------------------------*
* -> CLASS lc_log_in_database DEFINITION
*----------------------------------------------------------------------*
CLASS lc_log_in_database DEFINITION.

  PUBLIC SECTION.

    INTERFACES : if_log_persistence.

ENDCLASS.                    "lc_log_in_database DEFINITION

*----------------------------------------------------------------------*
* -> CLASS lc_log_in_database IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lc_log_in_database IMPLEMENTATION.

  METHOD if_log_persistence~save_log.

    WRITE / :  'LOG CREATE IN DATABASE TABLE',
               '-----------------',
               p_message.

  ENDMETHOD.                    "if_log_persistence~save_log

ENDCLASS.                    "lc_log_in_database IMPLEMENTATION

*----------------------------------------------------------------------*
* -> CLASS LC_CALCULATOR DEFINITION
*----------------------------------------------------------------------*
CLASS lc_calculator DEFINITION.

  PUBLIC SECTION.

    METHODS : constructor IMPORTING p_log_target TYPE REF TO if_log_persistence,
              div         IMPORTING p_x TYPE i p_y TYPE i.

  PRIVATE SECTION.

    DATA : v_value TYPE i,
           v_msg   TYPE char128,
           o_log   TYPE REF TO if_log_persistence,
           o_exp   TYPE REF TO cx_sy_zerodivide.

ENDCLASS.                    "LC_CALCULATOR DEFINITION

*----------------------------------------------------------------------*
* -> CLASS LC_CALCULATOR IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lc_calculator IMPLEMENTATION.

  METHOD constructor.

    me->o_log = p_log_target.

  ENDMETHOD.                    "CONSTRUCTOR

  METHOD div.

    TRY.

        me->v_value = ( p_x / p_y ).

        WRITE / : ' Division Operation = ', me->v_value.

      CATCH cx_sy_zerodivide INTO me->o_exp.

        me->v_msg = o_exp->get_text( ).

        o_log->save_log( me->v_msg ).

    ENDTRY.

  ENDMETHOD.                    "DIV

ENDCLASS.                    "LC_CALCULATOR IMPLEMENTATION

************************************************************************
************************************************************************
*                                                                      *
*                           PROGRAM FLOW LOGIC                         *
*                                                                      *
************************************************************************

*----------------------------------------------------------------------*
* -> DEFINE SCREEN ELEMENTS
*----------------------------------------------------------------------*
PARAMETERS : p_ltype TYPE i DEFAULT 1. " Use 1, 2, 3 or 4
" with value of p_ltype

*----------------------------------------------------------------------*
* -> START-OF-SELECTION EVENT PROCESSING
*----------------------------------------------------------------------*
START-OF-SELECTION.

  DATA :   o_log_in_database TYPE REF TO lc_log_in_database,
           o_log_in_file     TYPE REF TO lc_log_in_file,
           o_log_in_email    TYPE REF TO lc_log_in_email,
           o_calculator      TYPE REF TO lc_calculator.

  CASE p_ltype.

    WHEN 1.

      CREATE OBJECT o_log_in_database.

      IF o_log_in_database IS BOUND.

        CREATE OBJECT o_calculator
          EXPORTING
            p_log_target = o_log_in_database.

        IF o_calculator IS BOUND.

          o_calculator->div( EXPORTING p_x = 1 p_y = 1 ). " Sucess
          o_calculator->div( EXPORTING p_x = 1 p_y = 0 ). " Error

        ENDIF.

      ENDIF.

    WHEN 2.

      CREATE OBJECT o_log_in_file.

      IF o_log_in_file IS BOUND.

        CREATE OBJECT o_calculator
          EXPORTING
            p_log_target = o_log_in_file.

        o_calculator->div( EXPORTING p_x = 2 p_y = 1 ). " Sucess
        o_calculator->div( EXPORTING p_x = 2 p_y = 0 ). " Error

      ENDIF.

    WHEN 3.

      CREATE OBJECT o_log_in_email.

      IF o_log_in_email IS BOUND.

        CREATE OBJECT o_calculator
          EXPORTING
            p_log_target = o_log_in_email.

        o_calculator->div( EXPORTING p_x = 3 p_y = 1 ). " Sucess
        o_calculator->div( EXPORTING p_x = 3 p_y = 0 ). " Error

      ENDIF.

    WHEN OTHERS.

      WRITE / 'NO IMPLEMENTATION ACTIVE FOR THIS LOG TYPE'.

  ENDCASE.
