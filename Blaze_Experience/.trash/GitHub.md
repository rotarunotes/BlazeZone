# Flutter Z-Keep (DB)

Una versione evoluta dell'app TodoList ispirata a Google Keep. Gestisce più liste organizzate in card dinamiche con persistenza dei dati su database locale.

## 1) Struttura Widget Tree

```
MyApp (MaterialApp)
└── ChangeNotifierProvider.value (TodoListNotifier)
    └── MyHomePage (Scaffold)
        ├── AppBar
        ├── Body (MasonryGridView)
        │   └── CardManage (Card)
        │       └── ListView.builder
        │           └── todoItem
        │               ├── Checkbox
        │               └── editableTextField (TextField / Text)
        └── FloatingActionButton (Aggiungi Card)
```

## 2) Persistenza con Sqflite

L'app utilizza un database locale SQLite per non perdere i dati alla chiusura:

- **DatabaseHelper**: Gestisce l'apertura (`init`), la creazione delle tabelle (`cards` e `todos`) e le operazioni CRUD (Create, Read, Update, Delete).
- **Relazione 1-N**: Ogni card nel database è collegata ai propri todo tramite una chiave esterna (`card_id`) con eliminazione a cascata.
- **Async Main**: Il `main` è asincrono per inizializzare il database prima dell'avvio dell'interfaccia.
- 

## 3) State Management (Notifier Pattern)

Il **TodoListNotifier** centralizza la logica di business e la sincronizzazione col database:

- **Inizializzazione**: Carica le card esistenti o ne crea una vuota se il DB è nuovo.
- **Metodi Database**: Gestisce il salvataggio automatico quando un todo viene modificato, smarcato o eliminato.
- **Provider**:
    - `context.watch<TodoListNotifier>()`: Usato nel `build` per ridisegnare la UI quando la lista cambia.
    - `context.read<TodoListNotifier>()`: Usato nelle callback (come il salvataggio alla perdita del focus) per agire sul notifier senza ricostruzioni inutili.

## 4) Logica del "Last Todo"

Ogni card contiene un elemento speciale chiamato **"Last Todo"**:

- Non viene mai salvato nel database (proprietà `last: true`).
- Funge da pulsante "rapido" per aggiungere nuove righe alla card.
- Al click, si trasforma in un todo reale, riceve un ID dal database e genera un nuovo "Last Todo" sotto di sé.

## 5) Focus & Editing Dinamico

**editableTextField** gestisce l'esperienza di scrittura:

- **Autofocus**: Quando un todo entra in modalità edit, il cursore appare automaticamente.
- **Loss of Focus**: Grazie a `onTapOutside` e `FocusNode`, il testo viene salvato automaticamente nel database non appena l'utente tocca un'altra parte dello schermo.
- **Modalità Mobile**: Utilizza `Future.microtask` per evitare conflitti durante la ricostruzione dei widget su Android/iOS.
    

## 6) Gesti e Azioni

- **Tap su Todo**: Entra in modalità modifica.
- **Checkbox**: Segna come completato. Se è il primo elemento a essere completato in una card, la card viene archiviata/eliminata (logica di pulizia).
- **Long Press**: Elimina definitivamente il singolo todo.
- **FAB (Add)**: Crea una nuova card vuota nella griglia principale.
    
---

### Note Tecniche Fondamentali

> **WidgetsFlutterBinding.ensureInitialized()**: Inserito nel `main` perché è obbligatorio quando si eseguono chiamate asincrone (come l'apertura del database) prima della funzione `runApp()`.
> 
> **ChangeNotifierProvider.value**: Utilizzato per passare un'istanza del notifier già inizializzata nel `main` a tutto l'albero dei widget.

Vorresti che approfondissi la sezione relativa alla configurazione del database per Android/iOS?