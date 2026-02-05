Data: 2026-02-05
[JS](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/JS
___
# Index
- [[#If]]
    - [[#Operatori Logici]]
    - [[#Operatore Ternario]]
- [[#Switch]]
    
- [[#Cicli]]
    
    - [[#For]]
        
    - [[#For-of]]
        
    - [[#While]]
        
    - [[#Do-While]]
        
- [[#Break e Continue]]


___
# If
``` JavaScript
let nome = 'Luca';

if (nome == 'Luca') {
    console.log('ciao luca');
} else if (nome == 'Marco') {
    console.log('ciao marco');
} else {
    console.log('ciao anonimo');
}
```

## Operatori Logici
- `&&` **(AND)**: Tutte le condizioni devono essere vere.
- `||` **(OR)**: Almeno una condizione deve essere vera.
- `!` **(NOT)**: Inverte il valore booleano.
- `==` **Uguaglianza debole**
``` javascript
console.log(5 == "5");  // true (La stringa "5" viene convertita in numero 5)
console.log(1 == true); // true (Il booleano true viene convertito in 1)
console.log(0 == false);// true (Il booleano false viene convertito in 0)
```
- `===` **Uguaglianza stretta**
``` javascript
console.log(5 === "5");  // false (Perché Number è diverso da String)
console.log(1 === true); // false (Perché Number è diverso da Boolean)
console.log(5 === 5);    // true  (Stesso valore, stesso tipo)
```

## Operatore Ternario
Una scorciatoia per l'istruzione `if-else` su una singola riga.

``` JavaScript
let numero2 = 15;
// condizione ? valore_se_vero : valore_se_falso
let nome2 = (numero2 < 20) ? "Luca" : "Leonardo"; 
```

---
# Cicli

## For

``` JavaScript
let array = [22, 13, 34, 56, 99];

for (let i = 0; i < array.length; i++) {
    console.log('Indice ' + i + ': ' + array[i]);
}
```

## For-of

``` JavaScript
let lista = [1, 2, 4]
for (let valore of lista) {
    console.log('Valore: ' + valore);
}
```

## While

``` JavaScript
let lista = [1, 2, 4]
let i = 0;
while (i < lista.length) {
    console.log('while: ', array[i]);
    i++;
}
```

## Do-While

``` JavaScript
let k = 0;
do {
    console.log('Eseguito almeno una volta: ', array[k]);
    k++;
} while (k < array.length);
```

---
# Break e Continue

1. `break`: Esci immediatamente dal ciclo.
2. `continue`: Salta il resto del codice nel giro attuale e passa direttamente alla prossima iterazione.

``` JavaScript
for (let n of array) {
    if (n % 2 == 0) continue; // Salta i numeri pari
    if (n > 100) break;       // Ferma tutto se supera 100
    console.log(n);           // Stampa solo i dispari minori di 100
}
```
___
# Switch

``` JavaScript
switch(nome) {
    case 'luca':
        console.log('Ciao Luca');
        break; // Impedisce di eseguire i casi successivi
    case 'Gino':
        console.log('Ciao Gina');
        break;
    default:
        console.log('non so il tuo nome');
}
```