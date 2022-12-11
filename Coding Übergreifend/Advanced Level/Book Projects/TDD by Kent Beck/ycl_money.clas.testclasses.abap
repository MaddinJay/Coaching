CLASS ltcl_money_example DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut_one TYPE REF TO yif_money_example,
      mo_cut_two TYPE REF TO yif_money_example.

    METHODS:
      testmultiplication FOR TESTING,
      testcurrency       FOR TESTING,
      testsimpleaddition FOR TESTING,
      testplusreturnssum FOR TESTING,
      testreducemoney    FOR TESTING,
      reducemoneydifferentcurrency FOR TESTING RAISING cx_static_check,
      testmixedaddition FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS ltcl_money_example IMPLEMENTATION.

  METHOD testmultiplication.
    cl_abap_unit_assert=>assert_true(  ycl_money=>dollar( 10 )->equals( ycl_money=>dollar( 5 )->times( 2 ) ) ).
    cl_abap_unit_assert=>assert_false( ycl_money=>dollar( 16 )->equals( ycl_money=>dollar( 5 )->times( 3 ) ) ).
    cl_abap_unit_assert=>assert_true(  ycl_money=>franc( 10 )->equals( ycl_money=>franc( 5 )->times( 2 ) ) ).
    cl_abap_unit_assert=>assert_false( ycl_money=>franc( 11 )->equals( ycl_money=>franc( 5 )->times( 2 ) ) ).
  ENDMETHOD.

  METHOD testcurrency.
    cl_abap_unit_assert=>assert_equals( exp = |USD|
                                        act = ycl_money=>dollar( 1 )->currency( ) ).
    cl_abap_unit_assert=>assert_equals( exp = |CHF|
                                        act = ycl_money=>franc( 1 )->currency( ) ).
    cl_abap_unit_assert=>assert_equals( exp = |USD|
                                        act = ycl_money=>dollar( 1 )->times( 2 )->currency( ) ).
    cl_abap_unit_assert=>assert_equals( exp = |CHF|
                                        act = ycl_money=>franc( 1 )->times( 2 )->currency( ) ).
    cl_abap_unit_assert=>assert_equals( exp = |CHF|
                                        act = ycl_money=>franc( 1 )->times( 2 )->currency( ) ).
  ENDMETHOD.

  METHOD testsimpleaddition.
    DATA(lo_five)       = NEW ycl_money( iv_amount = 5 iv_currency = |USD| ).
    DATA(lo_expression) = lo_five->plus( lo_five ).
    DATA(lo_reduced)    = NEW ycl_bank( )->reduce( io_expression = lo_expression iv_currency = |USD| ).
    cl_abap_unit_assert=>assert_true( ycl_money=>dollar( 10 )->equals( lo_reduced ) ).
  ENDMETHOD.

  METHOD testplusreturnssum.
    DATA(lo_sum)     = NEW ycl_sum( io_augend = ycl_money=>dollar( 3 ) io_addend = ycl_money=>dollar( 4 ) ).
    DATA(lo_reduced) = NEW ycl_bank( )->reduce( io_expression = lo_sum iv_currency = |USD| ).
    cl_abap_unit_assert=>assert_true( ycl_money=>dollar( 7 )->equals( lo_reduced ) ).
  ENDMETHOD.

  METHOD testreducemoney.
    DATA(lo_result) = NEW ycl_bank( )->reduce(
                                      io_expression = ycl_money=>dollar( 1 )
                                      iv_currency   = |USD| ).
    cl_abap_unit_assert=>assert_true( ycl_money=>dollar( 1 )->equals( lo_result ) ).
  ENDMETHOD.

  METHOD reducemoneydifferentcurrency.
    DATA(lo_bank) = NEW ycl_bank( ).
    lo_bank->add_rate( iv_currency_from = |CHF|
                       iv_currency_to   = |USD|
                       iv_rate          = 2 ).
    DATA(lo_money) = lo_bank->reduce( io_expression = ycl_money=>franc( 2 )
                                      iv_currency   = |USD| ).
    cl_abap_unit_assert=>assert_true( ycl_money=>dollar( 1 )->equals( lo_money ) ).
  ENDMETHOD.

  METHOD testmixedaddition.
    DATA(lo_fivebucks) = ycl_money=>dollar( 5 ).
    DATA(lo_tenfrancs) = ycl_money=>franc( 10 ).

    DATA(lo_bank) = NEW ycl_bank( ).
    lo_bank->add_rate(
        iv_currency_from = |CHF|
        iv_currency_to   = |USD|
        iv_rate          = 2 ).

    DATA(lo_result) = lo_bank->reduce(
                        io_expression = lo_fivebucks->plus( lo_tenfrancs )
                        iv_currency   = |USD| ).
    cl_abap_unit_assert=>assert_true( ycl_money=>dollar( 10 )->equals( lo_result ) ).
  ENDMETHOD.

ENDCLASS.
