CLASS ltcl_russian_multiplication DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    DATA:
      mo_cut TYPE REF TO yif_russian_multiplication.

    METHODS:
      setup,
      calculation_success          FOR TESTING,
      calculation_lower_boundary_x FOR TESTING.
ENDCLASS.

CLASS ltcl_russian_multiplication IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW ycl_russian_multipl( ).
  ENDMETHOD.

  METHOD calculation_success.
    cl_abap_unit_assert=>assert_equals( exp = 1974
                                        act = mo_cut->calculate(
                                                iv_value_x = 47
                                                iv_value_y = 42 ) ).
  ENDMETHOD.

  METHOD calculation_lower_boundary_x.
    cl_abap_unit_assert=>assert_equals( exp = 42
                                        act = mo_cut->calculate(
                                                iv_value_x = 1
                                                iv_value_y = 42 ) ).
  ENDMETHOD.

ENDCLASS.
