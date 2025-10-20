Data: 2025-10-17
[Programming_Languages](Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/Dart
___
# Dart
Dart è un **linguaggio di programmazione moderno**, open source e orientato agli oggetti, **creato da Google**.

È nato nel 2011 con l'obiettivo di essere un'alternativa a JavaScript per lo sviluppo web, ma oggi è conosciuto principalmente come il linguaggio che alimenta **Flutter**, il framework di Google per creare interfacce utente (UI).

**Event Loop**: Il motore di Dart. Immaginalo come  un gestore di compiti  che segue in un singolo thread.
Le operazioni asincrone  vengono eseguite in background. Al loro completamento, un "evento" viene messo nella **event queue**. L'**event loop** preleva e gestisce questi eventi non appena il thread principale è libero.

**Codice Sincrono**
- Bloccante
- Esegue un' istruzione alla volta, in **ordine**. la riga 2 non può iniziare finchè la riga 1 non ha finito.
**Codice Asincrono**
- Non Bloccante
- Si tratta di compiti la cui esecuzione viene "schedulata" per il futuro. Vengono messi in attesa nell' **event queue** e gestiti dall'**event loop** solo quando il thread principale è libero.
___
# Indice
- [Data](Data.md)
- [Function](Function.md)
- [Class](Class.md)
- [Future](Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/Dart/Future.md)
___

 