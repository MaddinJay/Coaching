# Test Doubles

Test Doubles sind vorbestimmte Objekte, welche an Stelle von integrierten Objekten im betesteten Coding verwendet werden. Test Doubles werden dazu verwendet, um Abhängigkeiten im produktiven Coding zu brechen und so Coding testbar zu machen. Mit diesem vorbestimmten Verhalten der integrierten Objekte lässt sich eine Methode oder ein Flow auf ein bestimmtes, eindeutiges Verhalten testen.

Unterschieden werden Test Doubles zwischen:
- Dummies
- Stubs
- Mocks 
- Fakes

## Dummies
Dummies können für integrierte Objekte, von denen die CUT (Component Under Test) abhängt, verwendet werden, wenn im Test nicht auf diese Objekte zugegriffen werden muss. Für den Test sind sie nicht weiter von Relevanz, ausser das ohne ihre Instanziierung der Testfall der CUT nicht funktionieren würde.

**Class under Test:**
```js
CLASS ycl_test_dummy DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      format IMPORTING io_messenger            TYPE REF TO ycl_messenger
             RETURNING VALUE(rv_formated_text) TYPE string.

  PRIVATE SECTION.
    DATA:
      mv_formated_text TYPE string.
ENDCLASS.

CLASS ycl_test_dummy IMPLEMENTATION.

  METHOD format.
    " Do something with io_messenger, does not interfere expected result ...

    " Format Text for Return ...
    mv_formated_text = 'Hallo'.

    rv_formated_text = mv_formated_text.
  ENDMETHOD.

ENDCLASS.
```

**Test Class with Dummy:**
```js
CLASS ltc_dummy DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
        mo_cut TYPE REF TO ycl_test_dummy.
    METHODS:
      setup,
      test_format_transformation FOR TESTING.
ENDCLASS.


CLASS ltc_dummy IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW #( ).
  ENDMETHOD.

  METHOD test_format_transformation.
    cl_abap_unit_assert=>assert_equals(
        exp = 'Hallo'
        act = mo_cut->format( NEW ycl_messenger( ) ) ).
  ENDMETHOD.

ENDCLASS.
```

## Stubs
Stub Objekte beinhalten fixe Antworten auf Methodenaufrufe. Gewöhnlich antworten sie nicht auf alle Anfragen von aussen, lediglich die für die Tests des CUT relevanten Methoden und Variablen werden implementiert. Stubs werden **Spies** genannt, wenn sie sich zusätzlich Informationen zu Aufrufen von Methoden merken. In SAP werden Stubs gewöhnlich mit Lokalen Test-Double Klassen implementiert.

**Class under Test:**
```js
CLASS ycl_test_double_stub DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: yif_test_double_stub.
    ALIASES: get_uuid FOR yif_test_double_stub~get_uuid.

  PRIVATE SECTION.
    DATA mv_uuid TYPE uuid.

ENDCLASS.

CLASS ycl_test_double_stub IMPLEMENTATION.

  METHOD yif_test_double_stub~get_uuid.
    " do something
    rv_uuid = mv_uuid.
  ENDMETHOD.

ENDCLASS.
```
**Test Class:**
```js
CLASS ltc_test_double_stub DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
        mo_cut TYPE REF TO ltd_test_double_stub.
    METHODS:
      get_right_uuid FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltc_test_double_stub IMPLEMENTATION.

  METHOD get_right_uuid.
    mo_cut = NEW ltd_test_double_stub( ).
    cl_abap_unit_assert=>assert_equals(
        exp = '12345678901234567890123456789012'
        act = mo_cut->yif_test_double_stub~get_uuid( ) ).
  ENDMETHOD.

ENDCLASS.
```

**Stub Object:**
```js
CLASS ltd_test_double_stub DEFINITION.
  PUBLIC SECTION.
    INTERFACES: yif_test_double_stub.
ENDCLASS.

CLASS ltd_test_double_stub IMPLEMENTATION.

  METHOD yif_test_double_stub~get_uuid.
    rv_uuid = '12345678901234567890123456789012'.
  ENDMETHOD.

ENDCLASS.

```
## Mocks 
Mock Objekte ermöglichen die Defintion einer Erwartung an den Aufruf von Methoden. Für Methodenaufrufe mit spezifisch definierten Parametern liefern sie eine vordefinierte Antwort zurück. Werden Methoden mit abweichenden Parametern aufgerufen, kommt es im Testfall zu einem Fehler. Mock Objekte sind flexibler einsetzbar als Stubs, weil ihr Verhalten individuell an den Testfall angepasst werden kann. Stubs beinhalten ein starres, vordefiniertes Verhalten. In SAP nutzt man für die Instanziierung von Mock Objekten gewöhnlich das TESTDOUBE Framework.

**Class under Test:**
```js
INTERFACE yif_test_double_mock
  PUBLIC .
  TYPES: ty_vitamin TYPE char2,
         ty_fruit   TYPE string.

  METHODS: get_fruit_by_vitamin IMPORTING iv_vitamin      TYPE ty_vitamin
                                RETURNING VALUE(rv_fruit) TYPE ty_fruit.

ENDINTERFACE.

CLASS ycl_test_double_mock DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor           IMPORTING io_fruits       TYPE REF TO yif_test_double_mock,

      get_fruit_by_vitamin  IMPORTING iv_vitamin      TYPE yif_test_double_mock=>ty_vitamin
                            RETURNING VALUE(rv_fruit) TYPE yif_test_double_mock=>ty_fruit.

  PRIVATE SECTION.
    DATA:
      mo_fruits TYPE REF TO yif_test_double_mock.

ENDCLASS.

CLASS ycl_test_double_mock IMPLEMENTATION.

  METHOD constructor.
    mo_fruits = io_fruits.
  ENDMETHOD.

  METHOD get_fruit_by_vitamin.
    rv_fruit = mo_fruits->get_fruit_by_vitamin( iv_vitamin ).
  ENDMETHOD.

ENDCLASS.
```

**Test Class with integrated Mock Object:**
```js
CLASS ltc_test_double_mock DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut         TYPE REF TO ycl_test_double_mock,
      mo_fruits_mock TYPE REF TO yif_test_double_mock.

    METHODS:
      setup,
      test_get_brennessel FOR TESTING,
      test_get_karotte    FOR TESTING.

ENDCLASS.

CLASS ltc_test_double_mock IMPLEMENTATION.

  METHOD setup.
    mo_fruits_mock ?= cl_abap_testdouble=>create( 'yif_test_double_mock' ).
    mo_cut = NEW #( mo_fruits_mock ).
  ENDMETHOD.

  METHOD test_get_brennessel.
    cl_abap_testdouble=>configure_call( mo_fruits_mock )->returning( 'Brennnessel' ).
    mo_fruits_mock->get_fruit_by_vitamin( 'C' ).

    cl_abap_unit_assert=>assert_equals(
        exp = 'Brennnessel'
        act = mo_fruits_mock->get_fruit_by_vitamin( 'C' ) ).
  ENDMETHOD.

  METHOD test_get_karotte.
    cl_abap_testdouble=>configure_call( mo_fruits_mock )->returning( 'Karotte' ).
    mo_fruits_mock->get_fruit_by_vitamin( 'E' ).

    cl_abap_unit_assert=>assert_equals(
        exp = 'Karotte'
        act = mo_fruits_mock->get_fruit_by_vitamin( 'E' ) ).
  ENDMETHOD.

ENDCLASS.
```

## Fakes
Fake Objekte beinhalten eine "abgespeckte" Implementierung der integrierten Objekte, um die CUT betesten zu können. Es handelt sich hierbei zumeist um Objekte, die "ausserhalb unserer Reichweite" liegen. In SAP wäre dies beispielsweise das Schreiben des Applikations-Logs oder die Interaktion mit der Datenbank. Beides lässt sich im Testfall nicht simulieren, so dass ein Fake Objekt das Schreiben oder Lesen simulieren würde. Fake Objekte können sich wie Dummies, Stubs bzw. Spies oder Mocks verhalten.

**Class Under Test:**
```js
CLASS ycl_test_fake DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING io_application_server TYPE REF TO yif_application_server,
      log_message IMPORTING iv_message TYPE string.
      
  PRIVATE SECTION.
    DATA:
      mo_application_server TYPE REF TO yif_application_server.
      
ENDCLASS.

CLASS ycl_test_fake IMPLEMENTATION.

  METHOD constructor.
    mo_application_server = io_application_server.
  ENDMETHOD.

  METHOD log_message.
    mo_application_server->log_message( iv_message ).
  ENDMETHOD.

ENDCLASS.
```

**Fake Object (Spy Object):**
```js 
CLASS ltd_application_server DEFINITION FOR TESTING.

  PUBLIC SECTION.
    INTERFACES: yif_application_server.
    METHODS: check_was_logged RETURNING VALUE(rv_return) TYPE abap_bool.

  PRIVATE SECTION.
    DATA:
      mv_log_flag TYPE abap_bool.

ENDCLASS.

CLASS ltd_application_server IMPLEMENTATION.

  METHOD yif_application_server~log_message.
    mv_log_flag = abap_true.
  ENDMETHOD.

  METHOD check_was_logged.
    rv_return = mv_log_flag.
  ENDMETHOD.

ENDCLASS.
```

**Test Class:**
```js
CLASS ltc_fake DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut                TYPE REF TO ycl_test_fake,
      mo_application_server TYPE REF TO ltd_application_server.
    METHODS:
      setup,
      test_log_message FOR TESTING.
ENDCLASS.


CLASS ltc_fake IMPLEMENTATION.

  METHOD setup.
    mo_application_server = NEW ltd_application_server( ).
    mo_cut                = NEW #( mo_application_server ).
  ENDMETHOD.

  METHOD test_log_message.
    mo_cut->log_message( iv_message = 'Test' ).
    cl_abap_unit_assert=>assert_equals(
        exp = abap_true
        act = mo_application_server->check_was_logged( ) ).
  ENDMETHOD.

ENDCLASS.
```







