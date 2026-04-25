Data: 2025-10-29
[SQL](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Database/SQL
___
# Index
- [[#Data Definition Language]]
- [[#Gestione del Database]]
	- [[#CREATE DATABASE]]
	- [[#DROP DATABASE]]
	- [[#Gestione delle Tabelle]]
	- [[#CREATE TABLE]]
	- [[#DROP TABLE]]
- [[#Modifica delle Tabelle (ALTER TABLE)]]
	- [[#ADD COLUMN]]
	- [[#DROP COLUMN]]
	- [[#RENAME COLUMN]]
	- [[#MODIFY COLUMN]]
- [[#Constraints (Vincoli)]]
	- [[#NOT NULL]]
	- [[#UNIQUE]]
	- [[#PRIMARY KEY (PK)]]
	- [[#FOREIGN KEY (FK)]]
		- [[#Azioni Referenziali (ON DELETE / ON UPDATE)]]
			- [[#CASCADE]]
			- [[#SET NULL]]
			- [[#RESTRICT / NO ACTION]]
			- [[#SET DEFAULT]]
				- [[#Riepilogo Azioni Referenziali]]
	- [[#CHECK]]
	- [[#DEFAULT]]
		- [[#Riepilogo Constraints]]
- [[#Indici (CREATE INDEX)]]

| Comando                     | Descrizione                                  |
| :-------------------------- | :------------------------------------------- |
| `CREATE DATABASE`           | Crea un nuovo database                       |
| `DROP DATABASE`             | Elimina un database e tutto il suo contenuto |
| `CREATE TABLE`              | Crea una nuova tabella                       |
| `DROP TABLE`                | Elimina una tabella e tutti i suoi dati      |
| `ALTER TABLE ADD COLUMN`    | Aggiunge una colonna a una tabella esistente |
| `ALTER TABLE DROP COLUMN`   | Rimuove una colonna da una tabella esistente |
| `ALTER TABLE RENAME COLUMN` | Rinomina una colonna                         |
| `ALTER TABLE MODIFY COLUMN` | Modifica il tipo di dato di una colonna      |
| `CREATE INDEX`              | Crea un indice per velocizzare le query      |
___
# Data Definition Language

Il **DDL** è la parte del linguaggio SQL utilizzata per **definire e gestire la struttura** degli oggetti del database (come tabelle, schemi, indici, ecc.). 
Non modifica i dati, ma definisce il **contenitore** in cui i dati vivranno.
___
# Gestione del Database

## CREATE DATABASE
Crea un nuovo database nel DBMS.

```sql
CREATE DATABASE ProgettoFinale;
```

**Risultato**: 
Viene creato il database vuoto `ProgettoFinale`, pronto per contenere tabelle e altri oggetti.
## DROP DATABASE
Elimina completamente un database, inclusi tutti i suoi oggetti (tabelle, dati, indici, ecc.). 
È un'operazione **definitiva e irreversibile**.

```sql
DROP DATABASE ProgettoFinale;
```

___
# Gestione delle Tabelle

## CREATE TABLE
Crea una nuova tabella nel database specificando colonne e tipi di dato.

```sql
CREATE TABLE Esami (
    ID         INT PRIMARY KEY,
    Voto       INT,
    StudenteID INT
);
```

**Struttura risultante**:

|Nome Colonna|Tipo di Dato|Note|
|:--|:--|:--|
|ID|`INT`|Chiave Primaria|
|Voto|`INT`||
|StudenteID|`INT`||
## DROP TABLE
Elimina completamente una tabella esistente, inclusi tutti i dati, gli indici e i privilegi associati.

```sql
DROP TABLE Esami;
```

___

# Modifica delle Tabelle (ALTER TABLE)
Il comando `ALTER TABLE` permette di modificare la struttura di una tabella già esistente senza doverla ricreare da zero.
## ADD COLUMN
Aggiunge una nuova colonna alla tabella. I valori nelle righe esistenti saranno `NULL`.

**Tabella `Studenti` prima:**

|id|nome|età|corso|
|:--|:--|:--|:--|
|1|Luca|22|Matematica|

```sql
ALTER TABLE Studenti
ADD COLUMN Email VARCHAR(100);
```

**Tabella `Studenti` dopo**:

|id|nome|età|corso|Email|
|:--|:--|:--|:--|:--|
|1|Luca|22|Matematica|**NULL**|
## DROP COLUMN
Rimuove una colonna da una tabella esistente. Tutti i dati contenuti in quella colonna vengono eliminati.

**Tabella `Studenti` prima**:

| id  | nome | età | corso      | Email          |
| :-- | :--- | :-- | :--------- | :------------- |
| 1   | Luca | 22  | Matematica | luca\@email.it |

```sql
ALTER TABLE Studenti
DROP COLUMN Email;
```

**Tabella `Studenti` dopo**:

|id|nome|età|corso|
|:--|:--|:--|:--|
|1|Luca|22|Matematica|
## RENAME COLUMN
Rinomina una colonna esistente senza alterarne il contenuto.

**Tabella `Studenti` prima**:

|id|nome|età|corso|
|:--|:--|:--|:--|
|1|Luca|22|Matematica|

```sql
ALTER TABLE Studenti
RENAME COLUMN Età TO Anni;
```

**Tabella `Studenti` dopo**:

|id|nome|anni|corso|
|:--|:--|:--|:--|
|1|Luca|22|Matematica|
## MODIFY COLUMN
Modifica il tipo di dato e/o la dimensione di una colonna esistente.

**Struttura `Studenti` prima**:

|Colonna|Tipo|
|:--|:--|
|Nome|`VARCHAR(50)`|

```sql
ALTER TABLE Studenti
MODIFY COLUMN Nome VARCHAR(100);
```

**Tabella `Studenti` dopo**:

|Colonna|Tipo|
|:--|:--|
|Nome|`VARCHAR(100)`|

___
# Constraints (Vincoli)

I **constraints** sono regole applicate alle colonne per garantire l'**accuratezza** e l'**integrità** dei dati. Vengono definiti al momento della creazione della tabella o aggiunti in seguito tramite `ALTER TABLE`.
## NOT NULL
Impedisce che una colonna contenga valori `NULL`. Usato per dati essenziali che devono essere sempre presenti.

```sql
CREATE TABLE Studenti (
    ID    INT,
    Nome  VARCHAR(100),
    Corso VARCHAR(50) NOT NULL
);
```

**Esempio di violazione**:

```sql
INSERT INTO Studenti (ID, Nome, Corso)
VALUES (4, 'Giulia', NULL);
-- ❌ ERRORE: la colonna 'Corso' non può essere NULL.
```
## UNIQUE
Garantisce che tutti i valori in una colonna siano distinti. A differenza della chiave primaria, una colonna `UNIQUE` può contenere un valore `NULL` (eccetto in SQL Server).

```sql
CREATE TABLE Docenti (
    ID             INT,
    Nome           VARCHAR(100),
    CodiceFiscale  CHAR(16) UNIQUE
);
```

**Tabella `Docenti` di esempio**:

|id|nome|CodiceFiscale|
|:--|:--|:--|
|1|Prof. Rossi|RSSGNN80A01H501K|

**Esempio di violazione**:

```sql
INSERT INTO Docenti (ID, Nome, CodiceFiscale)
VALUES (2, 'Prof. Verdi', 'RSSGNN80A01H501K');
-- ❌ ERRORE: il CodiceFiscale è già presente.
```
## PRIMARY KEY (PK)
Identifica in modo univoco ogni riga della tabella. Combina implicitamente `NOT NULL` e `UNIQUE`. Ogni tabella può avere **una sola** chiave primaria.

```sql
CREATE TABLE Studenti (
    ID   INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(100),
    Età  INT
);
```

**Tabella `Studenti` di esempio**:

|id (PK)|nome|età|
|:--|:--|:--|
|1|Luca|22|
|2|Anna|19|

**Esempio di violazione**:

```sql
INSERT INTO Studenti (ID, Nome)
VALUES (1, 'Marco');
-- ❌ ERRORE: l'ID 1 è già presente (violazione di UNIQUE).
```
## FOREIGN KEY (FK)
Collega due tabelle referenziando la `PRIMARY KEY` di un'altra tabella, garantendo l'**integrità referenziale**: non è possibile inserire un record figlio se non esiste il record padre corrispondente.

```sql
CREATE TABLE Esami (
    ID_Esame   INT PRIMARY KEY,
    Voto       INT,
    StudenteID INT,
    FOREIGN KEY (StudenteID) REFERENCES Studenti(ID)
);
```

***Relazione padre → figlio***:

**Tabella `Studenti` (padre)**:

| id (PK) | nome |
| :------ | :--- |
| 1       | Luca |
| 2       | Anna |

**Tabella `Esami` (figlia)**:

|ID_Esame|Voto|StudenteID (FK)|
|:--|:--|:--|
|101|30|1|
|102|28|2|

**Esempio di violazione**:

```sql
INSERT INTO Esami (ID_Esame, Voto, StudenteID)
VALUES (103, 25, 99);
-- ❌ ERRORE: lo StudenteID 99 non esiste nella tabella Studenti.
```
### Azioni Referenziali (ON DELETE / ON UPDATE)
Quando si definisce una `FOREIGN KEY`, è possibile specificare cosa deve succedere ai record figli quando il record padre viene **eliminato** (`ON DELETE`) o **modificato** (`ON UPDATE`).

```sql
CREATE TABLE Esami (
    ID_Esame   INT PRIMARY KEY,
    Voto       INT,
    StudenteID INT,
    FOREIGN KEY (StudenteID) REFERENCES Studenti(ID)
	    ON DELETE <azione>
	    ON UPDATE <azione>
);
```

***Tabelle di esempio***

**Tabella `Studenti` (padre):**

| id (PK) | nome |
| :------ | :--- |
| 1       | Luca |
| 2       | Anna |

**Tabella `Esami` (figlia):**

| ID_Esame | Voto | StudenteID (FK) |
| :------- | :--- | :-------------- |
| 101      | 30   | 1               |
| 102      | 28   | 1               |
#### CASCADE
Il cambiamento si **propaga automaticamente** ai record figli.
Se il padre viene eliminato, i figli vengono eliminati. Se l'ID del padre cambia, cambia anche nella tabella figlia.

```sql
CREATE TABLE Esami (
    ID_Esame   INT PRIMARY KEY,
    Voto       INT,
    StudenteID INT,
    FOREIGN KEY (StudenteID) REFERENCES Studenti(ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
```

```sql
DELETE FROM Studenti WHERE ID = 1;
-- ✅ Luca viene eliminato da Studenti
-- ✅ Gli esami 101 e 102 vengono eliminati automaticamente da Esami
```
#### SET NULL
Quando il padre viene eliminato o modificato, il valore della FK nei record figli viene impostato a `NULL`. 
La colonna figlia **non deve** avere il vincolo `NOT NULL`.

```sql
CREATE TABLE Esami (
    ID_Esame   INT PRIMARY KEY,
    Voto       INT,
    StudenteID INT,
    FOREIGN KEY (StudenteID) REFERENCES Studenti(ID)
        ON DELETE SET NULL
);
```

```sql
DELETE FROM Studenti WHERE ID = 1;
-- ✅ Luca viene eliminato da Studenti
-- ✅ Gli esami 101 e 102 rimangono, ma StudenteID diventa NULL
```

**Tabella `Esami` dopo:**

| ID_Esame | Voto | StudenteID |
| :------- | :--- | :--------- |
| 101      | 30   | **NULL**   |
| 102      | 28   | **NULL**   |
#### RESTRICT / NO ACTION
Impedisce l'eliminazione o la modifica del padre **se esistono record figli collegati**. È il comportamento predefinito in molti DBMS se non si specifica nulla.
**Differenza** tra `RESTRICT` e `NO ACTION`:
- `RESTRICT` controlla il vincolo immediatamente
- `NO ACTION` lo controlla alla fine della transazione
In pratica si comportano spesso allo stesso modo.

```sql
CREATE TABLE Esami (
    ID_Esame   INT PRIMARY KEY,
    Voto       INT,
    StudenteID INT,
    FOREIGN KEY (StudenteID) REFERENCES Studenti(ID)
        ON DELETE RESTRICT
);
```

```sql
DELETE FROM Studenti WHERE ID = 1;
-- ❌ ERRORE: esistono record in Esami che riferiscono StudenteID = 1.
-- Non è possibile eliminare Luca finché i suoi esami esistono.
```
#### SET DEFAULT
Quando il padre viene eliminato o modificato, la FK nei figli viene impostata al valore di `DEFAULT` definito sulla colonna.

```sql
CREATE TABLE Esami (
    ID_Esame   INT PRIMARY KEY,
    Voto       INT,
    StudenteID INT DEFAULT 0,
    FOREIGN KEY (StudenteID) REFERENCES Studenti(ID)
        ON DELETE SET DEFAULT
);
```

```sql
DELETE FROM Studenti WHERE ID = 1;
-- ✅ Luca viene eliminato da Studenti
-- ✅ Gli esami 101 e 102 rimangono, StudenteID diventa 0 (il DEFAULT)
```
##### Riepilogo Azioni Referenziali

| Azione        | ON DELETE                              | ON UPDATE                              |
| :------------ | :------------------------------------- | :------------------------------------- |
| `CASCADE`     | Elimina i figli automaticamente        | Aggiorna i figli automaticamente       |
| `SET NULL`    | Imposta FK a `NULL` nei figli          | Imposta FK a `NULL` nei figli          |
| `RESTRICT`    | Blocca l'operazione se esistono figli  | Blocca l'operazione se esistono figli  |
| `NO ACTION`   | Come RESTRICT (controllo a fine tx)    | Come RESTRICT (controllo a fine tx)    |
| `SET DEFAULT` | Imposta FK al valore DEFAULT nei figli | Imposta FK al valore DEFAULT nei figli |
## CHECK
Definisce una condizione booleana che ogni valore inserito in una colonna deve soddisfare.

```sql
CREATE TABLE Ordini (
    ID_Ordine INT PRIMARY KEY,
    Prodotto  VARCHAR(100),
    Quantità  INT CHECK (Quantità > 0)
);
```

**Esempio di violazione**:

```sql
INSERT INTO Ordini (ID_Ordine, Prodotto, Quantità)
VALUES (501, 'Penna', 0);
-- ❌ ERRORE: la Quantità deve essere maggiore di 0.
```
## DEFAULT
Assegna automaticamente un valore predefinito a una colonna quando non viene specificato un valore durante l'inserimento.

```sql
CREATE TABLE Utenti (
    ID    INT PRIMARY KEY,
    Nome  VARCHAR(100),
    Stato VARCHAR(50) DEFAULT 'Attivo'
);
```

**Inserimento senza specificare `Stato`**:

```sql
INSERT INTO Utenti (ID, Nome)
VALUES (2, 'Anna');
```

**Tabella `Utenti` risultante**:

|ID|Nome|Stato|
|:--|:--|:--|
|1|Luca|Attivo|
|2|Anna|**Attivo**|

Il valore `'Attivo'` viene assegnato automaticamente.
### Riepilogo Constraints

| Constraint    | Scopo                                                     | NULL consentito? |
| :------------ | :-------------------------------------------------------- | :--------------- |
| `NOT NULL`    | Obbliga la presenza di un valore                          | ❌                |
| `UNIQUE`      | Impedisce valori duplicati                                | ✅ (uno solo)     |
| `PRIMARY KEY` | Identifica univocamente ogni riga (`NOT NULL` + `UNIQUE`) | ❌                |
| `FOREIGN KEY` | Garantisce l'integrità referenziale tra tabelle           | ✅                |
| `CHECK`       | Valida i dati rispetto a una condizione logica            | ✅                |
| `DEFAULT`     | Fornisce un valore automatico se non specificato          | ✅                |

___
# Indici (CREATE INDEX)

Un **indice** funziona come l'indice di un libro: permette al DBMS di trovare le righe cercate senza dover scansionare l'intera tabella, velocizzando le operazioni di `SELECT`, `WHERE` e `JOIN`.

Gli indici vengono creati automaticamente per `PRIMARY KEY` e `UNIQUE`. 
Per altre colonne frequentemente usate nelle ricerche, è possibile crearli manualmente.

```sql
CREATE INDEX idx_eta_studenti
ON Studenti (Età);
```

**Effetto**: le query che filtrano o ordinano per `Età` saranno sensibilmente più veloci su tabelle con molte righe.

**Esempio di query che beneficia dell'indice**:

```sql
-- Senza indice: scansione completa della tabella
-- Con indice: ricerca diretta tramite struttura B-Tree
SELECT * FROM Studenti
WHERE Età = 22;
```


> [!Danger] Occhio
>  Gli indici migliorano la lettura (`SELECT`) ma rallentano leggermente la scrittura (`INSERT`, `UPDATE`, `DELETE`) perché l'indice deve essere aggiornato. Usarli con criterio sulle colonne realmente coinvolte nelle ricerche.

___