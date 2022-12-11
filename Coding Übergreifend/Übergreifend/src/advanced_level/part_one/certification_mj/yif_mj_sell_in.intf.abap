INTERFACE yif_mj_sell_in
  PUBLIC .
  TYPES: tv_sell_in TYPE i.
  METHODS:
    "! Update Sell In Value and Notify Quality if needed
    update,
    "! Get Sell in Value
    "! @parameter rv_sell_in | Sell In Value
    get
      RETURNING VALUE(rv_sell_in) TYPE tv_sell_in.
ENDINTERFACE.
