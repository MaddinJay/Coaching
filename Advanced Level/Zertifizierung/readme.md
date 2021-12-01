# Test Doubles

Test Doubles sind vorbestimmte Objekte, welche im betesteten Coding an Stelle von integrierten Objekten verwendet werden. Test Doubles werden dazu verwendet, um Abhängigkeiten im produktiven Coding zu brechen. In der Literatur sind unterschiedliche Interpretationen der unterschiedlichen Typen von Test-Doubles zu finden. Wir verwenden hier die Definition nach Martin Fowler. 

Unterschieden werden Test Doubles zwischen:
- Dummies
- Stubs
- Fakes
- Mocks 

## Dummies
Dummies sind "leere" Objekte, welche in Funktionsaufrufen übergeben werden. Sie beinhalten keinerlei Daten und werden im Mainflow des Tests nicht explizit durch Zugriff auf das Objekt verwendet. Sie werden lediglich für das Füllen der Parameterlisten von Funktionen verwendet und ermöglichen so, dass fehlerfreie Ausführen eines unter Test stehenden Objektes.

## Fakes
Fake Objekte beinhalten eine "abgespeckte" Implementierung der integrierten Objekte. Lediglich die für das Testen benötigten Methoden oder Variablen werden so gesetzt, dass die Ausführung des betesten Objekts fehlerfrei durchläuft und das betestete Objekt aktionsfähig ist.  

## Stubs
Stub Objekte beinhalten fixe Antworten auf Methodenaufrufe. Gewöhnlich antworten sie nicht auf alle Anfragen von aussen, lediglich für die Tests des SUT (System under Test) relevanten Methoden und Variablen werden implementiert. Stubs werden **Spies** genannt, wenn sie sich zusätzlich Informationen zu Aufrufen von Methoden merken. In SAP werden Stubs gewöhnlich mit Lokalen Test-Double Klassen implementiert.

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
Mock Objekte ermöglichen die Defintion einer Erwartung an den Aufruf von Methoden. Für Methodenaufrufe mit spezif definierten Parametern liefern sie eine vordefinierte Antwort zurück. Werden Methoden mit abweichenden Parmetern aufgerufen, kommt es im Testfall zu einem Fehler. Mock Objekte sind flexibler einsetzbar als Stubs, weil ihr Verhalten individuell an den Testfall anpassbar ist. Stubs beinhalten ein starres, vordefiniertes Verhalten. In SAP nutzt man für die Instanziierung von Mock Objekten das TESTDOUBE Framework.

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
```





