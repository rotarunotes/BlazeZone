Data: 2026-04-25
[PHP](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/PHP
___
# Index

- [[#Istruzioni Condizionali]]
	- [[#if / else / elseif]]
		- [[#Operatori di Confronto nei Condizionali]]
	- [[#Operatore Ternario]]
	- [[#switch]]
	- [[#match]]
- [[#Cicli]]
	- [[#for]]
		- [[#Struttura del for]]
	- [[#while]]
	- [[#do...while]]
	- [[#foreach]]
		- [[#Iterazione su Array Indicizzato]]
		- [[#Iterazione su Array Associativo (Chiave => Valore)]]
		- [[#Modifica degli Elementi con Riferimento]]
	- [[#Controllo del Flusso nei Cicli]]

___
# Istruzioni Condizionali

Le istruzioni condizionali permettono di eseguire blocchi di codice diversi in base a una condizione.

## if / else / elseif
La struttura base per la gestione del flusso condizionale. La condizione viene valutata come `boolean`: se è `true`, il blocco viene eseguito.

``` PHP
$eta = 20;

if ($eta >= 18) {
    echo "Maggiorenne";
} elseif ($eta >= 13) {
    echo "Adolescente";
} else {
    echo "Minorenne";
}
// Output: Maggiorenne
```
### Operatori di Confronto nei Condizionali

| **Operatore** | **Significato**               | **Esempio**              |
| ------------- | ----------------------------- | ------------------------ |
| `==`          | Uguale per valore             | `5 == "5"` → `true`     |
| `===`         | Uguale per valore **e tipo**  | `5 === "5"` → `false`   |
| `!=`          | Diverso per valore            | `5 != 3` → `true`       |
| `!==`         | Diverso per valore o tipo     | `5 !== "5"` → `true`    |
| `>`           | Maggiore di                   | `10 > 5` → `true`       |
| `<`           | Minore di                     | `3 < 7` → `true`        |
## Operatore Ternario
Una forma compatta dell'`if/else` per assegnare valori in modo conciso.

``` PHP
$punteggio = 75;
$esito = ($punteggio >= 60) ? "Promosso" : "Bocciato";
echo $esito; // Output: Promosso
```

La sintassi è: `condizione ? valore_se_true : valore_se_false`.

## switch
Utilizzato quando si devono confrontare una variabile con **molti valori possibili**. Ogni caso (`case`) viene verificato con confronto **lasco** (`==`). È necessario usare `break` per evitare il **fall-through**, ovvero l'esecuzione involontaria dei casi successivi.

``` PHP
$giorno = "lunedì";

switch ($giorno) {
    case "sabato":
    case "domenica":
        echo "Weekend!";
        break;
    case "lunedì":
        echo "Inizio settimana";
        break;
    case "venerdì":
        echo "Quasi weekend!";
        break;
    default:
        echo "Giorno feriale";
        break;
}
// Output: Inizio settimana
```


> [!note] Nota 
> Più `case` consecutivi senza `break` condividono lo stesso blocco (come `sabato` e `domenica` nell'esempio sopra). 
> Questo è il **fall-through intenzionale**.
## match
Introdotto in PHP 8.0, `match` è simile a `switch` ma più sicuro: usa il confronto **stretto** (`===`) e restituisce direttamente un valore.

``` PHP
$stato = 2;

$messaggio = match($stato) {
    1       => "In attesa",
    2       => "Approvato",
    3       => "Rifiutato",
    default => "Sconosciuto",
};

echo $messaggio; // Output: Approvato
```

| **Caratteristica** | **switch**         | **match**        |
| ------------------ | ------------------ | ---------------- |
| Confronto          | `==` (lasco)       | `===` (stretto)  |
| Restituisce valore | No (usa `break`)   | Sì (espressione) |
| Fall-through       | Sì (senza `break`) | No (automatico)  |

___
# Cicli

I cicli permettono di eseguire un blocco di codice più volte, finché una condizione è soddisfatta.

## for
Usato quando si conosce in anticipo il numero di iterazioni. Composto da tre parti: **inizializzazione**, **condizione** e **incremento**.

``` PHP
for ($i = 0; $i < 5; $i++) {
    echo "Iterazione: $i\n";
}
// Output: Iterazione: 0, 1, 2, 3, 4
```

### Struttura del for

```
for (inizializzazione; condizione; incremento) {
    // Corpo del ciclo
}
```

1. **Inizializzazione**: eseguita una sola volta all'inizio (`$i = 0`).
2. **Condizione**: verificata prima di ogni iterazione; se `false`, il ciclo termina.
3. **Incremento**: eseguito alla fine di ogni iterazione (`$i++`).

## while
Esegue il blocco **finché** la condizione è `true`. La condizione viene verificata **prima** di ogni iterazione: se è subito `false`, il corpo non viene mai eseguito.

``` PHP
$contatore = 1;

while ($contatore <= 3) {
    echo "Valore: $contatore\n";
    $contatore++;
}
// Output: Valore: 1, Valore: 2, Valore: 3
```

## do...while
Simile al `while`, ma la condizione viene verificata **dopo** il corpo. Il blocco viene eseguito **almeno una volta**, indipendentemente dalla condizione.

``` PHP
$numero = 10;

do {
    echo "Eseguito con numero: $numero\n";
    $numero++;
} while ($numero < 5);
// Output: Eseguito con numero: 10
// (il corpo viene eseguito una volta anche se la condizione è falsa)
```

## foreach
Il ciclo più usato per **iterare array** in PHP. Esistono due sintassi: una per gli array indicizzati e una per gli array associativi.

### Iterazione su Array Indicizzato

``` PHP
$frutti = ["mela", "pera", "banana"];

foreach ($frutti as $frutto) {
    echo "$frutto\n";
}
// Output: mela, pera, banana
```

### Iterazione su Array Associativo (Chiave => Valore)

``` PHP
$persona = ["nome" => "Marco", "eta" => 25, "citta" => "Roma"];

foreach ($persona as $chiave => $valore) {
    echo "$chiave: $valore\n";
}
// Output:
// nome: Marco
// eta: 25
// citta: Roma
```

### Modifica degli Elementi con Riferimento
Per modificare gli elementi dell'array direttamente durante il ciclo, si usa il **riferimento** con `&`.

``` PHP
$numeri = [1, 2, 3, 4];

foreach ($numeri as &$n) {
    $n = $n * 2; // Raddoppia ogni elemento
}
unset($n); // Buona pratica: rimuovere il riferimento dopo il ciclo

print_r($numeri);
// Output: Array ( [0] => 2 [1] => 4 [2] => 6 [3] => 8 )
```


> [!Danger] Attenzione
> **Attenzione:** Dopo un `foreach` con riferimento, è sempre buona pratica chiamare `unset($variabile)` per evitare comportamenti inaspettati.

## Controllo del Flusso nei Cicli

All'interno di qualsiasi ciclo si possono usare due istruzioni speciali per controllare il flusso:

| **Istruzione** | **Comportamento**                                              |
| -------------- | -------------------------------------------------------------- |
| `break`        | Interrompe immediatamente il ciclo e ne esce.                  |
| `continue`     | Salta il resto dell'iterazione corrente e passa alla prossima. |

``` PHP
for ($i = 0; $i < 10; $i++) {
    if ($i === 3) continue; // Salta il numero 3
    if ($i === 7) break;    // Esce dal ciclo al numero 7

    echo "$i ";
}
// Output: 0 1 2 4 5 6
```

___
