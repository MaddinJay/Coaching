CLASS ltcl_code_cracker DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO yif_code_cracker.
    METHODS:
      setup,
      descript_full_alphabet FOR TESTING.
ENDCLASS.


CLASS ltcl_code_cracker IMPLEMENTATION.

  METHOD descript_full_alphabet.
    cl_abap_unit_assert=>assert_equals( exp = |!)"|
                                        act = mo_cut->descript( |abc| ) ).
  ENDMETHOD.

  METHOD setup.
    mo_cut = NEW ymj_code_cracker( ).
  ENDMETHOD.

ENDCLASS."* use this source file for your ABAP unit test classes
