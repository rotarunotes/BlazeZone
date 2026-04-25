,Data: 2026-03-05
[PHP](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Programming/Programming_Languages/PHP
___
# Index
- [[#Connessione al Database]]
	- [[#Parametri di connessione]]
- [[#Esecuzione di Query (SELECT)]]
- [[#Gestione dei Risultati]]
	- [[#Conteggio righe]]
	- [[#Recupero dei dati (Fetch)]]
- [[#Chiusura della Connessione]]
- [[#Riepilogo Funzioni Principali]]

___
# Connessione al Database

Per interagire con un database MySQL si utilizza la funzione `mysqli_connect()`.
## Parametri di connessione
La funzione richiede quattro parametri stringa:
1. **Host**: Indirizzo del server (es. `localhost`).
2. **User**: Nome utente del database (es. `root`).
3. **Password**: Password dell'utente (spesso vuota `""` in locale).
4. **Database**: Nome del database specifico (es. `5id`).

``` PHP
$conn = mysqli_connect("localhost", "root", "", "5id");

// Verifica della connessione
if($conn === false){
    exit("Errore: " . mysqli_connect_error());
}
echo "Connesso: " . mysqli_get_host_info($conn);
```

___
# Esecuzione di Query (SELECT)

Una volta stabilita la connessione, si inviano i comandi SQL tramite `mysqli_query()`.

``` PHP
$sql = "SELECT * FROM dipendenti WHERE codice='aaaa'";
$result = mysqli_query($conn, $sql);

// Controllo errori di sintassi SQL
if($result === false) {
    exit("Errore nella query: " . mysqli_error($conn));
}
```

___
# Gestione dei Risultati

L'esecuzione di una query `SELECT` restituisce un oggetto "result set".
## Conteggio righe
 restituisce il numero di record trovati. È utile per verificare l'esistenza di un dato (es. login o controllo duplicati).
 
``` PHP
mysqli_num_rows($result)
```
## Recupero dei dati (Fetch)
Per leggere i dati riga per riga, si usa un ciclo `while` combinato con `mysqli_fetch_array()`.

``` PHP
// Ciclo per scorrere tutti i risultati
while ($row = mysqli_fetch_array($result)) {
    echo $row['codice'] . ' ' . $row['nome']; // Accesso tramite chiave associativa
}
```

- **`mysqli_fetch_array($result)`**: Estrae la riga corrente e sposta il puntatore alla successiva. Restituisce `false` quando non ci sono più righe.

___
# Chiusura della Connessione

È buona norma chiudere sempre la connessione al database al termine dello script per liberare risorse sul server.

``` PHP
mysqli_close($conn);
```

___
# Riepilogo Funzioni Principali

| **Funzione**             | **Scopo**                                                               |
| ------------------------ | ----------------------------------------------------------------------- |
| `mysqli_connect()`       | Apre una nuova connessione al server MySQL.                             |
| `mysqli_connect_error()` | Restituisce il messaggio d'errore dell'ultimo tentativo di connessione. |
| `mysqli_query()`         | Esegue una query sul database.                                          |
| `mysqli_num_rows()`      | Restituisce il numero di righe presenti nel risultato.                  |
| `mysqli_fetch_array()`   | Recupera una riga di risultato come array associativo o numerico.       |
| `mysqli_error()`         | Restituisce la descrizione dell'ultimo errore SQL avvenuto.             |

___
