CLASS ltcl_bounded_queue DEFINITION DEFERRED.
CLASS ycl_bounded_queue DEFINITION LOCAL FRIENDS ltcl_bounded_queue.

CLASS ltcl_bounded_queue DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    TYPES: tt_int TYPE STANDARD TABLE OF int1 WITH DEFAULT KEY.

    DATA:
      mo_cut TYPE REF TO ycl_bounded_queue.

    METHODS:
      setup,
      enqueue_max_integer FOR TESTING,
      enqueue_min_integer FOR TESTING,
      enqueue_three_times FOR TESTING,
      " GIVEN: Full List of Enqueue-Entries and on Hold-Enqueue-Entry WHEN: Execute DEQUEUE
      enqueue_after_dequeue FOR TESTING,
      dequeue_success     FOR TESTING,
      dequeue_error       FOR TESTING.
ENDCLASS.


CLASS ltcl_bounded_queue IMPLEMENTATION.

  METHOD enqueue_max_integer.
    " Zahlen grösser als 255 werden durch Standard als Input verhindert
    TRY.
        mo_cut->enqueue( REF #( 255 ) ). " Test auf Input
      CATCH cx_root.
        cl_abap_unit_assert=>fail( ).
    ENDTRY.
  ENDMETHOD.

  METHOD setup.
    mo_cut = NEW ycl_bounded_queue( ).
  ENDMETHOD.

  METHOD enqueue_min_integer.
    " Zahlen kleiner als 0 werden durch Standard als Input verhindert -> Es dumpt hart
    " Fehlerhandling nicht möglich, Aufrufer muss das handeln (Shit in Shit out =) )
    TRY.
*        mo_cut->enqueue( REF #( -1 ) ).
      CATCH cx_root INTO DATA(lo_root).
        cl_abap_unit_assert=>fail( ).
    ENDTRY.
  ENDMETHOD.

  METHOD dequeue_error.
    " Fehler werfen, falls keine Elemente mehr in der Liste sind
    TRY.
        mo_cut->dequeue( ).
      CATCH ycx_mj_static_check INTO DATA(lx_error).
        cl_abap_unit_assert=>assert_equals( exp = 'Queue is empty. Nothing to dequeue.'
                                            act = lx_error->get_text( ) ).
    ENDTRY.
  ENDMETHOD.

  METHOD dequeue_success.
    FIELD-SYMBOLS: <exp_result> TYPE any.
    DATA: lv_result TYPE REF TO data.

*    " Erfolgreich entsperren, Output 2 (First In / First Out)
    TRY.
        mo_cut->enqueue( REF #( 2 ) ).
        mo_cut->enqueue( REF #( 3 ) ).
        lv_result = mo_cut->dequeue( ).
        ASSIGN lv_result->* TO <exp_result>.
        cl_abap_unit_assert=>assert_equals( exp = 2
                                            act = <exp_result>  ).
      CATCH ycx_mj_static_check.
        cl_abap_unit_assert=>fail( ).
    ENDTRY.
  ENDMETHOD.

  METHOD enqueue_three_times.
    FIELD-SYMBOLS: <queue_table> TYPE STANDARD TABLE.
    FIELD-SYMBOLS: <queue> TYPE any.

    TRY.
        mo_cut->enqueue( REF #( 2 ) ).
        mo_cut->enqueue( REF #( 3 ) ).
        mo_cut->enqueue( REF #( 4 ) ).

        cl_abap_unit_assert=>assert_equals( exp = VALUE yif_bounded_queue=>tt_queue(
                                                           ( value = REF i( 2 ) is_dequeued = abap_false is_hold = abap_false )
                                                           ( value = REF i( 3 ) is_dequeued = abap_false is_hold = abap_false )
                                                           ( value = REF i( 4 ) is_dequeued = abap_false is_hold = abap_true ) )
                                            act = mo_cut->mt_queue ).
    ENDTRY.
  ENDMETHOD.

  METHOD enqueue_after_dequeue.
    FIELD-SYMBOLS: <queue_table> TYPE STANDARD TABLE.
    TRY.
        mo_cut->enqueue( REF #( 2 ) ).
        mo_cut->enqueue( REF #( 3 ) ).
        mo_cut->enqueue( REF #( 4 ) ).
        mo_cut->dequeue( ).

        cl_abap_unit_assert=>assert_equals( exp = VALUE yif_bounded_queue=>tt_queue(
                                                           ( value = REF i( 2 ) is_dequeued = abap_true  is_hold = abap_false )
                                                           ( value = REF i( 3 ) is_dequeued = abap_false is_hold = abap_false )
                                                           ( value = REF i( 4 ) is_dequeued = abap_false is_hold = abap_false ) )
                                            act = mo_cut->mt_queue ).

      CATCH ycx_mj_static_check.
        cl_abap_unit_assert=>fail( ).
    ENDTRY.
  ENDMETHOD.

ENDCLASS.
