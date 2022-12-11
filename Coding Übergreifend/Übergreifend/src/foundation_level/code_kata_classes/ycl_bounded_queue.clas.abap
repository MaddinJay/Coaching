CLASS ycl_bounded_queue DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      yif_bounded_queue.

    ALIASES enqueue FOR yif_bounded_queue~enqueue.
    ALIASES dequeue FOR yif_bounded_queue~dequeue.

  PRIVATE SECTION.
    CONSTANTS:
      mc_enqueue_limit TYPE i VALUE 2,
      mc_move_entry    TYPE i VALUE 1,
      BEGIN OF mc_messages,
        queue_is_empty TYPE int1 VALUE '009',
      END OF mc_messages.

    DATA:
      mt_queue      TYPE yif_bounded_queue=>tt_queue.

    METHODS:
      is_enqueue_limit_not_reached
        RETURNING
          VALUE(rv_limit_not_reached) TYPE abap_bool,
      append_enqueue_list
        IMPORTING
          iv_queue_value TYPE REF TO data,
      append_enqueue_hold_list
        IMPORTING
          iv_queue_value TYPE data,
      get_dequeue_entry_from_queue
        RETURNING
          VALUE(rv_queue_entry) TYPE REF TO data
        RAISING
          ycx_mj_static_check,
      notice_dequeued_entry_in_queue,
      count_queue_entries
        RETURNING
          VALUE(rv_count) TYPE int1,
      open_hold_entry_in_queue.
ENDCLASS.

CLASS ycl_bounded_queue IMPLEMENTATION.

  METHOD yif_bounded_queue~dequeue.
    rv_dequeued_element = get_dequeue_entry_from_queue( ).
    notice_dequeued_entry_in_queue( ).
    open_hold_entry_in_queue( ).
  ENDMETHOD.

  METHOD yif_bounded_queue~enqueue.
    ##TODO "Bei der jetzigen Logik ist Halte-Eintrag egal. Die Liste wird aufgebaut, der erste Eintrag wird immer genommen.
    IF is_enqueue_limit_not_reached( ).
      append_enqueue_list( iv_queue_value ).
    ELSE.
      append_enqueue_hold_list( iv_queue_value ).
    ENDIF.
  ENDMETHOD.

  METHOD is_enqueue_limit_not_reached.
    rv_limit_not_reached = xsdbool( count_queue_entries( ) < mc_enqueue_limit ).
  ENDMETHOD.

  METHOD append_enqueue_list.
    DATA: ls_queue TYPE yif_bounded_queue=>ts_queue.

    ls_queue-value = iv_queue_value.
    APPEND ls_queue TO mt_queue.
  ENDMETHOD.

  METHOD append_enqueue_hold_list.
    DATA: ls_queue TYPE yif_bounded_queue=>ts_queue.

    ls_queue-value = iv_queue_value.
    ls_queue-is_hold = abap_true.
    APPEND ls_queue TO mt_queue.
  ENDMETHOD.

  METHOD get_dequeue_entry_from_queue.
    TRY.
        rv_queue_entry = mt_queue[ mc_move_entry ]-value.
      CATCH cx_sy_itab_line_not_found.
        RAISE EXCEPTION TYPE ycx_mj_static_check
          MESSAGE ID 'YMJ_COACHING' NUMBER mc_messages-queue_is_empty.
    ENDTRY.
  ENDMETHOD.

  METHOD notice_dequeued_entry_in_queue.
    LOOP AT mt_queue ASSIGNING FIELD-SYMBOL(<line>) WHERE is_dequeued = abap_false.
      <line>-is_dequeued = abap_true.
      EXIT.
    ENDLOOP.
  ENDMETHOD.

  METHOD count_queue_entries.
    LOOP AT mt_queue INTO DATA(ls_queue).
      rv_count = rv_count + 1.
    ENDLOOP.
  ENDMETHOD.

  METHOD open_hold_entry_in_queue.
    LOOP AT mt_queue ASSIGNING FIELD-SYMBOL(<line>) WHERE is_hold = abap_true.
      <line>-is_hold = abap_false.
      EXIT.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
