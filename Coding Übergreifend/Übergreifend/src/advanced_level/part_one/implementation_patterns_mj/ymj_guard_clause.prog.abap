*&---------------------------------------------------------------------*
*& Report ymj_guard_clause
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_guard_clause.

CLASS lcl_request DEFINITION.
  PUBLIC SECTION.
    METHODS:
      process.
ENDCLASS.

CLASS lcl_request IMPLEMENTATION.

  METHOD process.
    " Do something
  ENDMETHOD.

ENDCLASS.
CLASS lcl_client DEFINITION.
  PUBLIC SECTION.
    METHODS:
      get_request
        RETURNING VALUE(ro_request) TYPE REF TO lcl_request.
ENDCLASS.

CLASS lcl_client IMPLEMENTATION.

  METHOD get_request.

  ENDMETHOD.

ENDCLASS.
CLASS lcl_server DEFINITION.
  PUBLIC SECTION.
    METHODS:
      get_server
        RETURNING VALUE(ro_server) TYPE REF TO lcl_server,
      get_client
        RETURNING VALUE(ro_client) TYPE REF TO lcl_client.
ENDCLASS.

CLASS lcl_server IMPLEMENTATION.

  METHOD get_server.

  ENDMETHOD.

  METHOD get_client.

  ENDMETHOD.

ENDCLASS.
CLASS lcl_main DEFINITION.

  PUBLIC SECTION.
    METHODS:
      compute.
ENDCLASS.

CLASS lcl_main IMPLEMENTATION.

  METHOD compute.
    DATA(lo_server) = NEW lcl_server( )->get_server( ).
    IF lo_server IS NOT BOUND.
      RETURN.
    ENDIF.
    DATA(lo_client) = lo_server->get_client( ).
    IF lo_client IS NOT BOUND.
      RETURN.
    ENDIF.
    DATA(lo_current_request) = lo_client->get_request( ).
    IF lo_current_request IS NOT BOUND.
      RETURN.
    ENDIF.
    lo_current_request->process( ).
  ENDMETHOD.

ENDCLASS.
