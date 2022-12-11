REPORT ymj_determine_subclasses.

PARAMETERS: p_clname TYPE seoclass-clsname.

DATA:
  g_class      TYPE REF TO cl_oo_class,
  g_subclasses TYPE seo_relkeys,
  g_subclass   TYPE seorelkey.

END-OF-SELECTION. ##todo " START und END-OF-SEL recherchieren

  TRY.
      g_class ?= cl_oo_class=>get_instance( clsname = p_clname ).
      g_subclasses = g_class->get_subclasses( ).
    CATCH cx_class_not_existent.
      MESSAGE e001(z_coaching_mj). "DISPLAY LIKE 'I'.
  ENDTRY.

  LOOP AT g_subclasses INTO g_subclass.
    WRITE: g_subclass-refclsname, 30 g_subclass-clsname.
    NEW-LINE.
  ENDLOOP.
