CLASS ZCL_FIZZBUZZ_RANGE_STRAT_MOD3 DEFINITION
  PUBLIC
  INHERITING FROM zcl_fizzbuzz_range_strategy
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS: can_execute REDEFINITION,
             execute REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
  CONSTANTS: co_fizz type string value 'Fizz'.
ENDCLASS.



CLASS ZCL_FIZZBUZZ_RANGE_STRAT_MOD3 IMPLEMENTATION.


  METHOD can_execute.
    IF iv_number MOD 3 = 0.
      rv_result = abap_true.
    ELSE.
      rv_result = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD execute.
     rv_result = co_fizz.
  ENDMETHOD.
ENDCLASS.
