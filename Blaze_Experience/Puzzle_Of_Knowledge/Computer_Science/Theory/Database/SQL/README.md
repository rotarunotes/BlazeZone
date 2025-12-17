 Data: 2025-10-29
[Database](../README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Database/SQL
___
# Structured Query Language
**SQL** è un linguaggio utilizzato per creare, gestire e interrogare i **Database** relazionali.  
Serve per lavorare con **tabelle** di dati (creazione, inserimento, ricerca, aggiornamento, eliminazione).

### manca like e le join

# Indice

| **Categoria** | **Comandi Chiave**           | **Azione Principale**                                     |
| ------------- | ---------------------------- | --------------------------------------------------------- |
| [DCL](DCL.md) | `GRANT`, `REVOKE`            | **Controlla accessi** (Concede o revoca permessi)         |
| [DML](DML.md) | `INSERT`, `UPDATE`, `DELETE` | **Manipola dati** (Aggiunge, modifica, elimina record)    |
| [DDL](DDL.md) | `CREATE`, `ALTER`, `DROP`    | **Definisce struttura** (Crea, modifica, elimina tabelle) |
| [TCL](TCL.md) | `COMMIT`, `ROLLBACK`         | **Gestisce transazioni** (Salva o annulla operazioni DML) |
| [DQL](DQL.md) | `SELECT`                     | **Recupera dati** (Interrogazione)                        |

- [[#Funzioni di aggregazione]]
- [[#Operator logici]]
- [[#DISTINCT & ALL]]
## Funzioni di aggregazione

| Funzione  | Descrizione    | Esempio                             |
| --------- | -------------- | ----------------------------------- |
| `COUNT()` | Conta i record | `SELECT COUNT(*) FROM studenti;`    |
| `SUM()`   | Somma valori   | `SELECT SUM(prezzo) FROM prodotti;` |
| `AVG()`   | Media          | `SELECT AVG(eta) FROM studenti;`    |
| `MIN()`   | Valore minimo  | `SELECT MIN(prezzo) FROM prodotti;` |
| `MAX()`   | Valore massimo | `SELECT MAX(prezzo) FROM prodotti;` |

## Operator logici

| Operatore   | Descrizione                          | Esempio di utilizzo                   |
| ----------- | ------------------------------------ | ------------------------------------- |
| `AND`       | Operatore logico "E"                 | `WHERE età > 18 AND stipendio > 2000` |
| `OR`        | Operatore logico "O"                 | `WHERE età > 18 OR stipendio > 2000`  |
| `NOT`       | Operatore logico "NON"               | `WHERE NOT (età > 18)`                |
| `LIKE`      | Ricerche parziali                    | `WHERE nome LIKE 'Mar%'`              |
| `IN`        | Controllo su un elenco di valori     | `WHERE classe IN ('1A','2B')`         |
| `BETWEEN`   | Controllo su un intervallo di valori | `WHERE prezzo BETWEEN 100 AND 500`    |
| `<`         | Minore di                            | `WHERE età < 30`                      |
| `>`         | Maggiore di                          | `WHERE prezzo > 100`                  |
| `<=`        | Minore o uguale a                    | `WHERE età <= 30`                     |
| `>=`        | Maggiore o uguale a                  | `WHERE prezzo >= 100`                 |
| `=`         | Uguale a                             | `WHERE nome = 'Mario'`                |
| `<>` o `!=` | Diverso da                           | `WHERE nome <> 'Mario'`               |

## DISTINCT & ALL
**DISTINCT**  si usa per eliminare le righe duplicate dato che  di default esistono duplicati nel database.
``` SQL
SELECT DISTINCT residenza
FROM impiegati
WHERE residenza='Torino';
```

**ALL** è impostato di default  e seleziona anche i duplicati
``` SQL
SELECT ALL residenza
FROM impiegati
WHERE residenza='Torino';
```

## Alias
Quando voglio assegnare Assegno un nuovo nome ad un attributo tramite un ALIAS:
- Indico  il nome vecchio AS il nome nuovo da assegnare 

``` SQL
SELECT id AS matricola, nome, cognome
FROM impiegati;
```

Posso creare una nuova colonna (attributo) a cui gli assegno un alias che è il risultato di una espressione (in questo caso risultato double)

``` sql
SELECT cognome, nome, 
	stipendio AS stipendio_attuale, 
	stipendio*1.05 AS nuovo_stipendio  
FROM impiegati;
```

Posso anche dare un nuovo nome con un alias ad un tabella. Posso usare quell'alias in SELECT e in WHERE per indicare quella tabella

``` SQL
SELECT I.cognome,I.nome,D.descrizione
FROM impiegati AS I, dipartimenti AS D
WHERE (I.dipartimento=D.codice) AND (D.sede='Roma');
```
___
## LIMIT
Questa funzione di permette di limitare il numero di righe in output della tua query

``` SQL
SELECT prodotto_id, prezzo 
FROM prodotti 
ORDER BY prodotto_id 
LIMIT 3;
```

**Risultato:**

| prodotto_id | prezzo |
| ----------- | ------ |
| aaa         | 10     |
| bbb         | 20     |
| ccc         | 30     |
