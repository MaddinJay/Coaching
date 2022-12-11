*&---------------------------------------------------------------------*
*& Report ymj_error_handling
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_error_handling.

CLASS lx_storage_exception DEFINITION INHERITING FROM cx_no_check FINAL.

  PUBLIC SECTION.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS lx_storage_exception IMPLEMENTATION.

ENDCLASS.

CLASS lcl_fileinputstream DEFINITION FINAL.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_section_name TYPE string,
      close.
  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_fileinputstream IMPLEMENTATION.

  METHOD constructor.
    IF iv_section_name = 'Invalid_File_Name'.
      RAISE EXCEPTION TYPE lx_storage_exception.
    ENDIF.
  ENDMETHOD.

  METHOD close.

  ENDMETHOD.

ENDCLASS.



CLASS lcl_array_list DEFINITION FINAL.

  PUBLIC SECTION.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_array_list IMPLEMENTATION.

ENDCLASS.

 CLASS lcl_section_store DEFINITION FINAL.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_section_name TYPE string,
      retrieve_section
        IMPORTING
                  iv_section_name      TYPE string
        RETURNING VALUE(ro_array_list) TYPE REF TO lcl_array_list.
  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_section_store IMPLEMENTATION.

  METHOD constructor.
    " Do something
  ENDMETHOD.

  METHOD retrieve_section.
    TRY.
        DATA(lo_stream) = NEW lcl_fileinputstream( iv_section_name ).
        lo_stream->close( ).
      CATCH lx_storage_exception INTO DATA(lx_storage_exception).
        RAISE EXCEPTION TYPE lx_storage_exception
          EXPORTING
            previous = lx_storage_exception
            textid   = '01'.
    ENDTRY.
    ro_array_list = NEW lcl_array_list( ).
  ENDMETHOD.

ENDCLASS.

CLASS ltcl_storage_exception DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      catch_exception FOR TESTING.
ENDCLASS.

CLASS ltcl_storage_exception IMPLEMENTATION.

  METHOD catch_exception.
    TRY.
        DATA(lo_stream) = NEW lcl_section_store( 'THROW_EXCEPTION' ).
        lo_stream->retrieve_section( 'Invalid_File_Name' ).
      CATCH lx_storage_exception INTO DATA(lo_storage_exception).
    ENDTRY.
    cl_abap_unit_assert=>assert_bound( lo_storage_exception ).
  ENDMETHOD.

ENDCLASS.
