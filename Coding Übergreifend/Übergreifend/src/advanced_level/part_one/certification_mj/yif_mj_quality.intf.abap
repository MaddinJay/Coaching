INTERFACE yif_mj_quality
  PUBLIC .

  TYPES: tv_quality TYPE i.

  METHODS:
    "! Update Quality by adding Quality if Maximum not reached
    update,
    "! Get Quality
    "! @parameter rv_quality | Quality Value
    get
      RETURNING VALUE(rv_quality) TYPE tv_quality,
    "! Notification received
    notify.
ENDINTERFACE.
