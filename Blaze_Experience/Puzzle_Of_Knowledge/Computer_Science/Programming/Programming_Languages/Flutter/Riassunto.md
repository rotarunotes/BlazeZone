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
	- classe del wigget stessa
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

Ecco la spiegazione dettagliata riga per riga:

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
 