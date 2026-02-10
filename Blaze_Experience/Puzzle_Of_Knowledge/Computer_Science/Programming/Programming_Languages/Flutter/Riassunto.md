Data: 2026-01-19
[](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/Flutter
___
# StatelessWidget (senza stato)
- è immutabile
- si usa per parti dell'interfaccia che non cambiano mai
# StatefulWidget (dinamico)
- cambia il suo aspetto, input dall'utente......
- ha due classi:
	- classe del widget stessa
	- una classe state
- setState() restituisce la parte dell'interfaccia interessata
	- il setState() viene chiamato quando modifichi una variabile che influisce su ciò che vedrà l'utente
	- puoi usare setState solo nella classe state


# ChangeNotifierProvider
Esempio:
``` dart
home: ChangeNotifierProvider<TodoListNotifier>(  
  create: (notifier) => TodoListNotifier(),  
  child: const MyHomePage(title: 'Todo List'),  
),
```
Questo è un widget speciale fornito dal pacchetto Provider. Il suo compito è duplice
- **Crea e mantiene in memoria** un'istanza della tua classe `TodoListNotifier`.
- **Diffonde i dati** a tutti i widget sottostanti (i suoi "figli").
  
Questo blocco di codice è il cuore della gestione dei dati (lo "Stato") della tua applicazione. Utilizza il pacchetto **Provider**, che è uno dei sistemi standard in Flutter per far comunicare i dati con l'interfaccia senza dover passare variabili manualmente da un widget all'altro.



# Costruttore classe annidata
``` Dart
class TodoItem extends StatelessWidget {  
  final Todo todo;
  TodoItem({required this.todo}) : super(key: ObjectKey(todo));
}
```

2) `: super(...)` I due punti `:` introducono la **lista di inizializzazione**.
	- **`super`** si riferisce alla classe da cui `TodoItem` eredita, ovvero `StatelessWidget`.
	- In pratica, stai dicendo a Flutter: "Ehi, prima di costruire `TodoItem`, configura la classe base `StatelessWidget` usando questi parametri".

 3) `key: ObjectKey(todo)`: Ogni widget in Flutter può avere una `key` (una chiave) che aiuta il framework a identificare in modo univoco quel widget all'interno dell'albero dei widget (Widget Tree).

# TextStyle
**Un oggetto `TextStyle`**: contenente le istruzioni di formattazione (colore, decorazione).

# Card
La classe **Card**  È essenzialmente un pannello con angoli leggermente arrotondati e un'ombreggiatura (elevazione) che lo fa apparire sollevato rispetto alla superficie sottostante.

| **Tipo**     | **Costruttore**   | **Descrizione**                                                    |
| ------------ | ----------------- | ------------------------------------------------------------------ |
| **Elevated** | `Card()`          | La versione classica con ombra (default).                          |
| **Filled**   | `Card.filled()`   | Una versione con un colore di sfondo pieno ma senza ombra marcata. |
| **Outlined** | `Card.outlined()` | Una versione con un bordo sottile e senza ombra.                   |
Per personalizzare l'aspetto della tua `Card`, puoi usare queste proprietà comuni: 
- **`child`**: Il widget contenuto all'interno della scheda (spesso un `ListTile` o una `Column`).
- **`elevation`**: Definisce quanto la scheda "si alza" dallo sfondo, controllando la dimensione dell'ombra.
- **`color`**: Imposta il colore di sfondo della scheda.
- **`shape`**: Permette di cambiare la forma (es. angoli più o meno arrotondati).
- **`margin`**: Lo spazio vuoto che circonda la scheda per separarla dagli altri elementi.

# with
``` Dart
import 'package:flutter/widgets.dart';

import 'model.dart';

class TodoListNotifier with ChangeNotifier {


}

```

In Dart, la parola chiave **`with`** viene utilizzata per applicare un **Mixin** a una classe.
## 1) Cos'è un Mixin?

Un mixin è un modo per riutilizzare il codice di una classe in più gerarchie di classi diverse. È come aggiungere un "pacchetto di abilità" alla tua classe.

è analogo a una sottoclasse solo che non funziona ad oggetti ma è una semplice contenitore di attributi e metodi.

___
# onFocus


---

### 1) ChangeNotifierProvider

Questo è un widget speciale fornito dal pacchetto Provider. Il suo compito è duplice:

- **Crea e mantiene in memoria** un'istanza della tua classe `TodoListNotifier`.
    
- **Diffonde i dati** a tutti i widget sottostanti (i suoi "figli").
    

### 2) create: (context) => TodoListNotifier()

Questa funzione viene eseguita **una sola volta** quando l'app viene avviata.

- Qui stai dicendo a Flutter: "Crea l'oggetto che contiene la lista dei miei Todo".
    
- `TodoListNotifier` è la classe dove probabilmente hai definito la lista e i metodi come `addTodo`.
    
- Essendo un `ChangeNotifier`, ha la capacità di inviare "notifiche" quando i dati cambiano.
    

### 3) child: const MyHomePage(...)

Qui definisci chi può accedere a quei dati.

- Poiché `MyHomePage` è figlio di `ChangeNotifierProvider`, lui (e tutti i widget dentro di lui, come la `ListView`) potrà "ascoltare" il notifier.
    
- È come se avessi creato una **nuvola di dati** sopra `MyHomePage`: qualsiasi widget all'interno di quella nuvola può allungare la mano e prendere i dati del Todo.
___
# Titolo 2
___
 