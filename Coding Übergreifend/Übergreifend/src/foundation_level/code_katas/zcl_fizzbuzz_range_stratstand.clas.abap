class ZCL_FIZZBUZZ_RANGE_STRATSTAND definition
  public
  inheriting from zcl_fizzbuzz_range_strategy
  final
  create public .

public section.

  methods CAN_EXECUTE
    redefinition .
  methods EXECUTE
    redefinition .
  PROTECTED SECTION.
  PRIVATE SECTION.
 data mv_number type i.
ENDCLASS.



CLASS ZCL_FIZZBUZZ_RANGE_STRATSTAND IMPLEMENTATION.


  METHOD CAN_EXECUTE.
      rv_result = abap_true.
      mv_number = iv_number.
  ENDMETHOD.


  METHOD EXECUTE.
     rv_result = mv_number.
  ENDMETHOD.
ENDCLASS.
