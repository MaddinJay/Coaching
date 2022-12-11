*&---------------------------------------------------------------------*
*& Report ycl_active_object
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ycl_active_object.

INTERFACE yif_command.
  METHODS:
    execute.
ENDINTERFACE.

CLASS ycl_command DEFINITION FINAL.

  PUBLIC SECTION.
    INTERFACES yif_command.

ENDCLASS.

CLASS ycl_command IMPLEMENTATION.

  METHOD yif_command~execute.

  ENDMETHOD.

ENDCLASS.

CLASS ycl_linked_list DEFINITION.

  PUBLIC SECTION.
    METHODS:
      get_first
        RETURNING
          VALUE(ro_linked_object) TYPE REF TO ycl_command,
      delete_first,
      add
        IMPORTING
          io_command TYPE REF TO yif_command,
      is_not_empty
        RETURNING
          VALUE(rv_is_not_empty) TYPE abap_bool.

  PRIVATE SECTION.
    DATA:
            lt_linked_list TYPE TABLE OF REF TO ycl_command.
ENDCLASS.

CLASS ycl_linked_list IMPLEMENTATION.

  METHOD get_first.

  ENDMETHOD.

  METHOD delete_first.

  ENDMETHOD.


  METHOD add.

  ENDMETHOD.


  METHOD is_not_empty.
    rv_is_not_empty = xsdbool( lines( lt_linked_list ) <> 0 ).
  ENDMETHOD.

ENDCLASS.

CLASS ycl_active_object_engine DEFINITION.

  PUBLIC SECTION.
    METHODS:
      run,
      add_command
        IMPORTING
          io_command TYPE REF TO yif_command.

  PRIVATE SECTION.
    DATA:
      mo_its_commands TYPE REF TO ycl_linked_list.
ENDCLASS.

CLASS ycl_active_object_engine IMPLEMENTATION.

  METHOD add_command.
    mo_its_commands->add( io_command ).
  ENDMETHOD.

  METHOD run.
    WHILE mo_its_commands->is_not_empty( ).
      DATA(lo_command) = mo_its_commands->get_first( ).
      mo_its_commands->delete_first( ).
      lo_command->yif_command~execute( ).
    ENDWHILE.
  ENDMETHOD.

ENDCLASS.

CLASS ycl_sleep_command DEFINITION.
  PUBLIC SECTION.
    INTERFACES yif_command.
ENDCLASS.

CLASS ycl_sleep_command IMPLEMENTATION.

  METHOD yif_command~execute.
    " Wait up to 1000 msec: Hänge sich selbst immer wieder an die Queue
    " Dann hänge Wakeup-Command an Queue -> WakeUp wird ausgeführt und ab gehts
  ENDMETHOD.

ENDCLASS.

CLASS ytcl_test_sleep_command DEFINITION.
  PUBLIC SECTION.
    METHODS:
      main.
ENDCLASS.

CLASS ytcl_test_sleep_command IMPLEMENTATION.

  METHOD main.
    DATA(lo_active_object_engine) = NEW ycl_active_object_engine( ).
    DATA(lo_sleep_command) = NEW ycl_sleep_command( ).
    lo_active_object_engine->add_command( lo_sleep_command ).
    lo_active_object_engine->run( ).
  ENDMETHOD.

ENDCLASS.
