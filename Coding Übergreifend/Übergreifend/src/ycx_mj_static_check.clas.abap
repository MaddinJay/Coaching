CLASS ycx_mj_static_check DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message .
    INTERFACES if_spi_message .
    INTERFACES yif_message_mj.

    ALIASES msgid
      FOR if_spi_message~msgid .
    ALIASES msgno
      FOR if_spi_message~msgno .
    ALIASES msgv1
      FOR if_spi_message~msgv1 .
    ALIASES msgv2
      FOR if_spi_message~msgv2 .
    ALIASES msgv3
      FOR if_spi_message~msgv3 .
    ALIASES msgv4
      FOR if_spi_message~msgv4 .
    ALIASES mv_message
      FOR yif_message_mj~mv_message.
    ALIASES get_message
      FOR yif_message_mj~get_message.

    CONSTANTS:
      BEGIN OF florin_ist_der_beste,
        msgid TYPE symsgid VALUE 'Z_COACHING_MJ',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'MSGV1',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF florin_ist_der_beste .

    METHODS constructor
      IMPORTING
        !textid     LIKE if_t100_message=>t100key OPTIONAL
        !previous   LIKE previous OPTIONAL
        !msgid      TYPE symsgid OPTIONAL
        !msgno      TYPE symsgno OPTIONAL
        !msgv1      TYPE symsgv OPTIONAL
        !msgv2      TYPE symsgv OPTIONAL
        !msgv3      TYPE symsgv OPTIONAL
        !msgv4      TYPE symsgv OPTIONAL
        !iv_message TYPE string OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycx_mj_static_check IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    me->msgid = msgid .
    me->msgno = msgno .
    me->msgv1 = msgv1 .
    me->msgv2 = msgv2 .
    me->msgv3 = msgv3 .
    me->msgv4 = msgv4 .
    me->mv_message = iv_message.

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.


  METHOD get_message.
    rv_message = me->mv_message.
  ENDMETHOD.
ENDCLASS.
