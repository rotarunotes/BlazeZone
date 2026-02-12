Data: 2026-02-11
[JS](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/JS
___
# Index

- [[#Funzioni]]
- [[#Dichiarazione e Parametri]]
- [[#Funzioni come Dati (Linguaggio Funzionale)]]
- [[#Passaggio per Valore vs Riferimento]]
- [[#Callback]]

---
# Funzioni
Le funzioni non richiedono la specifica del tipo di ritorno o dei parametri. Se una funzione non ha un'istruzione `return`, restituisce automaticamente `undefined`.
# Dichiarazione e Parametri
1. **No Overloading**: Non si possono definire più funzioni con lo stesso nome ma parametri diversi. L'ultima definizione sovrascrive le precedenti.
2. **Parametri di Default**: È possibile assegnare un valore predefinito ai parametri.
3. **Undefined**: Se passi `undefined` a una funzione, JS lo ignora e usa il valore di default. Se passi `null`, JS considererà `null` come valore e **non** userà il default.

``` JavaScript
function fun3(a, b = 0) {
    console.log(a + "," + b);
}

fun3(2);          // Output: 2, 0 (usa il default)
fun3(2, "ciao");  // Output: 2, "ciao"
fun3(2, undefined); // Output: 2, 0 (undefined attiva il default)
```

___
# Funzioni come Dati (Linguaggio Funzionale)

Le funzioni sono "oggetti di prima classe": possono essere assegnate a variabili, passate come argomenti o restituite.
- **Anonime**: Funzioni senza nome assegnate a variabili.
- **Arrow Functions**: Sintassi contratta `(param) => espressione`.
- **Backticks**: Uso di `` `Ciao ${nome}` `` per inserire variabili nelle stringhe (Template Literals).

``` JavaScript
// Funzione anonima
let saluta = function(nome) {
    return `Ciao ${nome}!`;
};
// Si usa richiamando la variabile come se fosse la funzione
console.log(saluta("Luca")); // Output: Ciao Luca!

// Arrow function per il calcolo rapido
let cubo = (n) => n * n * n;
// Passare funzione come parametro
function esecutore(funzione, valore) {
    return funzione(valore);
}
console.log(esecutore(cubo, 3)); // 27

//Backticks
// MODO CLASSICO (Scomodo e facile sbagliare gli spazi) 
let messaggio1 = "Ciao " + nome + ", hai " + articoli + " oggetti nel carrello."; // MODO CON BACKTICK: Si usa ${} per racchiudere la variabile o l'operazione 
let messaggio2 = `Ciao ${nome}, hai ${articoli} oggetti nel carrello.`;
```

___
# Passaggio per Valore vs Riferimento
JavaScript si comporta diversamente a seconda del tipo di dato passato alla funzione:
1. **Per Valore**: Primitivi (`Number`, `String`, `Boolean`). La funzione lavora su una copia, l'originale non cambia.
2. **Per Riferimento**: Oggetti e Array. La funzione lavora sull'indirizzo di memoria, le modifiche influenzano l'originale.

``` JavaScript
let n = 1;
let v = [1, 2];

function prova(num, arr) {
    num += 100;    // Non cambia n fuori
    arr[0] += 100; // Cambia v[0] fuori!
}
```

___
# Callback

Una **callback** è una funzione passata come argomento a un'altra funzione, per essere poi "richiamata" (eseguita) all'interno di quest'ultima.
1. **Modularità**: Permette di decidere cosa fare con un dato solo al momento della chiamata.
2. **Asincronia**: È il metodo principale per gestire operazioni che richiedono tempo (come il caricamento di un file o un timer).
3. **Sintassi**: Si passa solo il nome della funzione (senza parentesi `()`), altrimenti verrebbe eseguita immediatamente.

``` javascript
// Esempio 1: Una funzione che accetta una call back
function elaboraDati(valore, callback) {
    console.log("Elaborazione in corso...");
    let risultato = valore * 2;
    // Eseguo la funzione che mi è stata passata
    callback(risultato);
}

// Esempio 2: Uso una funzione anonima (molto comune)
elaboraDati(5, function(res) {
    console.log(`Risultato anonimo: ${res}`);
});

// Esempio 3: Callback asincrona con setTimeout
setTimeout(() => {
    console.log("Eseguito dopo 2 secondi");
}, 2000);
```

---

