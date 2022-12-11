REPORT ymj_dao_pattern_example.

CLASS lcl_demo_airport DEFINITION
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        is_airport TYPE sairport
      RAISING
        cx_demo_exception.

    METHODS get_id
      RETURNING value(rv_airport_code) TYPE s_airport.

    METHODS get_name
      RETURNING value(rv_airport_name) TYPE s_airpname.


    METHODS set_name
      IMPORTING iv_airport_name TYPE s_airpname.

    METHODS get_time_zone
      RETURNING value(rv_time_zone) TYPE s_tzone.

    METHODS set_time_zone
      IMPORTING iv_time_zone TYPE s_tzone.

  PROTECTED SECTION.
    DATA:
      ms_airport TYPE sairport.

ENDCLASS.

CLASS lcl_demo_airport IMPLEMENTATION.

  METHOD constructor.
    IF is_airport IS NOT INITIAL.
      ms_airport = is_airport.
    ELSE.
      RAISE EXCEPTION TYPE cx_demo_exception.
    ENDIF.

  ENDMETHOD.

  METHOD get_id.
    rv_airport_code = ms_airport-id.
  ENDMETHOD.

  METHOD get_name.
    rv_airport_name = ms_airport-name.
  ENDMETHOD.

  METHOD get_time_zone.
    rv_time_zone = ms_airport-time_zone.
  ENDMETHOD.

  METHOD set_name.
    ms_airport-name = iv_airport_name.
  ENDMETHOD.

  METHOD set_time_zone.
    ms_airport-time_zone = iv_time_zone.
  ENDMETHOD.


ENDCLASS.

INTERFACE lif_demo_airport_dao.
  METHODS create_new_airport
    IMPORTING
      io_airport TYPE REF TO lcl_demo_airport
    RAISING
      cx_demo_exception.
  METHODS read_airport_data_by_iata
    IMPORTING
      iv_airport_code TYPE s_airport
    RETURNING
      value(r_result)  TYPE REF TO lcl_demo_airport
    RAISING
      cx_demo_exception.
  METHODS delete_airport_by_iata
    IMPORTING
      iv_airport_code TYPE s_airport
    RETURNING
      value(r_result)  TYPE REF TO lcl_demo_airport
    RAISING
      cx_demo_exception.
ENDINTERFACE.

CLASS lcl_demo_airport_dao DEFINITION
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES lif_demo_airport_dao.

    ALIASES:
     create_new_airport        FOR lif_demo_airport_dao~create_new_airport,
     read_airport_data_by_iata FOR lif_demo_airport_dao~read_airport_data_by_iata,
     delete_airport_by_iata    FOR lif_demo_airport_dao~delete_airport_by_iata.

  PROTECTED SECTION.
    DATA:
      mo_airport TYPE REF TO lcl_demo_airport.

ENDCLASS.

CLASS lcl_demo_airport_dao IMPLEMENTATION.

  METHOD lif_demo_airport_dao~create_new_airport.
    DATA:
      ls_airport TYPE sairport,
      lx_root    TYPE REF TO cx_root.

    ls_airport-id        = io_airport->get_id( ).
    ls_airport-name      = io_airport->get_name( ).
    ls_airport-time_zone = io_airport->get_time_zone( ).

    TRY.
        INSERT INTO sairport VALUES ls_airport.

        IF sy-subrc <> 0.
          "Was gibt es für möglichkeiten SY-SUBRC in Klassen-Exception zu integrieren?
          RAISE EXCEPTION TYPE cx_demo_exception
            EXPORTING
              exception_text = 'Fehler bei der Anlage des Airports'.
        ENDIF.

      CATCH cx_root INTO lx_root.

        ROLLBACK WORK.

        RAISE EXCEPTION TYPE cx_demo_exception
          EXPORTING
            previous = lx_root->previous.
    ENDTRY.

    COMMIT WORK.
  ENDMETHOD.

  METHOD lif_demo_airport_dao~read_airport_data_by_iata.
    DATA:
      ls_airport TYPE sairport,
      lx_root    TYPE REF TO cx_root.
    TRY.
        SELECT SINGLE *
          INTO ls_airport
          FROM sairport
          WHERE
            id = iv_airport_code.

        IF sy-subrc <> 0.
          RAISE EXCEPTION TYPE cx_demo_exception
            EXPORTING
              exception_text = 'Airport existiert nicht'.
        ENDIF.

      CATCH cx_root INTO lx_root.
        RAISE EXCEPTION TYPE cx_demo_exception
          EXPORTING
            previous = lx_root->previous.
    ENDTRY.
    CREATE OBJECT mo_airport
      EXPORTING
        is_airport = ls_airport.

    r_result = mo_airport.
  ENDMETHOD.

  METHOD lif_demo_airport_dao~delete_airport_by_iata.
    DATA:
      ls_airport TYPE sairport,
      lx_root    TYPE REF TO cx_root.
    TRY.
        DELETE FROM sairport
          WHERE
            id = iv_airport_code.

        IF sy-subrc <> 0.
          RAISE EXCEPTION TYPE cx_demo_exception
            EXPORTING
              exception_text = 'Airport existiert nicht'.
        ENDIF.

      CATCH cx_root INTO lx_root.
        RAISE EXCEPTION TYPE cx_demo_exception
          EXPORTING
            previous = lx_root->previous.
    ENDTRY.

    COMMIT WORK.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_demo_airport_facade DEFINITION
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA:
      mo_airport_dao TYPE REF TO lif_demo_airport_dao.

    METHODS set_database_access
      IMPORTING
        io_airport_dao TYPE REF TO lif_demo_airport_dao
      RAISING
        cx_demo_exception.

  PROTECTED SECTION.

ENDCLASS.

CLASS lcl_demo_airport_facade IMPLEMENTATION.

  METHOD set_database_access.

    IF io_airport_dao IS BOUND.
      mo_airport_dao = io_airport_dao.
    ELSE.
      RAISE EXCEPTION TYPE cx_demo_exception.
    ENDIF.

  ENDMETHOD.

ENDCLASS.







" Testklasse zu DEMA_AIRPORT_
CLASS lcl_demo_airport_stub DEFINITION
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES lif_demo_airport_dao.

    ALIASES:
     create_new_airport        FOR lif_demo_airport_dao~create_new_airport,
     read_airport_data_by_iata FOR lif_demo_airport_dao~read_airport_data_by_iata,
     delete_airport_by_iata    FOR lif_demo_airport_dao~delete_airport_by_iata.

  PROTECTED SECTION.

ENDCLASS.

CLASS lcl_demo_airport_stub IMPLEMENTATION.

  METHOD lif_demo_airport_dao~create_new_airport.

  ENDMETHOD.

  METHOD lif_demo_airport_dao~read_airport_data_by_iata.

  ENDMETHOD.

  METHOD lif_demo_airport_dao~delete_airport_by_iata.

  ENDMETHOD.

ENDCLASS.

CLASS ltc_demo_airport_facade DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PUBLIC SECTION.
  PRIVATE SECTION.
    DATA:
      mo_demo_airport_facade TYPE REF TO lcl_demo_airport_facade,
      mo_demo_airport        TYPE REF TO lif_demo_airport_dao.

    METHODS setup.

    METHODS:
      " Check...
      create_airport FOR TESTING.
ENDCLASS.

CLASS ltc_demo_airport_facade IMPLEMENTATION.

  METHOD create_airport.
    DATA:
      ls_airport TYPE sairport,
      lo_airport TYPE REF TO lcl_demo_airport.

    ls_airport-id        = 'ZHR'.
    ls_airport-name      = 'Airport Zürich'.
    ls_airport-time_zone = 'CMT'.
    CREATE OBJECT lo_airport
      EXPORTING
        is_airport = ls_airport.

    mo_demo_airport->create_new_airport( lo_airport ).

  ENDMETHOD.

  METHOD setup.
    CREATE OBJECT mo_demo_airport_facade.
    CREATE OBJECT mo_demo_airport TYPE lcl_demo_airport_dao.
  ENDMETHOD.
ENDCLASS.
