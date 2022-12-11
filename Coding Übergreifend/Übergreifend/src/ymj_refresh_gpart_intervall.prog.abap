*&---------------------------------------------------------------------*
*& Report ymj_refresh_gpart_intervall
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymj_refresh_gpart_intervall NO STANDARD PAGE HEADING.

SELECTION-SCREEN BEGIN OF BLOCK one.
PARAMETERS: i_object TYPE object_kk,
            i_var    TYPE variant_kk.
SELECTION-SCREEN END OF BLOCK one.

END-OF-SELECTION.
*--- Enqueue ... ------------------------------------------------------
  DATA(lo_distribution_intervals) = NEW zcl_fs_distribution_intervals( iv_object = i_object iv_variant = i_var ).

  lo_distribution_intervals->enqueue_object_variant( ).
  lo_distribution_intervals->set_variant_intervals( ).
  lo_distribution_intervals->dequeue_object_variant( ).
  WRITE: 'Objektvariante erfolgreich aktualisiert.'.
