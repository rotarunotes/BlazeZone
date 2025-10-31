Data: 2025-10-19
[Dart](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/Dart
___
# Variabili
## Var
- È una parola chiave che usi per creare una  variabile senza specificare **esplicitamente** il tipo .
- Il tipo tipo viene deciso una volta dal compilatore e **non** può più **cambiare**.
- È **type-safe**, il compilatore ti aiuta e ti dà errore se provi a cambiarne il tipo.

``` Dart
var nome = "Mario Rossi"; //È come scrivere Sting nome = "Mario Rossi";
nome = "Luigi Verdi"; //Perfettamente valido
// ❌ Errore di compilazione
nome = 100; 
```

## Dynamic
- È una variabile che può contenere **qualsiasi** tipo di dato (String, int, double).
- Il compilatore controllerà il tipo di dato solo a **runtime**.

``` Dart
dynamic valore = 30; 
valore = "trenta"; //Nessun errore, ora contiene una String
valore = true; //Nessun errore, ora contiene un bool
// ❌ Errore a runtime
valore = valore.lenght 
```

___
## Const
- La variabile è una **costante**,  io suo valore è noto in compilazione e non può mai cambiare.

``` Dart
const double PI = 3.14159;
const int SECONDI_IN_UN_MINUTO = 60;
// ❌ Errore di compilazione
const oraAttuale = DateTime.now(); 
```

## Final
- Quando dichiari una variabile final,  le puoi assegnare un valore sono una volta, e dopo la prima assegnazione **non** puoi più **riassegnarlo**.

``` Dart
final listaFinal = [1, 2, 3];
listaFinal.add(4);
// ❌ Errore di esecuzione
listaFinal = [5, 6]),

const listaConst = [1, 2, 3];
// ❌ Errore di complilazione
listaConst.add(4); 
```

## Late
- È una promessa che fai al compilatore, prometti al compilatore di assegnare il valore a questa variabile prima di provare a **leggerla**.
- Errore a runtime.

``` Dart
class Utente {
  late String nome;
}
```

___
# Null
- Le variabili di default non possono essere **null**.
- In Dart, **nullable** significa che una variabile può contenere un valore del suo tipo, oppure può contenere null.
- Il compilatore di Dart ti impedisce di usare **direttamente** le variabili se le ha dichiarate nullable.

``` Dart
// ❌ Errore di complilazione
int valore = null;

int? eta;
eta = 5;
if (eta != null) {
  // Solo dentro questo 'if', Dart sa che 'etaForse' non è null.
  print(eta+2); // OK
}
```

___
# Collezioni
## List
1. **Ordine**: **Sì**, gli elementi rimangono nell'ordine in cui li hai inseriti.
2. **Duplicati**: **Sì**, puoi avere più volte lo stesso valore.
3. **Accesso**: Tramite un **indice** (un numero intero che parte da 0).

``` Dart
List<String> nomi = ["Anna", "Bruno", "Carlo", "Anna"];
// 1. viene aggiutno alla fine
nomi.add("David");
// Output: [Anna, Bruno, Carlo, Anna, David, Bruno]
// 2. Duplicati
nomi.add("Bruno"); // "Bruno" ora è presente due volte
// 3. Si accede tramite l'indice (la posizione)
print("Il primo nome è: ${nomi[0]}"); // Output: Anna
print("Il secondo nome è: ${nomi[1]}"); // Output: Bruno
```

## Set
1. **Ordine**: **No**, non puoi fare affidamento sull'ordine.
2. **Duplicati**: **No**, ogni elemento è unico.
3. **Accesso**: Non tramite indice. Puoi solo chiedere: "Questo elemento è contenuto nel Set?".

``` Dart
Set<String> tags = {"dart", "flutter", "coding"};
// 1. {dart, flutter, mobile} (l'ordine potrebbe variare!)
print(tags); 
// 2. questa riga viene ignorata
tags.add("dart"); // "dart" c'è già, quindi 
// 3. ❌ Errore di complilazione, Non puoi accedere con l'indice
print(tags[0]); // ERRORE!

// L'uso principale è controllare l'esistenza di un valore
bool haIlTagDart = tags.contains("dart"); // Veloce ed efficiente
print("Ha il tag 'dart'? $haIlTagDart"); // Output: true
```

### Set vuoto

``` Dart
var boh = <String>{};
```

## Map
1. **Ordine**: Dipende dall'implementazione (generalmente sì, mantiene l'ordine di inserimento, ma non farci troppo affidamento se non usi **LinkedHashMap**).
2. **Duplicati**: Le **chiavi** devono essere uniche. I **valori** possono essere duplicati.
3. **Accesso**: Tramite la **chiave**.

``` Dart
// Associa una 'String' (nome) a un 'int' (numero di telefono)
Map<String, int> rubrica = {
	"Anna": 1,
	"Bruno": 2,
	"Carlo": 3
};

// 1. // {Anna: 1, Bruno: 2, Carlo: 3, David: 4}
rubrica["David"] = 4;

// 2. "Bruno" esiste già, quindi il suo valore viene sovrascritto
rubrica["Bruno"] = 5; 

// 3. Si accede al valore tramite la chiave
int? numeroDiCarlo = rubrica["Carlo"];
print("Il numero di Carlo è: $numeroDiCarlo"); // Output: 3
// Se la chiave non esiste, restituisce 'null'
int? numeroDiMarco = rubrica["Marco"];
print("Il numero di Marco è: $numeroDiMarco"); // Output: null

```

### Esempio:
``` Dart
// { } in dart sono usate per indicare una collezione di elementi
// in questo caso dart di default lo prende come mappa dynamic, dynamic.
var boh = {};

// È come scrivere
Map<dynamic, dynamic> boh = {};
```

## Iterable
In Dart, un **Iterable** è una collezione di elementi che puoi scorrere in **sequenza**, uno dopo l'altro.

Non ti dà accesso **immediato** a tutti gli elementi (come una List), ma ti permette di "chiederli" uno alla volta.

L'esempio più comune di Iterable è una List.
``` Dart
List<String> nomi = ['Alice', 'Bob', 'Charlie'];
// Puoi usare un loop "for-in", che funziona su tutti gli iterable
for (String nome in nomi) {
  print(nome); // Stampa Alice, poi Bob, poi Charlie
```
}