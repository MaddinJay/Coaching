class YCL_HANDLING_EXCEPTION_STATIC definition
  public
  final
  create public .

public section.

  data MV_EXECUTE_RAISE type ABAP_BOOL value ABAP_TRUE. "#EC NOTEXT .

  methods CATCH_EXCEPTION .
  methods RAISE_STAT_EXC_WITH_CLASS_TXT
    raising
      ZCX_MJ_STATIC_CHECK .
  methods RAISE_EXCEPTION_WITH_DIRECTMSG
    raising
      ZCX_MJ_STATIC_CHECK .
  methods RAISE_DYN_EXC_WITH_CLASS_TXT .
  methods RAISE_STAT_EXC_WITH_RETRY
    raising
      ZCX_MJ_STATIC_CHECK .
  methods RAISE_STAT_RESUME_EXC
    returning
      value(RV_MESSAGE) type STRING
    raising
      resumable(ZCX_MJ_STATIC_CHECK) .
  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.



CLASS YCL_HANDLING_EXCEPTION_STATIC IMPLEMENTATION.


  METHOD CATCH_EXCEPTION.

  ENDMETHOD.


  METHOD RAISE_DYN_EXC_WITH_CLASS_TXT.
    RAISE EXCEPTION TYPE zcx_mj_dynamic_check
      EXPORTING
        textid = zcx_mj_static_check=>florin_ist_der_beste
        msgv1  = 'eine Nase'.
  ENDMETHOD.


  METHOD RAISE_EXCEPTION_WITH_DIRECTMSG.
    ##todo " T100-Message nicht sinnvoll, zu aufwendig und Verwendungsnachweis nicht direkt möglich
    DATA:
      lv_msg TYPE string.

    " Florin ist &1.
    MESSAGE i003(z_coaching_mj) INTO lv_msg WITH 'eine Nase'.
    RAISE EXCEPTION TYPE zcx_mj_static_check
      EXPORTING
        iv_message = lv_msg.

  ENDMETHOD.


  METHOD RAISE_STAT_EXC_WITH_CLASS_TXT.

    RAISE EXCEPTION TYPE zcx_mj_static_check
      EXPORTING
        textid = zcx_mj_static_check=>florin_ist_der_beste
        msgv1  = 'eine Nase'.

  ENDMETHOD.


  METHOD RAISE_STAT_EXC_WITH_RETRY.
    DATA:
      lv_msg TYPE string.

    IF mv_execute_raise = abap_true.
      " Raise wird ausgeführt.
      MESSAGE i005(z_coaching_mj) INTO lv_msg.
      RAISE EXCEPTION TYPE zcx_mj_static_check
        EXPORTING
          iv_message = lv_msg.
    ENDIF.

  ENDMETHOD.


  METHOD RAISE_STAT_RESUME_EXC.
    DATA:
      lv_msg TYPE string.
    ##todo "Template für RAISE EXCEPTION anlegen
    " Raise wird ausgeführt.
    MESSAGE i005(z_coaching_mj) INTO lv_msg.
    RAISE RESUMABLE EXCEPTION TYPE zcx_mj_static_check
      EXPORTING
        iv_message = lv_msg.

    rv_message = 'Hier wird weitergearbeitet.'.
  ENDMETHOD.
ENDCLASS.
