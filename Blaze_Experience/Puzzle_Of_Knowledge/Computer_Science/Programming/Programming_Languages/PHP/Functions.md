Data: 2026-03-05
[PHP](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/PHP
___
# Index

- [[#Definizione e Ritorno]]
- [[#Passaggio dei Parametri]]
- [[#Parametri di Default e Named Arguments]]
- [[#Tipizzazione Esplicita (Type Hinting)]]
- [[#Scope delle Variabili (Global)]]
- [[#Funzioni Built-in (Math & Date)]]
	- [[#Funzioni Matematiche]]
	- [[#Gestione Date e Tempo]]

___
# Definizione e Ritorno

In PHP le funzioni si dichiarano con la parola chiave `function`. Essendo un linguaggio dinamico, non è obbligatorio specificare i tipi.

- **Void**: Una funzione che non restituisce nulla (o usa `return;`).
- **Return**: Restituisce un valore al chiamante.

``` PHP
function fun2($c) {
    return $c; 
}
```

___
# Passaggio dei Parametri

Di default, in PHP il passaggio dei parametri avviene **per valore** per tutti i tipi (inclusi stringhe e array). Le modifiche effettuate dentro la funzione non influenzano le variabili originali.

- **Per Valore**: Viene creata una copia del dato.
- **Per Riferimento (`&`)**: Usando il simbolo `&` prima del parametro, la funzione lavora sulla variabile originale del main.

``` PHP
function fun3(&$int) { // Passaggio per riferimento
    $int += 1000;
}
```

___
# Parametri di Default e Named Arguments

È possibile rendere facoltativi alcuni parametri assegnando loro un valore di default.
- I parametri obbligatori vanno messi sempre **prima** di quelli facoltativi.
- **Named Arguments**: Permettono di passare un valore a un parametro specifico saltando gli altri.

``` PHP
function fun4($a, $b = 2, $c = 3) { ... }

fun4(1);          // $b=2, $c=3
fun4(1, c: 100);  // $b=2, $c=100 (Named Argument)
```

___
# Tipizzazione Esplicita (Type Hinting)

Nelle versioni moderne di PHP è **possibile** (e consigliato) definire i tipi dei parametri e del valore restituito.

- `?Type`: Indica che il valore può essere del tipo specificato oppure `null`.
- `: type`: Specifica il tipo di ritorno dopo la parentesi tonda.

``` PHP
function fun6(int $a, float $b, ?bool $c, array $v): string {
    return "ciao";
}
```

___
# Scope delle Variabili (Global)

Le variabili definite fuori dalle funzioni non sono visibili all'interno di esse a meno che non si usi la parola chiave `global`.

``` PHP
$h = 10;
function fun7() {
    $h = 1; // Locale
    global $h; // Ora si riferisce alla variabile esterna (10)
}
```

---
# Funzioni Built-in (Math & Date)

## Funzioni Matematiche
- `rand(min, max)`: Numero casuale (estremi inclusi).
- `sqrt($n)`: Radice quadrata.
- `floor($n)`: Arrotondamento per difetto (troncamento).
- `round($n, $prec)`: Arrotondamento con precisione decimale.
- `pow($b, $e)`: Potenza.

## Gestione Date e Tempo
PHP gestisce il tempo tramite **Timestamp** (secondi trascorsi dal 01/01/1970).

- `time()`: Timestamp attuale.
- `mktime(h, m, s, M, D, Y)`: Crea un timestamp per una data specifica.
- `date('d-m-Y H:i:s', $timestamp)`: Formatta un timestamp in una stringa leggibile.
- `checkdate(m, d, y)`: Verifica se una data è valida (es. 29 febbraio in anni non bisestili).

``` PHP
// Esempio data corrente formattata
echo date('d/m/Y'); // Es: 05/03/2026
```

---
