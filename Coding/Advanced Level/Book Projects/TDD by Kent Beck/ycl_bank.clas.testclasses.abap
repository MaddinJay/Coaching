CLASS ltcl_bank DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO ycl_bank.
    METHODS:
      testidentityrate FOR TESTING.
ENDCLASS.

CLASS ltcl_bank IMPLEMENTATION.

  METHOD testidentityrate.
    mo_cut = NEW #( ).
    cl_abap_unit_assert=>assert_equals( exp = 1
                                        act = mo_cut->rate(
                                                iv_currency_from = |USD|
                                                iv_currency_to   = |USD| ) ).
  ENDMETHOD.

ENDCLASS.
