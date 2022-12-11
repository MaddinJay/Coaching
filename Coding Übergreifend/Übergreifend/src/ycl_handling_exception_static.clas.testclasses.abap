CLASS ltcl_ DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      m_cut TYPE REF TO zcl_handling_exception_static.
    METHODS:
      setup,
      raise_exception_with_class_txt FOR TESTING,
      raise_exception_with_directmsg FOR TESTING,
      raise_dyn_exp_with_class_txt FOR TESTING,
      " RAISE
      stat_exc_with_retry FOR TESTING,
      stat_exc_with_resume FOR TESTING.
ENDCLASS.


CLASS ltcl_ IMPLEMENTATION.
  METHOD setup.
    CREATE OBJECT m_cut.
  ENDMETHOD.

  METHOD raise_exception_with_class_txt.
    DATA:
      lo_static_check TYPE REF TO zcx_mj_static_check,
      lv_text         TYPE string.

    TRY.
        m_cut->raise_stat_exc_with_class_txt( ).
      CATCH zcx_mj_static_check INTO lo_static_check.
        lv_text = lo_static_check->get_text( ).
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
               EXPORTING
                 exp = 'Florin ist eine Nase.'
                 act = lv_text
             ).
  ENDMETHOD.


  METHOD raise_exception_with_directmsg.
    DATA:
      lo_static_check TYPE REF TO zcx_mj_static_check,
      lv_text         TYPE string.

    TRY.
        m_cut->raise_exception_with_directmsg( ).
      CATCH zcx_mj_static_check INTO lo_static_check.
        lv_text = lo_static_check->get_message( ).
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
               EXPORTING
                 exp = 'Florin ist eine Nase.'
                 act = lv_text
             ).
  ENDMETHOD.

  METHOD raise_dyn_exp_with_class_txt.
    DATA:
      lo_static_check TYPE REF TO zcx_mj_static_check,
      lv_text         TYPE string.

    TRY.
        m_cut->raise_stat_exc_with_class_txt( ).
      CATCH zcx_mj_static_check INTO lo_static_check.
        lv_text = lo_static_check->get_text( ).
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
               EXPORTING
                 exp = 'Florin ist eine Nase.'
                 act = lv_text ).
  ENDMETHOD.

  METHOD stat_exc_with_retry.
    DATA:
    lo_static_check TYPE REF TO zcx_mj_static_check,
    lv_text         TYPE string.

    TRY.
        m_cut->raise_stat_exc_with_retry( ).
      CATCH zcx_mj_static_check INTO lo_static_check.
        lv_text = lo_static_check->get_message( ).
        m_cut->mv_execute_raise = abap_false.
        RETRY.
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
               EXPORTING
                 exp = 'Raise wird ausgeführt.'
                 act = lv_text ).
  ENDMETHOD.

  METHOD stat_exc_with_resume.
    DATA:
    lo_static_check         TYPE REF TO zcx_mj_static_check,
    lv_text                 TYPE string,
    lv_message_from_method  TYPE string.

    TRY.
        lv_message_from_method = m_cut->raise_stat_resume_exc( ).
      CATCH BEFORE UNWIND zcx_mj_static_check INTO lo_static_check.
        lv_text = lo_static_check->get_message( ).
        RESUME.
    ENDTRY.


    cl_abap_unit_assert=>assert_equals(
               EXPORTING
                 exp = 'Raise wird ausgeführt.'
                 act = lv_text ).

    cl_abap_unit_assert=>assert_equals(
           EXPORTING
             exp = 'Hier wird weitergearbeitet.'
             act = lv_message_from_method ).

  ENDMETHOD.
ENDCLASS.
