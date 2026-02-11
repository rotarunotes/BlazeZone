Data: 2026-02-05
[JS](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/JS
___
# Index
- [[#Variabili]]
    - [[#Tipo Primitivi]]
    - [[#Let]]
    - [[#Var]]
    - [[#Const]]
- [[#Collezioni]]
    - [[#Lista]]
        - [[#Modifica (Mutano l'originale)]]
        - [[#Metodi di Ricerca e Verifica]]    
        - [[#Metodi di Trasformazione]]        
        - [[#Metodi di Iterazione e Utility]]  
    - [[#Map]]
        - [[#Proprietà e Iterazione]]
        - [[#Metodi Principali (CRUD)]]
- [[#Oggetto]]
    - [[#Creazione e Lettura]]
    - [[#Aggiungere e Modificare]]
    - [[#Metodi "Sblocca-Dati"]]
    - [[#Symbol]]
    - [[#Scomposizione Rapida (Destructuring)]]

___
# Variabili
## Tipo Primitivi
- **Number**: Rappresenta sia numeri interi che decimali. Include anche valori speciali come `Infinity` e `NaN` (Not a Number).
- **String**: Sequenze di caratteri racchiuse tra apici (`' '`, `" "`, o backtick `` ` ` ``).
- **Boolean**: Può essere solo `true` o `false`.
- **Undefined**: Il valore di una variabile che è stata dichiarata ma a cui non è ancora stato assegnato un valore.
- **Null**: Rappresenta l'assenza intenzionale di qualsiasi valore. È un valore "vuoto" assegnato apposta.
- **BigInt**: Usato per numeri interi troppo grandi per il tipo Number standard (si scrive aggiungendo una `n` alla fine, es: `100n`).
- **Symbol**: Un identificatore unico e immutabile, spesso usato come chiave per le proprietà degli oggetti.

``` javascript
let anni = 25;              // Number
let nome = "Alice";         // String
let cambiato = true;        // Boolean
let x;                      // Undefined
let y = null;               // Null
let numeroGigante = 9007n;  // BigInt


let sym1 = Symbol("id");
let sym2 = Symbol("id");
console.log(sym1 === sym2); // Output: false


								 //OUTPUT
console.log(typeof 42);          // "number"
console.log(typeof "Ciao");      // "string"
console.log(typeof true);        // "boolean"
console.log(typeof undefined);   // "undefined"
console.log(typeof {a:1});       // "object"
console.log(typeof [1,2]);       // "object" (Attenzione: gli array sono oggetti!)
console.log(typeof null);        // "object" (Questo è un bug storico di JS, ma è rimasto così)
```

## Let
- Dichiarazione di variabili con **scope locale**.
- Può assumere qualsiasi valore primitivo
- Il valore può essere riassegnato, ma la variabile non può essere ridichiarata nello stesso blocco.
- **Moderno**: È lo standard consigliato per variabili che devono cambiare.

``` JavaScript
let nome = "Mario";
nome = "Luigi"; ✅ // Valido
let nome = "Mattia" // ❌ Errore: locale non è definita qui fuori

function gg(){
  let locale = "Segreto";
}
// ❌ Errore: locale non è definita qui fuori
console.log(locale); 
```
## Var
- Ha **scope globale** (non di blocco).
- **Hosting**:
	- Quando dichiari una variabile con `var`, la **dichiarazione** viene portata in alto, ma l'**assegnazione** rimane dove l'hai scritta. Questo significa che puoi accedere alla variabile prima di averla dichiarata senza che il programma vada in crash, ma il suo valore sarà `undefined`.
	
``` javascript
console.log(nome); // Output: undefined (NON dà errore)
var nome = "Mario";
console.log(nome); // Output: "Mario"
```

- Può essere ridichiarata senza errori.
  
``` JavaScript
var x = 10;
var x = 20; // ✅ Nessun errore (pericoloso!)

if (true) {
  var globale = "Sono ovunque";
}
console.log(globale); // ✅ Stampa anche fuori dall'if
```
## Const
- Come `let`, ha scope di blocco, ma il valore **non può essere riassegnato**.
- **Nota**: Se contiene un oggetto o un array, il contenuto può essere modificato, ma non il riferimento alla variabile stessa.

``` JavaScript
const PI = 3.14;
// ❌ Errore: Assignment to constant variable
PI = 4; 

const lista = [1, 2];
lista.push(3); // ✅ Valido: modifichi il contenuto
// ❌ Errore: lista = [4];
```

---
# Collezioni

## Lista
1. **Ordine**: **Sì**, mantiene l'ordine di inserimento.
2. **Duplicati**: **Sì**, ammette valori identici.
3. **Accesso**: Tramite **indice** (parte da 0).
###  Modifica (Mutano l'originale
1. `push()`: Aggiunge in coda.
2. `pop()`: Rimuove dall'ultimo.
3. `unshift()`: Aggiunge dal primo.
4. `sort()`: Ordina gli elementi.
5. `reverse()`: Inverte l'ordine.
6. `splice()`: Rimuove o sostituisce elementi in qualsiasi posizione.

``` JavaScript
let nomi = ["Anna", "Luca"];

nomi.push("Marco");        // ["Anna", "Luca", "Marco"]
nomi.pop();                // ["Anna", "Luca"]
nomi.unshift("Sara");      // ["Sara", "Anna", "Luca"]
nomi.shift();              // ["Anna", "Luca"]

let numeri = [3, 1, 2];
numeri.sort();             // [1, 2, 3]
numeri.reverse();          // [3, 2, 1]

let colori = ["Rosso", "Verde", "Blu"];
colori.splice(1, 1, "Giallo"); // Parte dall'indice 1, toglie 1 elemento, mette "Giallo"
// Risultato: ["Rosso", "Giallo", "Blu"]
```

### Metodi di Ricerca e Verifica
1. `indexOf()`: Trova la prima posizione di un elemento.
2. `lastIndexOf()`: Trova l'ultima posizione di un elemento.
3. `includes()`: Verifica se un elemento esiste (ritorna true/false).
4. `find()`: Trova il primo elemento che soddisfa una condizione.
5. `findIndex()`: Trova l'indice del primo elemento che soddisfa una condizione.
6. `every()`: Controlla se **tutti** gli elementi soddisfano una condizione.
7. `some()`: Controlla se **almeno uno** soddisfa una condizione.

``` JavaScript
let frutti = ["Mela", "Pera", "Mela"];

frutti.indexOf("Mela");      // 0
frutti.lastIndexOf("Mela");  // 2
frutti.includes("Banana");   // false

let voti = [15, 22, 18, 28];
let promosso = voti.find(v => v >= 18);      // 22
let indiceVoto = voti.findIndex(v => v >= 18); // 1

let tuttiSufficienti = voti.every(v => v >= 18); // false
let qualcunoSufficiente = voti.some(v => v >= 18); // true
```

### Metodi di Trasformazione (Creano nuovi Array)
1. `map()`: Crea un nuovo array trasformando ogni elemento.
2. `filter()`: Crea un nuovo array filtrando solo certi elementi.
3. `reduce()`: Accumula tutti i valori in un unico risultato finale.
4. `concat()`: Unisce due array.
5. `slice()`: Taglia una porzione di array.

``` JavaScript
let base = [1, 2, 3, 4];
// MAP: moltiplica tutto per 10
let decine = base.map(n => n * 10); // [10, 20, 30, 40]
// FILTER: prendi solo i numeri pari
let pari = base.filter(n => n % 2 === 0); // [2, 4]
// REDUCE: somma tutto (acc è l'accumulatore, n il numero corrente)
let somma = base.reduce((acc, n) => acc + n, 0); // 10
// SLICE: prendi dal secondo al terzo (escluso)
let porzione = base.slice(1, 3); // [2, 3]
```

### Metodi di Iterazione e Utility
1. `forEach()`: Esegue una funzione per ogni elemento (non restituisce nulla).
2. `join()`: Trasforma l'array in una stringa.
3. `flat()`: "Appiattisce" array annidati (es: [[1,2], 3] -> [1,2,3]).

``` JavaScript
let città = ["Roma", "Milano"];
// FOREACH
città.forEach(c => console.log("Città: " + c));
// JOIN
let testo = città.join(" - "); // "Roma - Milano"
// FLAT
let caos = [1, [2, 3], 4];
let pulito = caos.flat(); // [1, 2, 3, 4]
```

## Map
1. **Chiavi**: Può usare **qualsiasi valore** come chiave (anche oggetti o funzioni), a differenza degli oggetti standard.
2. **Ordine**: Mantiene l'ordine di inserimento degli elementi.

``` JavaScript
const rubrica = new Map();
rubrica.set("Anna", 123);
console.log(rubrica.get("Anna")); // Output: 123
```

### Proprietà e Iterazione
A **differenza** degli oggetti comuni, la Map ha una proprietà dedicata per la lunghezza e metodi pronti per i cicli.

### Metodi Principali (CRUD)
1. `set(chiave, valore)`: Aggiunge o aggiorna un elemento. Restituisce la mappa stessa (permette il chaining).
2. `get(chiave)`: Restituisce il valore associato alla chiave. Se non esiste, restituisce `undefined`.
3. `has(chiave)`: Restituisce `true` se la chiave esiste nella mappa.
4. `delete(chiave)`: Rimuove l'elemento associato alla chiave. Restituisce `true` se l'elemento esisteva.
5. `clear()`: Rimuove tutti gli elementi dalla mappa.
6. `size`: Proprietà che restituisce il numero di elementi (molto più comoda di `Object.keys(obj).length`).
7. `keys()`: Restituisce un iteratore con tutte le chiavi.
8. `values()`: Restituisce un iteratore con tutti i valori.

``` JavaScript
const mappa = new Map();
// SET
mappa.set("id", 1);
mappa.set(true, "bool"); // Chiave booleana!
const obj = { a: 1 };
mappa.set(obj, "oggetto"); // Chiave oggetto!
// GET
console.log(mappa.get("id")); // 1
console.log(mappa.get(obj));  // "oggetto"
// HAS
console.log(mappa.has(true)); // true
// DELETE
mappa.delete("id"); // Rimuove id: 1
// CLEAR
mappa.clear(); // Svuota tutto

const shop = new Map([
  ["mela", 0.5],
  ["pera", 0.8]
]);
//SIZE
console.log(shop.size); // 2
// KEYS
const listaChiavi = console.log([...shop.keys()]); // ["mela", "pera"]
// VALUES
const listaPrezzi = [...shop.values()]; // [0.5, 0.8, 1.2]
```

---
# Oggetto
- In JavaScript, l'oggetto è una collezione di coppie **chiave: valore**.
- Le chiavi sono solitamente stringhe o simboli.
- È la struttura fondamentale per rappresentare dati complessi.

## Creazione e Lettura
1. `Object.keys(cane).length`: Lunghezza dell'oggetto
``` JavaScript
const cane = {
  nome: "Bau",
  zampe: 4,
  abbaia: function() { console.log("Woof!"); }
};

// Come leggere i dati
console.log(cane.nome);  // Punto: facile e veloce
console.log(cane["nome"]); // Quadre: utile se il nome è in una variabile
const lunghezza = Object.keys(cane).length; //Output: 3
```

## Aggiungere e Modificare

``` JavaScript
cane.colore = "Marrone"; // Aggiunto
cane.zampe = 3;          // Modificato
```

## Metodi "Sblocca-Dati"
Da oggetto a lista:
1. `Object.keys(obj)`: Prende solo i **nomi** (le chiavi).
2. `Object.values(obj)`: Prende solo i **contenuti** (i valori).
3. `Object.entries(obj)`: Prende **tutto** a coppie.

``` JavaScript
const auto = { marca: "Fiat", anno: 2020 };

Object.keys(auto);   // ["marca", "anno"]
Object.values(auto); // ["Fiat", 2020]
Object.entries(auto); // [ [marca, Fiat], [anno, 2020] ]
```

## Symbol
Una variabile che funziona da chiave 
``` JavaScript
const SEGRETO = Symbol("id");

let utente = { nome: "Ali" };
utente[SEGRETO] = 999;

console.log(utente[SEGRETO]); // 999
console.log(Object.keys(utente)); // ["nome"] -> Il segreto non si vede!
```

## Scomposizione Rapida (Destructuring)

``` JavaScript
const film = { titolo: "Inception", regista: "Nolan", anno: 2010 };

// Prendo solo titolo e anno
const { titolo, anno } = film;

console.log(titolo); // "Inception"
console.log(anno); // "2010"
```

---