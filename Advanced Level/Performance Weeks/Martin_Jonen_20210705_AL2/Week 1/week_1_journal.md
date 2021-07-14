# Day 1

Code-Kata: Zeichen zählen

Vorbereitung: 
 - Pizza -> Fragewörter sitzen noch nicht zu 100%. Sollten wiederholt werden
 - Test Inbox -> Algorithmus klar skizziert, Akzeptanztests nach ZOMBIES definiert.
              
Umsetzung: 
 - Anfang der Programmierung im Flow. Erster Test definiert. Lösung fest gesetzt.
 - Implementierung soweit flüssig
 - Probleme mit den Keys (Zoom In). Durch Update Shortcut nicht mehr gültig, musste neu eingestellt werden.
 - Exception "Initial String" sehr früh angegangen. Könnte nächstes Mal später erfolgen, weil die Exception relativ viel Zeit benötigt hat. Letztlich eine bsetehende Exception-Class verwendet.
 - Durch ZOMBIES leichte Testfälle aufgebaut, die beim dritten Testfall eine Struktur erkennen liessen.
 - Struktur dann geändert. 
 - Gestolpert über die Identifikation bereits bestehender Characters in der Ergebnistabelle
 - Algorithmus hier unschön, Lösung erarbeitet.
 - Dann, durch Hektik am Schluss, Testfälle zerschossen, weil der Akzeptanztest noch rein sollte -> Merker: Nächstes Mal nicht treiben lassen von Zeit/Aussen.
 - Lösung ist nicht komplett, Zeit war für solide Lösung (heute) nicht ausreichend.
 - ZOMBIES sitzt gut, TPP nicht weiter beachtet -> Morgen mehr auf TPP achten.

# Day 2

Vorbereitung:
 - PIZZA zum Design der Lösung
 - Focus auf Walking Skeleton, Lösung mit SAP GUI und Protocol erarbeiten
 - Design auf Papier festgehalten

Umsetzung:
 - Relativ flüssig den Report angelegt, mit Parameter, Klassen und Methodenstruktur
 - Aufrufstruktur im Report jedoch erst einmal ohne Testklassen für die Objekte angelegt.
 - Tests eingeführt als dann die Ausgabe gesetzt werden sollte.
 - Ins Stocken geraten bei der Anlage des Character-Objekts, welches die Ergebnismenge beinhaltet
 - Objekt verworfen, dann erst einmal mit Table-Returning gearbeitet und WRITE in Report
 - Als dann Struktur (Flow) stand, Characterobjekt eingefügt und PRINT-Methode ausgelagert in dieses Objekt
 - Konzentration auf den Report-Flow und Klassenstruktur. Die eigentliche Logik der Character-Ermittlung erst einmal komplett hinten angestellt

Lesson Learned:
 - Wlaking Skeleton gibt dem, User ein schnelles visuelles Feedback.
 - Auch wenn der Algorithmus noch nicht funktioniert, kann der User sich vorstellen, wie das Programm abläuft und köännte nun schon Designvorschläge machen.
 - Fokus auf saubere Reportstruktur und auf einen sauberen Flow. Den Algorithmus bewusst hinten angestellt. 

# Day 3

Vorbereitung:
 - TestInbox mit 3 Lösungsalternativen verwendet
 - Alain Kays "Everything is an Object" berücksichtigt
 - Akzeptanztest definiert, finaler Test
 - 
Umsetzung:
 - Akzeptanztest Light aufgebaut ("Erster Buchstabe wird weiterlgeleitet")
 - Den Akzeptanztest immer weiter modifiziert, so dass der Endlösung angenähert wurde.
 - Ergebnisobjekt erst einmal runtergebrochen auf eine Zeile, Schritt für Schritt Input und Output eingeführt.

Lesson Learned:
 - Growing Acceptancetest ist noch gut
 - Bei einfachen Problemen bruacht es nicht ewig viele Tests
 - Flow konnt gut beibehalten werden.
 - Ansatz mit 3 Lösungsvarianten sehr wertvoll
 - TestInbox effektiv, wenn sie auch einfach erscheint 

# Day 4

Vorbereitung:
 - PIZZA verwendet um Problem zu analysieren
 - Fokus auf Outside/In
 - Definition Akzeptanztest 

Umsetzung:
 - Fokus auf Testklasse und Akzeptanztest
 - Report mit Eingabe, Converting Logic und Protocol erstellt
 - Erst den Test Grün gesetzt, dann die Integration in den Report durchgeführt. Integration sehr leicht dann.
 - Fokus auf "Everything is an object" -> Input und Output als Objekt definiert.
 - Nach erfolgreicher Integration der Klassen in den REport wird der Akzeptanztest gestrippt, um die Zähllogik einzubauen

Lesson Learned:
 - Integration der Klasse im Report sehr wertvoll, da so der ganze Prozess definiert und gesehen werden kann
 - Erste Visualisierung durch "mock-Daten" gibt ein gutes Gefühl, dass der Report läuft und für User sicherlich wertvoll
 - Strippen des Akzeptanztests (sukzessive Erschliessung der Character, beginnend mit String "D" -> "Da" lässt den Algorihtmus langsam wachsen und gitb volle Kontrolle über den Entwicklungsprozess
 - Anwendung des MESSAGE und Tell Don't Ask Prinzips verschiebt die Logik in die entsprechenden Objekte.


# Day 5

Vorbereitung:
 - Fokus heute auf der Umsetzung, nur kurz die Aufgabe nochmal review passieren lassen.
 - Fokus auf dem Algorithmus

Umsetzung:
 - Akzeptanztest erstellt, wobei dieser sukzessive aufgebaut wurde ( 'D' -> 'Da' )
 - TPP angewendet. Erst Konstanten gesetzt, dann while Schleife integriert
 - auf Grundlagen geachtet (IOSP, Tell don't ask)
 - TPP angewendet
 - Flow konnte aufrecht erhalten bleiben. Problem mit der Interpretation des Leerzeichen auf später verschoben "TODO"
 - Bisschen holperich bei der Algorithmusintegration. Problem auf einmal zu gross gewesen, versucht auf das wesentliche zu konzentrieren
 - zum Schluss Membervariablen eingeführt, um Übersicht wieder herzustellen
 - Inputstring und Ergebnistabelle soll im Anschluss als Objekt erfasst werden, hier verschoben auf später

Lesson Learned:
 - Vorbereitung und Visualisierung des Problems essentiell
 - Akzeptanztest sukzessive aufbauen dient der Übersicht. Kleine Schritte. Nur ein Test, der gewartet werden muss.
 - Zu wenig "Tell don't ask" angewendet. 
 - Die Integration von Objekten schneller realisieren, dient dem Handling der Daten (Ergebnis-Objekt sinnvoll hier) 
 - 
