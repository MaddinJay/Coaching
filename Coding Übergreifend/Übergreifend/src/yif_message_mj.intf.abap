interface YIF_MESSAGE_MJ
  public .


  data MV_MESSAGE type STRING .

  methods GET_MESSAGE
    returning
      value(RV_MESSAGE) type STRING .
endinterface.
