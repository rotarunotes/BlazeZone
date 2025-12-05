Data: 2025-10-29
[SQL](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Database/SQL
___
# Data Definition Language

Il **DDL** (**Data Definition Language**) è la parte del linguaggio SQL utilizzata per **definire e gestire la struttura** degli oggetti del database (come tabelle, schemi, ecc.). 

| **Tipo**                       | **Esempio**                                              |
| ------------------------------ | -------------------------------------------------------- |
| [[#CREATE DATABASE]]           | `CREATE DATABASE ProgettoFinale;`                        |
| [[#DROP DATABASE]]             | `DROP DATABASE ProgettoFinale;`                          |
| [[#CREATE TABLE]]              | `CREATE TABLE Esami (ID INT, Voto INT, StudenteID INT);` |
| [[#DROP TABLE]]                | `DROP TABLE Esami;`                                      |
| [[#ALTER TABLE ADD COLUMN]]    | `ALTER TABLE Studenti ADD COLUMN Email VARCHAR(100);`    |
| [[#ALTER TABLE DROP COLUMN]]   | `ALTER TABLE Studenti DROP COLUMN Email;`                |
| [[#ALTER TABLE RENAME COLUMN]] | `ALTER TABLE Studenti RENAME COLUMN Età TO Anni;`        |
| [[#ALTER TABLE MODIFY COLUMN]] | `ALTER TABLE Studenti MODIFY COLUMN Nome VARCHAR(50);`   |

**Constraints**

| **Comando**           | **Descrizione**                                                                              |
| :-------------------- | :------------------------------------------------------------------------------------------- |
| [[#NOT NULL]]         | Assicura che una colonna non possa contenere valori `NULL`.                                  |
| [[#UNIQUE]]           | Assicura che tutti i valori in una colonna (o insieme di colonne) siano diversi.             |
| [[#PRIMARY KEY (PK)]] | Identifica in modo univoco ogni riga in una tabella (combinazione di `NOT NULL` e `UNIQUE`). |
| [[#FOREIGN KEY (FK)]] | Collega due tabelle, garantendo l'integrità referenziale.                                    |
| [[#CHECK]]            | Assicura che i valori in una colonna soddisfino una condizione specifica.                    |
| [[#DEFAULT]]          | Fornisce un valore predefinito per una colonna quando non ne viene specificato uno.          |
| [[#CREATE INDEX]]     | Crea un indice per ottimizzare la velocità di recupero dei dati.                             |

# Auto Increment

## Descrizione
In SQL Server, la funzionalità di auto incremento, che di solito è la **chiave primaria (`PRIMARY KEY`)**.

Questa proprietà ha due parametri fondamentali:
1. **seed** (Seme): Il valore iniziale da cui iniziare a contare (es. 1).
2. **increment** (Incremento): Il valore da aggiungere al valore precedente (es. 1, 2, 3...).
La sintassi completa è: **IDENTITY(seed, increment)**
## Esempio in SQL Server
Creiamo una tabella chiamata `Dipendenti` dove la colonna `ID_Dipendente` sarà auto incrementante, partendo da 1 e incrementando di 1.

**Query di Creazione Tabella:**
``` SQL
CREATE TABLE Dipendenti (
    ID_Dipendente INT PRIMARY KEY IDENTITY(1, 1), -- Inizia da 1, incrementa di 1
    Nome VARCHAR(100) NOT NULL,
    Ruolo VARCHAR(50)
);
```

Il vantaggio è che l'ID viene generato automaticamente, garantendo che ogni dipendente abbia un **identificatore univoco** senza il rischio di inserire accidentalmente ID duplicati o nulli.
___
# CREATE DATABASE

**Descrizione:** 
Si usa per **creare** un nuovo database all'interno del sistema di gestione del database (DBMS).

**Query:**

``` SQL
CREATE DATABASE ProgettoFinale;
```

**Risultato:** Viene creato il database vuoto `ProgettoFinale`, pronto per contenere tabelle, viste e altri oggetti.

---

# DROP DATABASE

**Descrizione:** 
Si usa per **eliminare completamente** un intero database dal sistema, inclusi tutti i suoi oggetti (tabelle, dati, indici, ecc.). È un comando **definitivo** e irreversibile.

**Query:**

``` SQL
DROP DATABASE ProgettoFinale;
```

**Risultato:** Il database `ProgettoFinale` e tutti i suoi contenuti sono permanentemente rimossi.

---
# CREATE TABLE

**Descrizione:**

Si usa per creare una nuova tabella nel database, specificando i nomi delle colonne e i tipi di dato.

**Query:**

``` SQL
CREATE TABLE Esami (
    ID INT PRIMARY KEY,
    Voto INT,
    StudenteID INT
);
```

**Risultato:**

| Nome Colonna   | Tipo di Dato | Note            |
| -------------- | ------------ | --------------- |
| **ID**         | `INT`        | Chiave Primaria |
| **Voto**       | `INT`        |                 |
| **StudenteID** | `INT`        |                 |

---

# DROP TABLE

**Descrizione:**

Si usa per eliminare completamente una tabella esistente dal database, inclusi tutti i dati, gli indici e i privilegi associati.

**Query:**

``` SQL
DROP TABLE Esami;
```

Risultato:

La tabella Esami non esiste più nel database.

---

# ALTER TABLE ADD COLUMN

**Descrizione:**

Si usa per aggiungere una nuova colonna a una tabella esistente.

**Tabella Studenti**

| id  | nome | età | corso      |
| --- | ---- | --- | ---------- |
| 1   | Luca | 22  | Matematica |

**Query:**

``` SQL
ALTER TABLE Studenti 
ADD COLUMN Email VARCHAR(100);
```

**Risultato:**

Viene aggiunta la colonna Email alla tabella Studenti. I valori esistenti saranno NULL.

| id  | nome | età | corso      | Email    |
| --- | ---- | --- | ---------- | -------- |
| 1   | Luca | 22  | Matematica | **NULL** |

---

# ALTER TABLE DROP COLUMN

**Descrizione:**

Si usa per rimuovere una colonna da una tabella esistente.

**Tabella Studenti** 

| id  | nome | età | corso      | Email          |
| --- | ---- | --- | ---------- | -------------- |
| 1   | Luca | 22  | Matematica | luca\@email.it |

**Query:**

``` SQL
ALTER TABLE Studenti 
DROP COLUMN Email;
```

**Risultato:**

La colonna Email e tutti i dati in essa contenuti vengono rimossi dalla tabella Studenti.

| id  | nome | età | corso      |
| --- | ---- | --- | ---------- |
| 1   | Luca | 22  | Matematica |

---

# ALTER TABLE RENAME COLUMN

**Descrizione:**

Si usa per rinominare una colonna esistente in una tabella.

**Tabella Studenti** 

| id  | nome | età | corso      |
| --- | ---- | --- | ---------- |
| 1   | Luca | 22  | Matematica |

**Query:**

``` SQL
ALTER TABLE Studenti 
RENAME COLUMN Età TO anni;
```

**Risultato:**

Il nome della colonna viene cambiato da Età a Anni.

| id  | nome | anni | corso      |
| --- | ---- | ---- | ---------- |
| 1   | Luca | 22   | Matematica |

---

# ALTER TABLE MODIFY COLUMN

**Descrizione:**

Si usa per modificare il tipo di dato e/o la dimensione di una colonna esistente.

**Tabella Studenti** 

|**id**|**nome (VARCHAR(50))**|
|---|---|
|1|Luca|

**Query:**

``` SQL
ALTER TABLE Studenti MODIFY COLUMN Nome VARCHAR(100);
```

**Risultato:**

Il tipo di dato della colonna Nome viene modificato da VARCHAR(50) a VARCHAR(100), aumentando la dimensione massima.

---

# Constraints

Sono regole utilizzate per limitare il tipo di dati che può essere inserito in una tabella, assicurando così l'**accuratezza** e l'**affidabilità** (integrità) dei dati.

-----

## NOT NULL

**Descrizione:**
Impedisce che i valori in una colonna siano `NULL` (vuoti). Questo assicura che un dato essenziale sia sempre presente.

**Tabella Studenti**

| id  | nome | corso (NOT NULL) |
| :-- | :--- | :--------------- |
| 1   | Luca | Matematica       |

**Esempio di Creazione:**

```sql
CREATE TABLE Studenti (
    ID INT,
    Nome VARCHAR(100),
    Corso VARCHAR(50) NOT NULL
);
```

**Esempio di Violazione (tentativo di inserimento):**

``` SQL
INSERT INTO Studenti (ID, Nome, Corso) 
VALUES (4, 'Giulia', NULL);

-- Risultato: ERRORE. La colonna 'Corso' non può essere NULL.
```

-----

## UNIQUE

**Descrizione:**
Assicura che tutti i valori in una colonna (o insieme di colonne) siano **univoci** (non duplicati). A differenza della chiave primaria, una colonna `UNIQUE` può contenere un singolo valore `NULL` (tranne che in SQL Server).

**Tabella Docenti**

| id  | nome        | CodiceFiscale (UNIQUE) |
| :-- | :---------- | :--------------------- |
| 1   | Prof. Rossi | RSSGNN80A01H501K       |

**Esempio di Creazione:**

```sql
CREATE TABLE Docenti (
    ID INT,
    Nome VARCHAR(100),
    CodiceFiscale CHAR(16) UNIQUE
);
```

**Esempio di Violazione (tentativo di inserimento):**

```sql
INSERT INTO Docenti (ID, Nome, CodiceFiscale) 
VALUES (2, 'Prof. Verdi', 'RSSGNN80A01H501K');
-- Risultato: ERRORE. Il CodiceFiscale è già presente.
```

-----

## PRIMARY KEY (PK)

**Descrizione:**
Identifica in modo univoco una singola riga (tuple) in una tabella. Una Chiave Primaria non può contenere valori `NULL` (è implicitamente `NOT NULL`) e deve essere **unica**. Ogni tabella può avere **una e una sola** PK.

**Tabella Studenti**

| id (PK) | nome | età |
| :------ | :--- | :-- |
| 1       | Luca | 22  |
| 2       | Anna | 19  |

**Esempio di Creazione:**

```sql
CREATE TABLE Studenti (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Età INT
);
```

**Esempio di Violazione (tentativo di inserimento):**

```sql
INSERT INTO Studenti (ID, Nome) 
VALUES (1, 'Marco');
-- Risultato: ERRORE. L'ID 1 è già utilizzato (violazione di UNIQUE).
```

-----

## FOREIGN KEY (FK)

**Descrizione:**
Stabilisce un collegamento tra due tabelle, referenziando la chiave primaria (`PK`) di un'altra tabella. Assicura l'**integrità referenziale**: non si può inserire un record figlio se non esiste un record padre corrispondente.

**Tabella Esami** (Figlia) **riferisce Studenti** (Padre)

| ID\_Esame | Voto | StudenteID (FK) |
| :-------- | :--- | :-------------- |
| 101       | 30   | 1               |
| 102       | 28   | 2               |

**Esempio di Creazione:**

```sql
CREATE TABLE Esami (
    ID_Esame INT PRIMARY KEY,
    Voto INT,
    StudenteID INT,
    FOREIGN KEY (StudenteID) REFERENCES Studenti(ID)
);
```

**Esempio di Violazione (tentativo di inserimento):**

```sql
INSERT INTO Esami (ID_Esame, Voto, StudenteID) 
VALUES (103, 25, 99);
-- Risultato: ERRORE. Lo StudenteID 99 non esiste nella tabella Studenti.
```

-----

## CHECK

**Descrizione:**
Consente di definire una condizione che tutti i valori in una colonna devono soddisfare.

**Tabella Ordini**

| ID\_Ordine | Prodotto | Quantità |
| :--- | :--- | :--- |
| 500 | Libro | **\> 0** |

**Esempio di Creazione:**

```sql
CREATE TABLE Ordini (
    ID_Ordine INT PRIMARY KEY,
    Prodotto VARCHAR(100),
    Quantità INT CHECK (Quantità > 0)
);
```

**Esempio di Violazione (tentativo di inserimento):**

```sql
INSERT INTO Ordini (ID_Ordine, Prodotto, Quantità) 
VALUES (501, 'Penna', 0);
-- Risultato: ERRORE. La Quantità deve essere maggiore di 0.
```

-----

## DEFAULT

**Descrizione:**
Fornisce un valore che viene assegnato automaticamente a una colonna quando non viene specificato un valore esplicito durante l'inserimento (`INSERT`).

**Tabella Utenti**

| ID | Nome | **Stato (DEFAULT 'Attivo')** |
| :- | :--- | :--- |
| 1 | Luca | Attivo |
| 2 | Anna | (NULL, viene assegnato 'Attivo') |

**Esempio di Creazione:**

```sql
CREATE TABLE Utenti (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Stato VARCHAR(50) DEFAULT 'Attivo'
);
```

**Esempio di Utilizzo (inserimento senza specificare Stato):**

```sql
INSERT INTO Utenti (ID, Nome) 
VALUES (2, 'Anna');
-- Risultato: Viene inserita una riga e la colonna 'Stato' prende il valore 'Attivo'.
```

-----

## CREATE INDEX

**Descrizione:**
Crea un **indice** su una o più colonne di una tabella, proprio come l'indice di un libro. Serve a velocizzare le operazioni di ricerca (`SELECT`), filtro (`WHERE`) e unione (`JOIN`), in quanto il DBMS non deve scansionare l'intera tabella. Gli indici sono creati automaticamente per `PRIMARY KEY` e `UNIQUE`.

**Tabella Studenti**

| id | nome | **età (Index per ricerche veloci)** |
| :- | :--- | :- |
| 1 | Luca | 22 |

**Esempio di Creazione:**

```sql
CREATE INDEX idx_età_studenti
ON Studenti (Età);
```

**Risultato:**
Viene creato un indice sulla colonna `Età` della tabella `Studenti`. Le query che filtrano o ordinano per `Età` saranno più veloci.

-----