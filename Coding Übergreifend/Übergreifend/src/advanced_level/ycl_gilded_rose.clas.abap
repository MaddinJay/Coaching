CLASS ycl_gilded_rose DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
      tt_items TYPE STANDARD TABLE OF REF TO ycl_item WITH EMPTY KEY.
    METHODS:
      constructor
        IMPORTING it_items TYPE tt_items,
      update_quality.

  PRIVATE SECTION.
    DATA:
      mt_items TYPE tt_items.
    METHODS is_aged_brie
      IMPORTING
        io_item                TYPE REF TO ycl_item
      RETURNING
        VALUE(rv_is_aged_brie) TYPE abap_bool.
    METHODS is_backstage_pass
      IMPORTING
        io_item                     TYPE REF TO ycl_item
      RETURNING
        VALUE(rv_is_backstage_pass) TYPE abap_bool.
    METHODS is_sulfarus
      IMPORTING
        io_item               TYPE REF TO ycl_item
      RETURNING
        VALUE(rv_is_sulfarus) TYPE abap_bool.
    METHODS is_quality_positiv
      IMPORTING
        io_item              TYPE REF TO ycl_item
      RETURNING
        VALUE(rv_is_positiv) TYPE abap_bool.
    METHODS subtract_one_quality
      IMPORTING
        io_item TYPE REF TO ycl_item.
    METHODS check_name
      IMPORTING
        io_item           TYPE REF TO ycl_item
        iv_name           TYPE string
      RETURNING
        VALUE(rv_is_name) TYPE abap_bool.
ENDCLASS.



CLASS ycl_gilded_rose IMPLEMENTATION.
  METHOD constructor.
    mt_items = it_items.
  ENDMETHOD.

  METHOD update_quality.

    LOOP AT mt_items INTO DATA(lo_item).  " Reverse Conditional Statements

      lo_item->minimize_quality(  ).

      "minimize_sell_in( )
      IF lo_item->mv_name <> |Sulfuras, Hand of Ragnaros|.
        lo_item->mv_sell_in = lo_item->mv_sell_in - 1.
      ENDIF.

      "Kapselung
      "Law of Demeter : holen Zustand vom Objet, um Entscheidung ausserhabl zu treffen.
      " diese Logik der Prüfung Richtung Objekt

      " Interface Methoden um auf Membervariable zuzugreifen getter.

      "Interface Stratefy Design Pattern.

      "lo_object.equals( lo_object2 )
      "( lo_item ) = asdkfj

      "handle_aged_brie( ).
      IF is_aged_brie( lo_item ).
        IF lo_item->mv_quality < 50.
          lo_item->mv_quality = lo_item->mv_quality + 1.
        ENDIF.
      ENDIF.

      "handle_backstage_pass( )
      IF is_backstage_pass( lo_item ).
        lo_item->mv_quality = lo_item->mv_quality + 1.
        IF lo_item->mv_sell_in < 11.
          IF lo_item->mv_quality < 50.
            lo_item->mv_quality = lo_item->mv_quality + 1.
          ENDIF.
        ENDIF.

        IF lo_item->mv_sell_in < 6.
          IF lo_item->mv_quality < 50.
            lo_item->mv_quality = lo_item->mv_quality + 1.
          ENDIF.
        ENDIF.
      ENDIF.


      IF lo_item->mv_sell_in < 0.
        IF lo_item->mv_name <> |Aged Brie|.
          IF lo_item->mv_name <> |Backstage passes to a TAFKAL80ETC concert|.
            IF lo_item->mv_quality > 0.
              IF lo_item->mv_name <> |Sulfuras, Hand of Ragnaros|.
                lo_item->mv_quality = lo_item->mv_quality - 1.
              ENDIF.
            ENDIF.
          ELSE.
            lo_item->mv_quality = lo_item->mv_quality - lo_item->mv_quality.
          ENDIF.
        ELSE.
          IF lo_item->mv_quality < 50.
            lo_item->mv_quality = lo_item->mv_quality + 1.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD subtract_one_quality.
    io_item->mv_quality = io_item->mv_quality - 1.
  ENDMETHOD.

  METHOD is_aged_brie.
    rv_is_aged_brie = xsdbool( io_item->mv_name = |Aged Brie| ).
  ENDMETHOD.

  METHOD is_backstage_pass.
    rv_is_backstage_pass = xsdbool( io_item->mv_name = |Backstage passes to a TAFKAL80ETC concert| ).
  ENDMETHOD.


  METHOD is_sulfarus.
    rv_is_sulfarus = xsdbool( io_item->mv_name = |Sulfuras, Hand of Ragnaros| ).
  ENDMETHOD.

  METHOD is_quality_positiv.
    rv_is_positiv = xsdbool( io_item->mv_quality > 0 ).
  ENDMETHOD.

  METHOD check_name.
    rv_is_name = xsdbool( io_item->mv_name = iv_name ).
  ENDMETHOD.
ENDCLASS.
