 Data: 2025-10-29
[Database](../README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Database/SQL
___
# Structured Query Language
**SQL** è un linguaggio utilizzato per creare, gestire e interrogare i **Database** relazionali.  
Serve per lavorare con **tabelle** di dati (creazione, inserimento, ricerca, aggiornamento, eliminazione).

___
# Indice
- [DDL](DDL.md)
- [DML](DML.md)
- [DCL](DCL.md)
- [TCL](TCL.md)
- [DQL](DQL.md)

___
## Categorie principali di comandi SQL

I comandi SQL si dividono in **cinque gruppi fondamentali**:

|**Categoria**|**Acronimo**|**Scopo**|**Comandi principali**|
|---|---|---|---|
|**DDL**|Data Definition Language|Definizione della struttura del database (tabelle, schemi, vincoli)|`CREATE`, `ALTER`, `DROP`|
|**DML**|Data Manipulation Language|Gestione e modifica dei dati nelle tabelle|`INSERT`, `UPDATE`, `DELETE`|
|**DQL**|Data Query Language|Interrogazione dei dati|`SELECT`, `WHERE`, `ORDER BY`|
|**DCL**|Data Control Language|Controllo degli accessi e dei permessi|`GRANT`, `REVOKE`|
|**TCL**|Transaction Control Language|Gestione delle transazioni|`COMMIT`, `ROLLBACK`, `SAVEPOINT`|

---

## 🧩 1️⃣ DDL – Data Definition Language

Serve per **creare o modificare la struttura del database**.

| Comando | Funzione | Esempio |
|----------|-----------|----------|
| `CREATE` | Crea una tabella o database | `CREATE TABLE studenti (...);` |
| `ALTER` | Modifica una tabella esistente | `ALTER TABLE studenti ADD email CHAR(50);` |
| `DROP` | Elimina una tabella o database | `DROP TABLE studenti;` |
| `RENAME` | Rinomina una tabella | `RENAME TABLE studenti TO alunni;` |
| `TRUNCATE` | Cancella tutti i dati ma mantiene la struttura | `TRUNCATE TABLE studenti;` |

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

## 🧮 Funzioni e operatori comuni in SQL

### 🔸 Funzioni di aggregazione

| Funzione | Descrizione | Esempio |
|-----------|--------------|----------|
| `COUNT()` | Conta i record | `SELECT COUNT(*) FROM studenti;` |
| `SUM()` | Somma valori | `SELECT SUM(prezzo) FROM prodotti;` |
| `AVG()` | Media | `SELECT AVG(eta) FROM studenti;` |
| `MIN()` | Valore minimo | `SELECT MIN(prezzo) FROM prodotti;` |
| `MAX()` | Valore massimo | `SELECT MAX(prezzo) FROM prodotti;` |

### 🔸 Operator logici
- `AND`, `OR`, `NOT`  
- `LIKE` → ricerche parziali (`WHERE nome LIKE 'Mar%'`)  
- `IN` → elenchi (`WHERE classe IN ('1A','2B')`)  
- `BETWEEN` → intervalli (`WHERE prezzo BETWEEN 100 AND 500`)  

---


