Data: 2025-10-29
[Database](../README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Database/SQL
___
# Structured Query Laguage
**SQL** è un linguaggio utilizzato per creare, gestire e interrogare i **Database** relazionali.  
Serve per lavorare con **tabelle** di dati (creazione, inserimento, ricerca, aggiornamento, eliminazione).

## Categorie principali di comandi SQL

I comandi SQL si dividono in **cinque gruppi fondamentali**:

| Categoria | Scopo             | Comandi principali      |
| --------- | ----------------- | ----------------------- |
| **DDL**   | Struttura del DB  | CREATE, ALTER, DROP     |
| **DML**   | Gestione dei dati | INSERT, UPDATE, DELETE  |
| **DCL**   | Interrogazioni    | SELECT, WHERE, ORDER BY |
| **TCL**   | Sicurezza         | GRANT, REVOKE           |
| **DQL**   | Transazioni       | COMMIT, ROLLBACK        |

---
___
# Indice
- [DDL](DDL.md)
- [DML](DML.md)
- [DQL](DQL.md)
- [TCL](TCL.md)
- [QCL](QCL.md)

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


---

## 🔐 4️⃣ DCL – Data Control Language

Serve per **gestire i permessi e la sicurezza** del database.

| Comando | Funzione | Esempio |
|----------|-----------|----------|
| `GRANT` | Concede permessi a un utente | `GRANT SELECT ON studenti TO 'mario'@'localhost';` |
| `REVOKE` | Revoca permessi | `REVOKE SELECT ON studenti FROM 'mario'@'localhost';` |

---

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


