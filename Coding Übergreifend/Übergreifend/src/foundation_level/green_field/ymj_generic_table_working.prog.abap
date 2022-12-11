*&---------------------------------------------------------------------*
*& Report ymj_generic_table_working
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_generic_table_working.

CLASS lcl_descriptor DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          ir_working_table TYPE REF TO data,
      set_contract_type_name
        IMPORTING
          iv_contract_type_name TYPE string,
      get_contract_value
        RETURNING VALUE(rv_value) TYPE vtref_kk.

  PRIVATE SECTION.
    DATA:
      mt_contract_type_name  TYPE RANGE OF string,
      mv_contract_field_name TYPE abap_componentdescr-name,
      mr_working_table       TYPE REF TO data.


ENDCLASS.

CLASS lcl_descriptor IMPLEMENTATION.

  METHOD set_contract_type_name.
    DATA: lo_table_descriptor TYPE REF TO cl_abap_tabledescr.

    mt_contract_type_name = VALUE #(
                                ( sign = 'I' option = 'EQ' low = iv_contract_type_name ) ).

    lo_table_descriptor = CAST cl_abap_tabledescr( cl_abap_typedescr=>describe_by_data_ref( mr_working_table ) ).
    DATA(lv_table_type) = lo_table_descriptor->absolute_name.
    DATA(lv_line_type)  = lo_table_descriptor->get_table_line_type( )->absolute_name.


    DATA(lo_line_descriptor)      = CAST cl_abap_structdescr( cl_abap_structdescr=>describe_by_name( lv_line_type ) ).
    DATA(lt_structure_components) = lo_line_descriptor->get_components( ).

    LOOP AT lt_structure_components ASSIGNING FIELD-SYMBOL(<component>).
      IF <component>-type->get_relative_name( ) IN mt_contract_type_name.
        mv_contract_field_name = <component>-name.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_contract_value.
    FIELD-SYMBOLS: <table> TYPE STANDARD TABLE,
                   <value> TYPE any.

    ASSIGN mr_working_table->* TO <table>.

    READ TABLE <table> ASSIGNING FIELD-SYMBOL(<entry>) INDEX 1.

    ASSIGN COMPONENT mv_contract_field_name OF STRUCTURE <entry> TO <value>.
    rv_value = <value>.
  ENDMETHOD.

  METHOD constructor.
    mr_working_table = ir_working_table.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_working DEFINITION.

  PUBLIC SECTION.
    METHODS:
      main.

ENDCLASS.

CLASS lcl_working IMPLEMENTATION.

  METHOD main.
    DATA: lt_documents  TYPE dfkkop_t,
          lo_descriptor TYPE REF TO lcl_descriptor.

    lt_documents = VALUE #( ( vtref = '12345678-PR-KVW-A' ) ).
    lo_descriptor = NEW lcl_descriptor( REF #( lt_documents ) ).
    lo_descriptor->set_contract_type_name( 'VTREF_KK' ).
    WRITE: lo_descriptor->get_contract_value( ).

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  NEW lcl_working( )->main( ).
