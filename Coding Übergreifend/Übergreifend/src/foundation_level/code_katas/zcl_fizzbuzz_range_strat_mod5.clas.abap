class ZCL_FIZZBUZZ_RANGE_STRAT_MOD5 definition
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
  CONSTANTS: co_buzz type string value 'Buzz'.
ENDCLASS.



CLASS ZCL_FIZZBUZZ_RANGE_STRAT_MOD5 IMPLEMENTATION.


  METHOD CAN_EXECUTE.
    IF iv_number MOD 5 = 0.
      rv_result = abap_true.
    ELSE.
      rv_result = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD EXECUTE.
     rv_result = co_buzz.
  ENDMETHOD.
ENDCLASS.
