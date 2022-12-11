CLASS ZCL_FIZZBUZZ_RANGE_STRATEGY DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS: can_execute ABSTRACT IMPORTING iv_number TYPE i                "da sämtliche MEthoden abstrakt -> lieber Interface machen
                                   RETURNING value(rv_result) TYPE boolean,
             execute ABSTRACT
             RETURNING VALUE(rv_result) type string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FIZZBUZZ_RANGE_STRATEGY IMPLEMENTATION.
ENDCLASS.
