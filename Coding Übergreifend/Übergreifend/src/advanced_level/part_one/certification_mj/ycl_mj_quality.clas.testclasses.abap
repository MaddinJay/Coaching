CLASS ltcl_quality DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO yif_mj_quality.
    METHODS:
      "GIVEN: Any Quality lower 50 WHEN: Update THEN: ...
      add_quality FOR TESTING,
      "GIVEN: Quality 50 WHEN: Update THEN: ...
      max_quality_reached FOR TESTING,
      "GIVEN: Quality lower 50 WHEN: Notify THEN: ...
      add_quality_by_notify FOR TESTING.
ENDCLASS.

CLASS ltcl_quality IMPLEMENTATION.

  METHOD add_quality.
    "GIVEN
    mo_cut = NEW ycl_mj_quality( 10 ).
    "WHEN
    mo_cut->update( ).
    "THEN
    cl_abap_unit_assert=>assert_equals( exp = 11
                                        act = mo_cut->get( ) ).
  ENDMETHOD.

  METHOD max_quality_reached.
    "GIVEN
    mo_cut = NEW ycl_mj_quality( 50 ).
    "WHEN
    mo_cut->update( ).
    "THEN
    cl_abap_unit_assert=>assert_equals( exp = 50
                                        act = mo_cut->get( ) ).
  ENDMETHOD.

  METHOD add_quality_by_notify.
    "GIVEN
    mo_cut = NEW ycl_mj_quality( 10 ).
    "WHEN
    mo_cut->notify( ).
    "THEN
    cl_abap_unit_assert=>assert_equals( exp = 11
                                        act = mo_cut->get( ) ).
  ENDMETHOD.

ENDCLASS.
