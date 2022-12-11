INTERFACE yif_item
  PUBLIC .
  TYPES: to_quality TYPE REF TO ycl_quality,
         tv_sell_in TYPE REF TO ycl_sell_in.
  "! Update of Item, Quality and Sell In are updated
  METHODS
    update.
ENDINTERFACE.
