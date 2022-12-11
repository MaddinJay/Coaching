INTERFACE yif_bounded_queue
  PUBLIC .
  TYPES: BEGIN OF ts_queue,
           value       TYPE REF TO data,
           is_dequeued TYPE abap_bool,
           is_hold     TYPE abap_bool,
         END OF ts_queue.
  TYPES: tt_queue TYPE STANDARD TABLE OF ts_queue WITH DEFAULT KEY.

  "! Hängt den übergebenen Wert an die Queue an (First IN / First Out)
  "! Falls das Queue-Limit erreicht wird, werden die Werte auf Halte gelegt
  "! @parameter iv_queue_value | Übergabe des Aufrufes an die Queue
  METHODS enqueue
    IMPORTING
      iv_queue_value TYPE REF TO data.
  "! Ensperrt einen Wert gemäss der importierten Reihenfolge (First IN / First OUT)
  "! @parameter rv_dequeued_element | Entsperrter Eintrag aus der Queue
  "! @raising ycx_mj_static_check | Ausnahmeklasse Coaching
  METHODS dequeue
    RETURNING
      VALUE(rv_dequeued_element) TYPE REF TO data
    RAISING
      ycx_mj_static_check.
ENDINTERFACE.
