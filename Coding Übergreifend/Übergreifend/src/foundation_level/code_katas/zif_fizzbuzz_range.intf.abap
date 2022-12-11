INTERFACE ZIF_FIZZBUZZ_RANGE
  PUBLIC .
  TYPES: ty_number_range TYPE RANGE OF i.
  TYPES: ty_value_to_number TYPE TABLE OF zsw_fizzbuzz.
  METHODS: convert_number_to_fizzbuzz IMPORTING iv_number TYPE ty_number_range
                EXPORTING ev_value_to_number TYPE ty_value_to_number.
ENDINTERFACE.
