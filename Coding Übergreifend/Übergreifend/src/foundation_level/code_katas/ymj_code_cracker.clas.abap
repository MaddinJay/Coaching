CLASS ymj_code_cracker DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES yif_code_cracker.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      mv_descrypted_text TYPE string.

    METHODS repl_letter_with_decrypt_key
      IMPORTING
        iv_letter          TYPE text1
        iv_descryption_key TYPE text1.
ENDCLASS.

CLASS ymj_code_cracker IMPLEMENTATION.

  METHOD yif_code_cracker~descript.
    mv_descrypted_text = iv_text.
    repl_letter_with_decrypt_key( iv_letter = |a| iv_descryption_key = |!| ).
    repl_letter_with_decrypt_key( iv_letter = |b| iv_descryption_key = |)| ).
    repl_letter_with_decrypt_key( iv_letter = |c| iv_descryption_key = |"| ).
    rv_descripted_text = mv_descrypted_text.
  ENDMETHOD.

  METHOD repl_letter_with_decrypt_key.
    REPLACE ALL OCCURRENCES OF iv_letter IN mv_descrypted_text WITH iv_descryption_key.
  ENDMETHOD.

ENDCLASS.
