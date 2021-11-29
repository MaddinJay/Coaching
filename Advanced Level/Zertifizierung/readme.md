# Test Doubles

Test Doubles sind vorbestimmte Objekte, welche im Test von produktiven Objekten an Stelle von integrierten Objekten verwendet werden. Auf diese Weise wird das produktive Coding testbar. Test Doubles werden demnach dazu verwendet, um Abhängigkeiten im produktiven Coding zu brechen. In der Literatur sind unterschiedliche Interpretationen der unterschiedlichen Typen von Test-Doubles zu finden. Wir verwenden hier die Definition nach Martin Fowler. 

Unterschieden werden Test Doubles zwischen:
- Dummies
- Stubs
- Fakes
- Mocks 

## Dummies
Dummies sind "leere" Objekte, welche in Funktionsaufrufen übergeben werden. Sie beinhalten keinerlei Daten und werden im Mainflow des Tests nicht verwendet. Sie werden lediglich für das Füllen der Parameterlisten verwendet und ermöglichen so, dass fehlerfreie Ausführen der Tests bzw. betesteten Objekte.

## Fakes
Fake Objekte beinhalten eine "abgespeckte" Implementierung der integrierten Objekte. Fake Objekte sind somit nicht produktiv einsetzbar. 

## Stubs
Stubs Objekte beinhalten fixe Antworten auf Methodenaufrufe. Gewöhnlich antworten sie nicht auf alle Anfragen von aussen. Stubs werden Spies genannt, wenn sie sich zusätzliche Informationen zu Aufrufen von Methoden merken. In SAP werden Stubs gewöhnlich mit Lokalen Test-Double Klassen implementiert.

## Mocks 
Mock Objekte ermöglichen die Defintion einer Erwartung an den Aufruf von Methoden. Für Methodenaufrufe mit spezifischen Parametern liefern sie eine defnierte Antwort zurück. Mock Objekte sind flexibler einsetzbar als Stubs, weil sie felxibel ihr Verhalten ändern können. Stubs beinhalten ein starres, vordefiniertes Verhalten. In SAP nutzt man hierzu das TESTDOUBE Framework.






