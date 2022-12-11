*&---------------------------------------------------------------------*
*& Report yy_pao_gilded_rose
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT yy_pao_gilded_rose.


*& Production Code - Class Library
CLASS lcl_item DEFINITION DEFERRED.

CLASS lcl_gilded_rose DEFINITION FINAL.
  PUBLIC SECTION.
    TYPES:
      tt_items TYPE STANDARD TABLE OF REF TO lcl_item WITH EMPTY KEY.
    METHODS:
      constructor
        IMPORTING it_items TYPE tt_items,
      update_quality.

  PRIVATE SECTION.
    DATA:
      mt_items TYPE tt_items.
    METHODS is_aged_brie
      IMPORTING
        io_item                TYPE REF TO lcl_item
      RETURNING
        VALUE(rv_is_aged_brie) TYPE abap_bool.
    METHODS is_backstage_pass
      IMPORTING
        io_item                     TYPE REF TO lcl_item
      RETURNING
        VALUE(rv_is_backstage_pass) TYPE abap_bool.
    METHODS is_sulfarus
      IMPORTING
        io_item               TYPE REF TO lcl_item
      RETURNING
        VALUE(rv_is_sulfarus) TYPE abap_bool.
    METHODS is_quality_positiv
      IMPORTING
        io_item              TYPE REF TO lcl_item
      RETURNING
        VALUE(rv_is_positiv) TYPE abap_bool.
    METHODS subtract_one_quality
      IMPORTING
        io_item TYPE REF TO lcl_item.
    METHODS check_name
      IMPORTING
        io_item           TYPE REF TO lcl_item
        iv_name           TYPE string
      RETURNING
        VALUE(rv_is_name) TYPE abap_bool.
ENDCLASS.

CLASS lcl_item DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_name    TYPE string
                  iv_sell_in TYPE i
                  iv_quality TYPE i,
      description
        RETURNING VALUE(rv_string) TYPE string,
      check_name
        IMPORTING iv_name          TYPE string
        RETURNING VALUE(rv_result) TYPE abap_bool,
      minimize_quality.

    DATA:
      mv_name    TYPE string,
      mv_sell_in TYPE i,
      mv_quality TYPE i.
  PRIVATE SECTION.
    METHODS is_condition4minimize_okay
      RETURNING VALUE(rv_result) TYPE abap_bool.


ENDCLASS.

CLASS lcl_gilded_rose IMPLEMENTATION.

  METHOD constructor.
    mt_items = it_items.
  ENDMETHOD.

  METHOD update_quality.

    LOOP AT mt_items INTO DATA(lo_item).  " Reverse Conditional Statements

      lo_item->minimize_quality(  ).

      "Kapselung
      "Law of Demeter : holen Zustand vom Objet, um Entscheidung ausserhabl zu treffen.
      " diese Logik der Prüfung Richtung Objekt

      " Interface Methoden um auf Membervariable zuzugreifen getter.

      "Interface Stratefy Design Pattern.

      "lo_object.equals( lo_object2 )
      "( lo_item ) = asdkfj


      IF is_aged_brie( lo_item ).
        IF lo_item->mv_quality < 50.
          lo_item->mv_quality = lo_item->mv_quality + 1.
        ENDIF.
      ENDIF.

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

      IF lo_item->mv_name <> |Sulfuras, Hand of Ragnaros|.
        lo_item->mv_sell_in = lo_item->mv_sell_in - 1.
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

CLASS lcl_item IMPLEMENTATION.

  METHOD constructor.
    mv_name    = iv_name.
    mv_sell_in = iv_sell_in.
    mv_quality = iv_quality.
  ENDMETHOD.

  METHOD description.
    rv_string = |{ mv_name }, { mv_sell_in }, { mv_quality }|.
  ENDMETHOD.

  METHOD check_name.
    rv_result = xsdbool( mv_name = iv_name ).
  ENDMETHOD.

  METHOD minimize_quality.
    IF is_condition4minimize_okay(  ).
      mv_quality = mv_quality - 1.
    ENDIF.
  ENDMETHOD.

  METHOD is_condition4minimize_okay.
    CHECK mv_quality > 0.
    CHECK check_name( |Aged Brie| ) = abap_false.
    CHECK check_name( |Backstage passes to a TAFKAL80ETC concert| ) = abap_false.
    CHECK check_name( |Sulfuras, Hand of Ragnaros| )                = abap_false.
    rv_result = abap_true.
  ENDMETHOD.

ENDCLASS.

*& Test Code - Executable Text Test Fixture
CLASS lth_texttest_fixture DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS lth_texttest_fixture IMPLEMENTATION.
  METHOD main.
    DATA(lo_out) = cl_demo_output=>new( )->write_text( |OMGHAI!| ).

    DATA(lt_items) = VALUE lcl_gilded_rose=>tt_items(
                        ( NEW #( iv_name    = |+5 Dexterity Vest|
                                 iv_sell_in = 10
                                 iv_quality = 20 ) )
                        ( NEW #( iv_name    = |Aged Brie|
                                 iv_sell_in = 2
                                 iv_quality = 0 ) )
                        ( NEW #( iv_name    = |Elixir of the Mongoose|
                                 iv_sell_in = 5
                                 iv_quality = 7 ) )
                        ( NEW #( iv_name    = |Sulfuras, Hand of Ragnaros|
                                 iv_sell_in = 0
                                 iv_quality = 80 ) )
                        ( NEW #( iv_name    = |Backstage passes to a TAFKAL80ETC concert|
                                 iv_sell_in = 15
                                 iv_quality = 20 ) )
                        ( NEW #( iv_name    = |Backstage passes to a TAFKAL80ETC concert|
                                 iv_sell_in = 10
                                 iv_quality = 49 ) )
                        ( NEW #( iv_name    = |Backstage passes to a TAFKAL80ETC concert|
                                 iv_sell_in = 5
                                 iv_quality = 49 ) )
                        "This conjured item does not work properly yet
                        ( NEW #( iv_name    = |Conjured Mana Cake|
                                 iv_sell_in = 3
                                 iv_quality = 6 ) ) ).

    DATA(lo_app) = NEW lcl_gilded_rose( it_items = lt_items ).

    DATA(lv_days) = 2.
    cl_demo_input=>request( EXPORTING text = |Number of Days?|
                            CHANGING field = lv_days ).

    DO lv_days TIMES.
      lo_out->next_section( |-------- day { sy-index } --------| ).
      lo_out->write_text( |Name, Sell_In, Quality| ).
      LOOP AT lt_items INTO DATA(lo_item).
        lo_out->write_text( lo_item->description( ) ).
      ENDLOOP.
      lo_app->update_quality( ).
    ENDDO.

    lo_out->display( ).
  ENDMETHOD.
ENDCLASS.


*& Test Code - Currently Broken
CLASS ltc_gilded_rose DEFINITION FINAL FOR TESTING RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    METHODS:
      foo FOR TESTING,
      foo_quality_zero FOR TESTING.
ENDCLASS.

CLASS ltc_gilded_rose IMPLEMENTATION.

  METHOD foo.
    DATA(lt_items) = VALUE lcl_gilded_rose=>tt_items( ( NEW #( iv_name    = |foo|
                                                               iv_sell_in = 10
                                                               iv_quality = 10 ) ) ).

    DATA(lo_app) = NEW lcl_gilded_rose( it_items = lt_items ).
    lo_app->update_quality( ).

    cl_abap_unit_assert=>assert_equals(
                   act = CAST lcl_item( lt_items[ 1 ] )->mv_name
                   exp = |foo| ).

    cl_abap_unit_assert=>assert_equals( exp = 9
                                        act = CAST lcl_item( lt_items[ 1 ] )->mv_quality ).
  ENDMETHOD.

  METHOD foo_quality_zero.
    DATA(lt_items) = VALUE lcl_gilded_rose=>tt_items( ( NEW #( iv_name    = |foo|
                                                             iv_sell_in = 10
                                                             iv_quality = 0 ) ) ).

    DATA(lo_app) = NEW lcl_gilded_rose( it_items = lt_items ).
    lo_app->update_quality( ).

    cl_abap_unit_assert=>assert_equals(
                   act = CAST lcl_item( lt_items[ 1 ] )->mv_name
                   exp = |foo| ).

    cl_abap_unit_assert=>assert_equals( exp = 0
                                        act = CAST lcl_item( lt_items[ 1 ] )->mv_quality ).
  ENDMETHOD.

ENDCLASS.
