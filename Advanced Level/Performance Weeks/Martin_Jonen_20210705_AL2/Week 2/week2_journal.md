# Day 6

Vorbereitungen:
 - Code Kata studiert
 - PIZZA angewendet, um die Aufgabe zu greifen
 - Problem auf eine Zelle runtergebrochen, um in die Umsetzung zu gehen
 - Die Regeln als Akzeptanztests definiert, um den Algorithmus greifen zu können
 - Chicago School of TDD anwenden, weil die Aufgabenstellung noch nicht klar genug erscheint

Umsetzung:
 - Anfang mit erstem Akzeptanztest
 - Definition der Zelle und Nachbarn als 3x3 Tabelle
 - Tabellenkonzept verworfen, Zellenstruktur geändert, um den Algorithmus leichter umzusetzen
 - Akzeptanztests nach und nach aufgebaut
 - Refactoring erst zum Schluss richtig durchgeführt

Lesson Learned:
 - Falls man keine Ahnung hat, wie der Algorithmus wirklich ablaufen soll, bietet sich Chicage School of TDD gut an
 - Akzeptanztests geben ein gutes Gefühl für die erste Umsetzungslogik und setzen einen guten Anker
 - Verwerfen von Ansätzen erleichtert das weitere Vorgehen
 - Umsetzung bis dahin im Flow erfolgt
 - Für grössere Konezepte fehlt der Überblick zu anfangs
 - Mit weiteren Akzeptanztests kristallisiert sich eine Struktur heraus

# Day 7

Vorbereitungen:
 - Analyse des Spiels, Einsatz des Algorithmus
 - Problemstellung runter gebrochen auf ein 4x4 Gitter
 - Akzeptanztest definiert als ein Snapshot, welcher den Status durch einen Durchlauf des Algorithmus wechselt

Umsetzung:
 - Erstellen erster Test bezogen auf Zelle B2, welche den Status von lebend auf tot wechselt
 - Erstellen zweiter Test bezogen auf Zelle A1, welche den Status von tot auf lebend wechselt
 - Erstellen dritten Test bezogen auf Wechselwirkung von Statuswechsel A1 auf B2 (Anzahl Nachbarn erhöhen) (Obsover Pattern)

Lesson Learned:
 - Akzeptanztest eines konkrteten Statuswechsels hilft dabei, das Spiel besser zu verstehen
 - Baby Steps beim Testing lassen einen guten Flow erzeugen
 - Mit dem Vorwissen von gestern deutlich einfacher umzusetzen heute
 - Übung gestern sehe ich als Warm Up für die Umsetzung heute. Reinfühlen, Problem verstehen, Überblick verschaffen durch konkrete Umsetzung
 - Neuer Ansatz viel erfolgsversprechender als der Ansatz von gestern -> Mut aufbringen, Lösungen einfach weg zuwerfen und neu anzufangen 
