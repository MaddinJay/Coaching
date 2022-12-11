*&---------------------------------------------------------------------*
*& Report YMJ_SOLID_OCP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_solid_ocp.

INTERFACE lif_logging.
  DATA:
    mo_log_text TYPE string.
  METHODS:
    set_log,
    get_log
      RETURNING VALUE(rv_log_text) TYPE string.
ENDINTERFACE.

CLASS lcl_application_logging DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_logging.
    ALIASES:
      set_log     FOR lif_logging~set_log,
      get_log     FOR lif_logging~get_log,
      mo_log_text FOR lif_logging~mo_log_text.
ENDCLASS.

CLASS lcl_application_logging IMPLEMENTATION.

  METHOD get_log.
    rv_log_text = mo_log_text.
  ENDMETHOD.

  METHOD set_log.
    mo_log_text = 'Dies ist das Application-Log'.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_db_logging DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_logging.
    ALIASES:
      set_log     FOR lif_logging~set_log,
      get_log     FOR lif_logging~get_log,
      mo_log_text FOR lif_logging~mo_log_text.
ENDCLASS.

CLASS lcl_db_logging IMPLEMENTATION.

  METHOD get_log.
    rv_log_text = mo_log_text.
  ENDMETHOD.

  METHOD set_log.
    mo_log_text = 'Dies ist das Data-Base-Log'.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_send_email DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_log_class_name TYPE abap_abstypename,
      send_email,
      get_log
        RETURNING VALUE(rv_log_text) TYPE string.

  PRIVATE SECTION.
    DATA:
      mo_logging TYPE REF TO lif_logging.

ENDCLASS.

CLASS lcl_send_email IMPLEMENTATION.

  METHOD constructor.
    CREATE OBJECT mo_logging TYPE (iv_log_class_name).
  ENDMETHOD.

  METHOD send_email.
    " Hier wird die Email versendet
    mo_logging->set_log( ).
  ENDMETHOD.

  METHOD get_log.
    rv_log_text = mo_logging->get_log( ).
  ENDMETHOD.

ENDCLASS.

CLASS ltcl_send_email DEFINITION FOR TESTING
                      DURATION SHORT
      RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      " Send email with ...
      application_logging FOR TESTING,
      database_logging    FOR TESTING.
ENDCLASS.

CLASS ltcl_send_email IMPLEMENTATION.

  METHOD application_logging.
    DATA(lo_send_email) = NEW lcl_send_email( 'LCL_APPLICATION_LOGGING' ).

    lo_send_email->send_email( ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = 'Dies ist das Application-Log'
        exp                  = lo_send_email->get_log( )
    ).
  ENDMETHOD.

  METHOD database_logging.
    DATA(lo_send_email) = NEW lcl_send_email( 'LCL_DB_LOGGING' ).

    lo_send_email->send_email( ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = 'Dies ist das Data-Base-Log'
        exp                  = lo_send_email->get_log( )
    ).
  ENDMETHOD.

ENDCLASS.
