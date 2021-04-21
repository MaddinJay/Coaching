CLASS ltcl_pair DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO ycl_pair.
    METHODS:
      check_is_equals_success FOR TESTING.
ENDCLASS.

CLASS ltcl_pair IMPLEMENTATION.

  METHOD check_is_equals_success.
    cl_abap_unit_assert=>assert_true( NEW ycl_pair( iv_from = |CHF| iv_to = |USD| )->equals( NEW ycl_pair( iv_from = |CHF| iv_to = |USD| ) ) ).
  ENDMETHOD.

ENDCLASS.
