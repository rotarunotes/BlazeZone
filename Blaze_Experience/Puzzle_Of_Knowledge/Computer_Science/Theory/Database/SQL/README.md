Data: 2025-10-29
[Database](../README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Database/SQL
___
# Index
- [[#Database]]
- [[#Structured Query Language]]
- [[#DBMS]]
	- [[#DBMS NoSQL]]
- [[#Tipi Di Dati]]
- [[#Funzioni di aggregazione]]
- [[#Operator logici]]
- [[#DISTINCT & ALL]]
- [[#Alias]]
- [[#LIMIT]]
- [[#Query Annidate]]
- [[#Indice]]
![[#Indice]]
___
# Structured Query Language
**SQL** è il linguaggio standard per interagire con i **database relazionali**.
Serve per lavorare con **tabelle** di dati, e permette su di esse di eseguire il **CRUD**, ovvero le 4 operazioni fondamentali per la gestione dei dati in sistemi di archiviazione persistenti.
- **Create**: Inserimento di dati.
- **Read**: Recupero e visualizzazione dei dati esistenti.
- **Update**: Modifica di dati già presenti nel database.
- **Delete**: Rimozione di dati dal database.

Viene definito linguaggio di **4^ generazione**, ovvero non si scrivono istruzioni da eseguire ma si fanno **richieste**.
# DBMS
**Database Management System** è il software che gestisce fisicamente il database: 
- Si occupa di memorizzare i dati.
- Eseguire le query.
- Gestire gli accessi concorrenti. 
- Garantire la durabilità.
Tutti supportano SQL standard, ma ciascuno ha estensioni e comportamenti proprietari.

> [!Abstract]
> - **SQL**: È la lingua che parli (il linguaggio).
> - **DBMS**: È l'interprete o il bibliotecario che riceve i tuoi ordini e organizza i libri.
> - **Database**: È la biblioteca (insieme fisico dei dati).

**DBMS Relazionali (SQL)**: 
- MySQL
- MariaDB
- PostgreSQL
- SQLite
- SQL Server
- Oracle
## DBMS NoSQL
Indica una famiglia di database che **non usano** il modello relazionale a tabelle, ma salvano dati in modo **differente** (Es: JSON).
Nascono per rispondere a esigenze che i DBMS tradizionali gestiscono con **difficoltà**:
- Enormi volumi di dati.
- Alta scalabilità orizzontale.
- Schemi flessibili.
- Dati non strutturati.
  
**DBMS Non relazionali (No SQL):**
- MongoDB
- Redis
  
# Tipi Di Dati
Prima di creare tabelle, è fondamentale conoscere i tipi di dato disponibili.

| **Categoria**  | **Tipo**           | **Descrizione**                               | **Esempio**               |
| -------------- | ------------------ | --------------------------------------------- | ------------------------- |
| **Numerici**   | `INT`              | Intero standard                               | `42`                      |
|                | `BIGINT`           | Intero molto grande                           | `9000000000`              |
|                | `DECIMAL(p,s)`     | Decimale preciso (p cifre totali, s decimali) | `DECIMAL(10,2)` → `12.50` |
|                | `FLOAT` / `DOUBLE` | Virgola mobile, meno preciso                  | `3.14159`                 |
| **Testo**      | `VARCHAR(n)`       | Stringa variabile fino a n caratteri          | `VARCHAR(100)`            |
|                | `CHAR(n)`          | Stringa a lunghezza fissa                     | `CHAR(2)` → `'IT'`        |
|                | `TEXT`             | Testo lungo senza limite pratico              | descrizioni, articoli     |
| **Date e ore** | `DATE`             | Solo data                                     | `2024-03-15`              |
|                | `TIME`             | Solo ora                                      | `14:30:00`                |
|                | `DATETIME`         | Data e ora, nessun fuso orario                | `2024-03-15 14:30:00`     |
|                | `TIMESTAMP`        | Data e ora, tiene il fuso orario, si aggiorna | `2024-03-15 14:30:00`     |
| **Altri**      | `BOOLEAN`          | Vero/falso (in MySQL è `TINYINT(1)`)          | `TRUE` / `FALSE`          |
|                | `ENUM(...)`        | Solo valori da una lista predefinita          | `ENUM('S','M','L','XL')`  |
|                | `JSON`             | Dati semi-strutturati                         | `{"nome": "Mario"}`       |

___
# Funzioni di aggregazione

| Funzione  | Descrizione    | Esempio                             |
| --------- | -------------- | ----------------------------------- |
| `COUNT()` | Conta i record | `SELECT COUNT(*) FROM studenti;`    |
| `SUM()`   | Somma valori   | `SELECT SUM(prezzo) FROM prodotti;` |
| `AVG()`   | Media          | `SELECT AVG(eta) FROM studenti;`    |
| `MIN()`   | Valore minimo  | `SELECT MIN(prezzo) FROM prodotti;` |
| `MAX()`   | Valore massimo | `SELECT MAX(prezzo) FROM prodotti;` |
___
# Operator logici

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
___
# DISTINCT & ALL
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

___
# Alias
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
# LIMIT
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
___
# Query Annidate

**Studenti:**

| **ID Studente** | **Nome e Cognome** | **Matematica** | **Italiano** | **Inglese** | **Media Voti** |
| --------------- | ------------------ | -------------- | ------------ | ----------- | -------------- |
| 001             | Mario Rossi        | 8              | 7            | 9           | 8.0            |
| 002             | Giulia Bianchi     | 9              | 9            | 8           | 8.6            |
| 003             | Luca Verdi         | 6              | 7            | 6           | 6.3            |
| 004             | Elena Neri         | 10             | 8            | 9           | 9.0            |
| 005             | Marco Gialli       | 5              | 6            | 7           | 6.0            |


-- sottoquery (che genera 1 valore) dopo condizione >  
``` SQL
SELECT ID_Studente, Nome_Cognome, Matematica
FROM Studenti
WHERE Matematica > (
	SELECT AVG(Matematica) 
	FROM Studenti
);
```
  
-- sottoquery (che genera 1 valore) dopo condizione =  
``` SQL
SELECT ID_Studente, Nome_Cognome, Matematica
FROM Studenti
WHERE Matematica = (
	SELECT MAX(Matematica
	) 
FROM Studenti
);
```
  
-- sottoquery (che genera un insieme di valori) dopo IN  
``` SQL
SELECT ID_Studente, Nome_Cognome
FROM Studenti
WHERE ID_Studente IN (
	SELECT ID_Studente 
	FROM Studenti 
	WHERE Matematica = 10 OR Italiano = 10
);
```
  
-- sottoquery (che genera un insieme di valori) dopo NOT IN  
``` SQL
SELECT Code, Name  
FROM country  
WHERE Code NOT IN (
	SELECT CountryCode 
	FROM countrylanguage
);    
```
  
-- sottoquery (che genera un insieme di valori) dopo > ANY  
``` SQL
SELECT Code, Name, Continent, Region  
FROM country  
WHERE Population > ANY (
	SELECT AVG(Population) 
	FROM country
)  
```
  
-- sottoquery (che genera un insieme di valori) dopo < ALL  
``` SQL
SELECT Code, Name, Continent, Region  
FROM country  
WHERE Population < ALL (
	SELECT AVG(Population) 
	FROM country
)
```
___
# Indice

| Categoria     | Acronimo                     | Comandi Chiave               | Azione Principale                                         |
| ------------- | ---------------------------- | ---------------------------- | --------------------------------------------------------- |
| [DQL](DQL.md) | Data Query Language          | `SELECT`                     | **Recupera dati** (Interrogazione)                        |
| [DML](DML.md) | Data Manipulation Language   | `INSERT`, `UPDATE`, `DELETE` | **Manipola dati** (Aggiunge, modifica, elimina record)    |
| [DDL](DDL.md) | Data Definition Language     | `CREATE`, `ALTER`, `DROP`    | **Definisce struttura** (Crea, modifica, elimina tabelle) |
| [DCL](DCL.md) | Data Control Language        | `GRANT`, `REVOKE`            | **Controlla accessi** (Concede o revoca permessi)         |
| [TCL](TCL.md) | Transaction Control Language | `COMMIT`, `ROLLBACK`         | **Gestisce transazioni** (Salva o annulla operazioni DML) |
___