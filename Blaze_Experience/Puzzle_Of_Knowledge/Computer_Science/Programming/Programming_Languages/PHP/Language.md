Data: 2026-03-05
[PHP](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/PHP
___
# Index

- [[#echo]]
	- [[#Funzionamento base]]
	- [[#Caratteristiche Principali]]
	- [[#Comportamento con le Variabili]]
	- [[#Flusso dei Dati (Server-to-Client)]]
	- [[#Differenza con `print`]]
- [[#Variabili e Tipi Primitivi]]
	- [[#Casting e Dinamismo]]
	- [[#Operazioni di Casting]]
- [[#Stringhe e Operatori]]
	- [[#Apici Singoli vs Doppi]]
	- [[#Operatori Principali]]
- [[#Collezioni (Array)]]
	- [[#Array Indexati]]
	- [[#Array Associativi (Chiave/Valore)]]
	- [[#Superglobali e Stato]]
- [[#JSON e Integrazione]]
- [[#Utility di Controllo]]
	- [[#isset()]]
	- [[#is_type()]]

___
# echo

È il comando principale per inviare dati in output dal server al browser del client. 
Sebbene tecnicamente non sia una funzione ma un **costrutto del linguaggio**, viene usata per visualizzare testo, variabili e codice HTML.

## Funzionamento base
`echo` prende una o più stringhe e le inserisce direttamente nel corpo della risposta HTTP che il server invia al browser.

``` PHP
echo "Ciao Mondo!"; 
// Il server invia "Ciao Mondo!" al browser, che lo visualizza.
```

## Caratteristiche Principali
- **Output multipli:** Puoi passare più argomenti separati da virgola (leggermente più veloce della concatenazione con il punto).
- **Interpretazione HTML:** Se scrivi tag HTML dentro `echo`, il browser li interpreterà come tali.

``` PHP
echo "<h1>Titolo</h1>", "<p>Paragrafo</p>";
```

## Comportamento con le Variabili
Il modo in cui `echo` gestisce le variabili dipende dal tipo di apici utilizzati:
- **Apici Doppi (`" "`):** PHP analizza la stringa e sostituisce il nome della variabile con il suo valore (Interpolazione).  
- **Apici Singoli (`' '`):** PHP tratta tutto come testo puro, stampando letteralmente il nome della variabile.
 
``` PHP
$nome = "Luca";
echo "Ciao $nome"; // Output: Ciao Luca
echo 'Ciao $nome'; // Output: Ciao $nome
```

## Flusso dei Dati (Server-to-Client)
È importante capire dove si colloca `echo` nel ciclo di vita di una richiesta web:
1. Il Client richiede una pagina `.php`.
2. Il Server esegue il codice PHP.  
3. Ogni istruzione `echo` scrive dati nel "buffer" di uscita.
4. Il Server invia il risultato finale (HTML/Testo) al Client.

## Differenza con `print`
`echo` e `print` sono molto simili, ma con due differenze tecniche:
1. **Velocità:** `echo` è leggermente più veloce perché non restituisce alcun valore.
2. **Valore di ritorno:** `print` restituisce sempre `1`, quindi può essere usato all'interno di espressioni complesse, mentre `echo` no.

---
# Variabili e Tipi Primitivi

Le variabili in PHP iniziano sempre con il simbolo `$`. Il linguaggio è **case-sensitive** sui nomi delle variabili.

- **Integer**: Numeri interi (es. `12`).
- **Double**: Numeri decimali (es. `15.5`).
- **Boolean**: Valori `true` o `false`.
- **String**: Sequenze di caratteri.
- **Null**: Rappresenta l'assenza di valore.

``` PHP
$n = 12;          // Integer
$prezzo = 15.5;   // Double
$is_valid = false; // Boolean
$v = null;        // Null

// Output e Debug
echo gettype($n);    // "integer"
var_dump($variabile);// Informazioni complete (tipo + valore)
```

## Casting e Dinamismo
PHP è un linguaggio a **tipizzazione dinamica**, il tipo di una variabile cambia automaticamente in base al valore assegnato.

## Operazioni di Casting
È possibile forzare la conversione tra tipi:
- `(int)`: Converte in intero (es. `(int) 5.8` diventa `5`).
- `(double)`: Converte in decimale.
- `(string)`: Converte in stringa.

``` PHP
echo (int) (5/2); // Output: 2 (divisione intera)
```

___
# Stringhe e Operatori

## Apici Singoli vs Doppi
- **Apici Singoli (' ')**: Il contenuto è trattato come testo puro.
- **Apici Doppi (" ")**: Permettono l'**interpolazione** delle variabili e l'uso di caratteri speciali (es. `\n`).

``` PHP
$nome = "Daniele";
echo 'Ciao $nome'; // Output: Ciao $nome
echo "Ciao $nome"; // Output: Ciao Daniele
```

## Operatori Principali

- **Concatenazione**: Si usa il punto `.` (es. `"a" . "b"`).
- **Aritmetici**: `+`, `-`, `*`, `/`, `%` (resto), `**` (potenza).
- **Confronto**: `==` (valore), `===` (valore e tipo), `!=`, `<`, `>`, `<=`, `>=`.

___
# Collezioni (Array)
In PHP gli array possono comportarsi sia come liste indicizzate che come mappe (array associativi).
## Array Indexati

``` PHP
$v1 = ["ciao", 12, "hello"];
$v1[] = 100; // Aggiunge 100 alla fine dell'array
echo count($v1); // Restituisce la lunghezza
```
## Array Associativi (Chiave/Valore)

``` PHP
$persona = ["nome" => "Marco", "cognome" => "Rossi"];
print_r($persona);
/* Risultato: Array ( [nome] => Marco [cognome] => Rossi ) */

echo $persona["nome"]; // "Marco"
$persona = ["nome" => "Marco", "eta" => 25]; 

print_r(array_keys($persona));   // Estrae le chiavi
print_r(array_values($persona)); // Estrae i valori
unset($persona["cf"]);           // Rimuove un elemento
```

|**Funzione**|**Scopo**|**Dettaglio**|
|---|---|---|
|`echo`|Output finale per l'utente|Minimo (solo testo)|
|`print_r`|Debug rapido e leggibile|Medio (chiavi e valori)|
|`var_dump`|Debug tecnico profondo|**Massimo** (tipi, lunghezze e valori)|
## Superglobali e Stato
PHP utilizza array associativi speciali chiamati **Superglobali** per gestire le comunicazioni HTTP:

|**Variabile**|**Descrizione**|
|---|---|
|`$_GET`|Dati passati nell'URL (`?chiave=valore`). Visibili all'utente.|
|`$_POST`|Dati passati nel body della richiesta. Nascosti e più sicuri.|
|`$_REQUEST`|Contiene sia i dati di GET che di POST.|
|`$_SESSION`|Memorizza dati lato server per mantenere lo stato tra più pagine.|
___
# JSON e Integrazione

Per comunicare con il client (Frontend JavaScript), PHP trasforma i dati in formato JSON.
- `json_encode($data)`: Converte un array/oggetto PHP in stringa JSON.
- `json_decode($json, true)`: Converte una stringa JSON in un array associativo PHP.

``` PHP
$json_string = json_encode($persone);
echo $json_string; // Invia i dati al client
```

___
# Utility di Controllo

## isset()
La funzione `isset()` è fondamentale per la sicurezza: restituisce `true` solo se la variabile è stata definita e **non è null**.

``` PHP
if (isset($_GET["nome"])) {
    echo "Il nome è: " . $_GET["nome"];
}
```
## is_type()
- `is_int()`: Verifica se è un intero.
- `is_double()`: Verifica se è un double.
- `is_string()`: Verifica se è una stringa.

---