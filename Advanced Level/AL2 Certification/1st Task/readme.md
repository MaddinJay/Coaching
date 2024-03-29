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

# Outside-In TDD

Zur Illustration des Aufbaus der Komponenten und deren Beziehung kann das "Hexagonale Architektur - Prinzip" verwendet werden. Dieses Prinzip hat den Vorteil, dass die einzelnen Komponenten "Outside" und "Inside" besser illustriert werden können.

![Hexagonal Architecture](https://github.com/MaddinJay/Coaching/blob/main/Advanced%20Level/Zertifizierung/Hexagonal%20Architecture.png)

Beim Outside-In TDD, auch London School of TDD genannt, geht es darum, von ausserhalb der Business-Logik kommend die am Mainflow beteiligten Komponenten zu identifzieren und deren Schnittstellen (Ports) zu definieren. Die ausserhalb der Business-Logik liegenden Komponenten werden Adapter genannt und können bei defnierten Ports der Business-Logik beliebig ausgetauscht werden. Dies spiegelt eine Asymmetrie zwischen der Business-Logik und den Adaptern wieder. Dieses Vorgehen birgt folgende Vorteile:

- Der User kann schnell Feedback geben. Dies kann bereits am Anfang des Projekts grosse Vorteile, technisch wie phychologisch, bringen.
- Die Integration der am Mainflow beteiligten Komponenten kann schnell erfolgen.
- Die integrierten Komponenten (User-Side, Business-Logic und Server-Side) können unabhängig von einander implementiert und getestet werden.

Falls das Bild der einzelnen Komponenten noch nicht geschärft werden kann, kann bei der Defintion des Mainflows von Outside-In ergänzend oder separat das "Walking-Skeleton-Prinzip" verwendet werden. Bei dessen Anwendung geht es darum, die einzelnen Komponenten zu identifizieren und deren Zusammenspiel zu illustrieren. Es wird der Mainflow implementiert, so dass die Integration schnell erfolgt. Die einzelnen Komponenten können dann unabhängig voneinander implementiert und getestet werden. 

## Ein Beispiel

Als Beispiel sei eine Abfrage von Früchten genannt, die anhand ihrer enthaltenen Vitamine aufgelistet werden. Der User fragt mit einem Vitamin an und es wird eine Liste von Früchten ausgegeben. Der Einfach halber wird ein Report mit einem Startscreen implementiert, welche ein Protokoll ausgibt.

![Hexagonal Architecture](https://github.com/MaddinJay/Coaching/blob/main/Advanced%20Level/Zertifizierung/Example%20Outside%20In%20TDD.png)

Die einzelnen Komponenten nehmen die Rollen wie folgt ein:

Enthaltene Ports:
 - yif_fruits - Schnittstelle User-Side <-> Business-Logik
 - yif_fruits_dao - Schnittstelle Business-Logik <-> Server-Side

Enthaltene Adapter:
 - User-Side: Report
 - Server-Side: Klasse ycl_fruits_dao
 
Business-Logik:
 - Klasse ycl_fruits

Die Business-Logik ist für die erste Visualisierung nicht relevant und wird gefakt. Für die Definition der relevanten Ports der Business-Logik wird ein erster Test geschrieben. Im weiteren Verlauf wird die Business-Logik TDD-getrieben weiter implementiert. Bei der TDD-Implementierung kann das Prinzip ZOMBIES angewendet werden. Die User-Side (Eingabemaske und Protokoll) und Server-Side (DB Zugriff) sind in diesem Beispiel so "trivial", dass diese nicht weiter TDD-getrieben getestet werden.  

```js
*&---------------------------------------------------------------------*
*& Report y_fruits_catalog
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT y_fruits_catalog NO STANDARD PAGE HEADING.

INTERFACE yif_fruits_dao.
  TYPES: BEGIN OF ts_fruits,
           name    TYPE string,
           vitamin TYPE char1,
           amount  TYPE curr13_2,
         END OF ts_fruits,
         tt_fruits TYPE STANDARD TABLE OF ts_fruits WITH DEFAULT KEY.

  METHODS:

    read RETURNING VALUE(rt_fruits) TYPE REF TO tt_fruits.
ENDINTERFACE.

CLASS ycl_fruits_dao DEFINITION.

  PUBLIC SECTION.
    INTERFACES yif_fruits_dao.

ENDCLASS.

CLASS ycl_fruits_dao IMPLEMENTATION.

  METHOD yif_fruits_dao~read.

  ENDMETHOD.

ENDCLASS.

INTERFACE yif_fruits.
  TYPES: BEGIN OF ts_fruit,
           name TYPE string,
         END OF ts_fruit,
         tt_fruit TYPE STANDARD TABLE OF ts_fruit WITH DEFAULT KEY.

  METHODS:
    get_by_vitamin IMPORTING iv_vitamin      TYPE char1
                   RETURNING VALUE(rt_fruit) TYPE tt_fruit.
ENDINTERFACE.

CLASS ycl_fruits DEFINITION FINAL.

  PUBLIC SECTION.
    INTERFACES: yif_fruits.

  PRIVATE SECTION.
    DATA:
      mo_fruits_dao TYPE REF TO yif_fruits_dao.

ENDCLASS.

CLASS ycl_fruits IMPLEMENTATION.

  METHOD yif_fruits~get_by_vitamin.
    "DATA(lt_fruits) = mo_fruits_dao->read( ).

    rt_fruit = VALUE #( ( name = 'Petersilie' )
                        ( name = 'Wirsing' )
                        ( name = 'Dill' ) ).
  ENDMETHOD.

ENDCLASS.

CLASS ltc_fruits DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
        mo_cut TYPE REF TO ycl_fruits.
    METHODS:
      setup,
      first_integration_test FOR TESTING.
ENDCLASS.

CLASS ltc_fruits IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW #( ).
  ENDMETHOD.

  METHOD first_integration_test.
    cl_abap_unit_assert=>assert_equals(
        exp = VALUE yif_fruits=>tt_fruit( ( name = 'Petersilie' )
                                          ( name = 'Wirsing' )
                                          ( name = 'Dill' ) )
        act = mo_cut->yif_fruits~get_by_vitamin( 'A' ) ).
  ENDMETHOD.

ENDCLASS.

SELECTION-SCREEN BEGIN OF BLOCK user_interface.
PARAMETERS: p_vitam TYPE char1.
SELECTION-SCREEN END OF BLOCK user_interface.

START-OF-SELECTION.

  DATA(lo_fruits) = NEW ycl_fruits( ).
  DATA(lt_herbs) = lo_fruits->yif_fruits~get_by_vitamin( p_vitam ).

  LOOP AT lt_herbs INTO DATA(ls_fruit).
    WRITE: / ls_fruit-name.
  ENDLOOP.
```












