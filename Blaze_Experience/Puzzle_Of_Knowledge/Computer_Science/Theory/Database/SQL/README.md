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
## Funzioni di aggregazione

| Funzione  | Descrizione    | Esempio                             |
| --------- | -------------- | ----------------------------------- |
| `COUNT()` | Conta i record | `SELECT COUNT(*) FROM studenti;`    |
| `SUM()`   | Somma valori   | `SELECT SUM(prezzo) FROM prodotti;` |
| `AVG()`   | Media          | `SELECT AVG(eta) FROM studenti;`    |
| `MIN()`   | Valore minimo  | `SELECT MIN(prezzo) FROM prodotti;` |
| `MAX()`   | Valore massimo | `SELECT MAX(prezzo) FROM prodotti;` |

## Operator logici

|Operatore|Descrizione|Esempio di utilizzo|
|---|---|---|
|`AND`|Operatore logico "E"|`WHERE età > 18 AND stipendio > 2000`|
|`OR`|Operatore logico "O"|`WHERE età > 18 OR stipendio > 2000`|
|`NOT`|Operatore logico "NON"|`WHERE NOT (età > 18)`|
|`LIKE`|Ricerche parziali|`WHERE nome LIKE 'Mar%'`|
|`IN`|Controllo su un elenco di valori|`WHERE classe IN ('1A','2B')`|
|`BETWEEN`|Controllo su un intervallo di valori|`WHERE prezzo BETWEEN 100 AND 500`|
|`<`|Minore di|`WHERE età < 30`|
|`>`|Maggiore di|`WHERE prezzo > 100`|
|`<=`|Minore o uguale a|`WHERE età <= 30`|
|`>=`|Maggiore o uguale a|`WHERE prezzo >= 100`|
|`=`|Uguale a|`WHERE nome = 'Mario'`|
|`<>` o `!=`|Diverso da|`WHERE nome <> 'Mario'`|

---

## 🧩 1️⃣ DDL – Data Definition Language

Serve per **creare o modificare la struttura del database**.

| Comando    | Funzione                                       | Esempio                                    |
| ---------- | ---------------------------------------------- | ------------------------------------------ |
| `CREATE`   | Crea una tabella o database                    | `CREATE TABLE studenti (...);`             |
| `ALTER`    | Modifica una tabella esistente                 | `ALTER TABLE studenti ADD email CHAR(50);` |
| `DROP`     | Elimina una tabella o database                 | `DROP TABLE studenti;`                     |
| `RENAME`   | Rinomina una tabella                           | `RENAME TABLE studenti TO alunni;`         |
| `TRUNCATE` | Cancella tutti i dati ma mantiene la struttura | `TRUNCATE TABLE studenti;`                 |

---

## 💾 2️⃣ DML – Data Manipulation Language

Serve per **inserire, aggiornare o cancellare i dati** dentro le tabelle.

| Comando | Funzione | Esempio |
|----------|-----------|----------|
| `INSERT INTO` | Inserisce nuovi record | `INSERT INTO studenti (id, nome) VALUES (1, 'Mario');` |
| `UPDATE` | Modifica dati esistenti | `UPDATE studenti SET nome='Luca' WHERE id=1;` |
| `DELETE` | Elimina record | `DELETE FROM studenti WHERE id=1;` |

---
## DQL
## 🔁 5️⃣ TCL – Transaction Control Language

Serve per **gestire le transazioni**.

| Comando | Funzione | Esempio |
|----------|-----------|----------|
| `COMMIT` | Conferma definitivamente le modifiche | `COMMIT;` |
| `ROLLBACK` | Annulla le modifiche non confermate | `ROLLBACK;` |
| `SAVEPOINT` | Imposta un punto di ripristino | `SAVEPOINT punto1;` |


---


