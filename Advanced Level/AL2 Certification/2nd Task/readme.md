# Workbook

**Notice:**
Das Coding ist im ZIP-File "certification-al2" zu finden. Die Commits fanden auf Bitbucket in der CSS Umgebung statt. Falls die Commit-Historie interessant ist, kann dort Einblick gewährt werden.

## Step 1: Definition Golden Master und Exportieren lokaler Klassen

Als "Interception Point" wird die Methode LCL_MAIN_PROGRAM->ON_DOUBLE_CLICK, in der Klasse ZDPD_APP_CON_GUI identifiziert. Das Exportieren der verwendeten Klassen für die Anzeige der Detailliste im rechten Subscreen, wenn der User auf einen der Folder im Tree doppelt klickt, kann so gewissenhaft durchgeführt werden. Ein automatisches Testing der Anwendung ist leider nicht möglich, da keine entsprechende Testsoftware vorliegt. Ein Testing mit Hilfe von UNIT-Tests ist aufgrund der integrierten GUI-Anzeige-Logik nicht zu erkennen. 

Als **Golden Master** wird das Verhalten der Anwendung bei Doppelklick eines Tree-Nodes definiert. Durch User-Aktion wird geprüft, ob die Anwendung noch funktionsfähig ist. Dies ermöglicht in einem ersten Schritt das Exportieren der lokalen Klassen in globale Klassen. Dieser Schritt dient dazu, sich einen besseren Überblick über den Aufbau der Klassen zu verschaffen.

Für den finalen Test gegen den "Golden Master" werden die angezeigten Daten in den Detaillisten als EXCEL-Sheet abgelegt. 

Das Risiko für Fehler beim Refactoring wird als gering eingestuft. Es werden "lediglich" Klassen umgezogen. Eine inhaltliche Logikänderung innerhalb der Klassen erfolgt nicht.

**Akzeptanzkritieren:**
 - Durch Doppelklick auf Knoten im Baum (Flight Schedules, Flights, Carriers) wird im rechten Screen die Detailliste geöffnet. Inhalt stimmt noch mit Ursprung überein.
 
**Aufbau der Klassenstruktur nach erfolgtem Refactoring:**

![Step 1](https://github.com/MaddinJay/Certification-AL2/blob/main/2nd%20Task/Bilder/UML%20First%20Step.JPG)

## Step 2: ALV Klasse outsourcen und MVC-Pattern für Subscreen Detailliste anwenden

In der Methode LCL_MAIN_PROGRAM->ON_DOUBLE_CLICK wird die ALV-Klasse zur Anzeige der Detailliste lokal instanziiert. Die ALV-Klasse selbst ist lokal definiert in der Klasse ZDPD_APP_CON_GUI. 

Die Idee kommt auf, das MVC-Pattern anzuwenden. Um dies final realisieren zu können, werden in einem ersten Schritt die benötigten Klassen in globale Klassen ausgelagert.

Wie in Step 1 wird der Goldene Master verwendet, um zu prüfen, ob die Funktionalität erhalten geblieben ist. 

**Akzeptanzkriterien:**
  - Durch Doppelklick auf Knoten im Baum (Flight Schedules, Flights, Carriers) wird im rechten Screen die Detailliste geöffnet. Inhalt stimmt noch mit Ursprung überein.

**Aufbau der Klassenstruktur nach erfolgtem Refactoring:**

![Step 2](https://github.com/MaddinJay/Certification-AL2/blob/main/2nd%20Task/Bilder/UML%20Second%20Step.JPG)

Es bleibt offen, ob das MVC-Pattern, was derzeit hier noch nicht zu erkennen ist, Bestand haben wird. 

## Step 3: Refactoring der Tree-Node-Klassen

Im bestehenden Coding wird für die Tree-Nodes das Abstact-Factory Pattern verwendet. Zudem wird das Interface in der Klasse verwendet, um die Unterklassen weiter zu strukturieren. 

Im Hauptprogramm werden die Unterklassen mit Hilfe des Command-Patterns aufgerufen. Der Zugriff erfolgt über die Interface-Methoden. Die Integration der Klassen ist nicht trivial, so dass erst einmal der Fokus darauf gelegt wird, die Tree-Node-Klassen zu refactoren, um dann ein verbessertes Verständnis vom Coding zu erlangen. 

Zielbild soll hier sein, dass die Zuständigkeiten der Superklasse und Unterklassen sauberer zu erkennen sind. Weiter soll durch Refactoring und Strukturierung der Klassen die Logik besser erschlossen werden. 

Das Refactoring der Klassen erfolgt in TDD, in kleinen Schritten. Die Unterklasse ZCL_TREE_NODE_FLIGHTS wird nicht vollständig refactorisiert. Hier lässt sich noch das Vorgehen des Refactorings, was bei den anderen Klassen analog erfolgte, erahnen. Auch lässt sich in Strukturierung und Naming der Klassen und Methoden weitere Verbesserungen implementieren.

**Endbild nach Refactoring:**

![Step 3](https://github.com/MaddinJay/Certification-AL2/blob/main/2nd%20Task/Bilder/UML%20Third%20Step.JPG)

# Step 4: Einbinden einer Tree-Controller-Klasse

Um die Tree-Klassen und deren Zuständigkeiten weiter besser zu visualisieren wird eine Tree-Controller-Klasse eingebunden. Zudem wird versucht, die Datenbankzugriffe in eine separate DAO-Klasse auszulagern.

Als Tests dienen hierzu die bestehenden UNIT-Tests der Tree-Node-Klassen. Zudem wird der "Golden Master" verwendet, um die Integration der neuen Klasse im Mainflow zu testen.

**Akzeptanzkriterien:**
  - Durch Doppelklick auf Knoten im Baum (Flight Schedules, Flights, Carriers) wird im rechten Screen die Detailliste geöffnet. Inhalt stimmt noch mit Ursprung überein.
  - Alle UNIT-Tests der betroffenen Tree-Node-Klassen sind GRÜN.

**Offene Punkte:**
 - Der Read auf die DB durch den dynamischen Zugriff konnte nicht ausgelagert werden. Hier steht die weitere Analyse noch aus.
 - Das Interface ZIF_DPD_TREE_OBJECT soll langfristig aus der Controller-Klasse entfernt werden. Dies ist zum jetzigen Zeitpunkt nicht möglich, weil die Einbindung in den Mainflow sehr umfangreich ist.  

**Erarbeitete Klassenstruktur nach Refactoring:**

![Step 4](https://github.com/MaddinJay/Certification-AL2/blob/main/2nd%20Task/Bilder/UML%20Fourth%20Step.JPG)

## Step 5: Paketstruktur verbessern

Um den Überblick der eingeführten und refactorten Klassen zu verbessern, wird die Paketstruktur zu den Tree-Node-Klassen nochmals modifiziert. So sind die Zuständigkeiten der einzelnen Klassen im Paketbaum besser zu differenzieren.

**Neue Paketstruktur:**

![Step 5](https://github.com/MaddinJay/Certification-AL2/blob/main/2nd%20Task/Bilder/Image%20Fifth%20Step.JPG)


## Weitere mögliche Steps

Mit jedem gemachten Refactoring-Schritt wird das Verständnis vom Coding verbessert, so dass nach und nach Strukturen zu erkennen sind, die sich verbessern lassen.

Als nächste Schritte wären angedacht:
- Renaming der TREE-Node-Klassen
- Refactoring der ALV-Creator-Klasse, in Hinblick auf die Verwendung des TREE-Node-Objektes
- Einbindung der Tree-Node-Controller-Klasse analysieren und die Integration verbessern. Das Interface zif_dpd_tree_object soll aus der Klasse ZCL_DPD_TREE_NODE_CONTROL langfristig entfernt werden. Prinzipien wie "Tell don't Ask" und SRP im Mainflow könnten Verwendung finden, um die Zuständigkeiten besser zu differenzieren. 
- Am Zielbild, das MVC-Pattern zu integrieren wird festgehalten. Das MVC soll übergreifend im Report verwendet werden. Derzeit fehlt jedoch noch der Überblick, wie dies integriert werden könnte. Weiteres Refactoring ist notwendig, um auch das Zusammenspiel zwischen den einzelnen Klassen noch besser greifen zu können.  

## Reflektion der Arbeit

Das vorgelegte Programm ist auf den ersten Blick sehr unübersichtlich. Durch die Integration der Klassen lokal im Hauptreport und in den globalen Klassen fällt es schwer, die Zusammenhänge der Klassen und deren Funktionen zu verstehen. Anfangs wird viel Zeit dazu verwendet, den Reportablauf und das Zusammenspiel der Klassen zu verstehen.

Um einen Überblick zu erlangen, werden die lokalen Klassen ausgelagert. Dies gibt einen besseren Zugriff auf die Klassen und macht sie schliesslich auch bestestbar. 

Das anfängliche Vorgehen, mit einer Klasse anzufangen und diese zu refactorn, wird wieder verworfen. Zu wenig ist das Verständnis darüber vorhanden, wie die Klassen zusammenspielen. 

Nach erfolgter Auslagerung der lokalen Klassen in globale Klassen lässt sich die erste Struktur der Tree-Node-Klassen erkennen. Da diese Klassen sehr viel "Wissen" beinhalten, wie die Daten gehalten werden, wird der Schwerpunkt der Arbeit auf diese Klassen gelegt. 

Für grösste Refactoring-Massnahmen, wie beispielsweise ein finales MVC-Pattern anzuwenden, erscheint der Report zu mächtig und es fehlt letztendlich auch der Überblick über das Zusammenspiel der einzelnen Klassen.

Die gemachten Loops in der Umsetzung sind hier nicht alle dokumentiert. Es sei erwähnt, dass der Autor der Arbeit sich mit dem Erkennen der einzelnen Steps nicht leicht getan hat. Skizzen und die Visualisierung mit Pen and Paper, was hier nicht weiter dokumentiert wurde, waren ein probates Mittel, um die Strukturen zu erkennen. 

Kritisch ist zu bemerken, dass ggf. doch anfangs mehr Zeit in das Erfassen eines Gesamtbildes investiert hätte werden können. So wäre es sicherlich leichter gefallen, übergeordnete Strukturen besser zu erkennen und daraus ein Design abzuleiten. Auch hätten die Commits ins Git regelmässiger erfolgen dürfen, damit die Steps und die jeweiligen Modifikationen besser ersichtlich wären.

Die hier gemachte Arbeit wird als solide Grundlage für die weiteren Refactoring-Schritte gesehen.
