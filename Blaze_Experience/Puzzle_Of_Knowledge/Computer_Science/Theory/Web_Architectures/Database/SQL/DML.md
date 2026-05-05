Data: 2025-10-29
[SQL](Puzzle_Of_Knowledge/Computer_Science/Theory/Web_Architectures/Database/SQL/README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Database/SQL
___
# Index 
- [[#Data Manipulation Language]]
- [[#Insert]]
- [[#Update]]
- [[#Delete]]

| Tipo       | Esempio                                                                            |
| ---------- | ---------------------------------------------------------------------------------- |
| **Insert** | `INSERT INTO Studenti (ID, Nome, Età, Corso) VALUES (4, 'Giulia', 21, 'Chimica');` |
| **Update** | `UPDATE Studenti SET Corso = 'Informatica' WHERE ID = 1;`<br>                      |
| **Delete** | `DELETE FROM Studenti WHERE ID = 3;`                                               |
___
# Data Manipulation Language

Il **DML** è la parte del linguaggio SQL utilizzata per **gestire e manipolare i dati** memorizzati all'interno delle tabelle di un database.
___
# Insert

**Descrizione**:
Si usa per **aggiungere** una nuova riga alla tabella

**Esempio**: Tabella Studenti

| id  | nome  | età | corso       |
| --- | ----- | --- | ----------- |
| 1   | Luca  | 22  | Matematica  |
| 2   | Anna  | 19  | Informatica |
| 3   | Marco | 24  | Fisica      |

**Query**:

``` SQL
INSERT INTO Studenti (id, nome, età, corso) VALUES (4, 'Giulia', 21, 'Chimica');
```

**Risultato**:

| id  | nome   | età | corso       |
| --- | ------ | --- | ----------- |
| 1   | Luca   | 22  | Matematica  |
| 2   | Anna   | 19  | Informatica |
| 3   | Marco  | 24  | Fisica      |
| 4   | Giulia | 21  | Chimica     |

**Spiegazione**:
- `INTO`: Specifica la tabella, e tra parentesi gli attributi che deve passare
- `VALUES`: Specifica i valori degli attributi
___
# Update

**Descrizione**:
Si usa per **modificare** i dati in una riga che esiste già.

**Esempio**: Tabella Studenti

| id  | nome  | età | corso       |
| --- | ----- | --- | ----------- |
| 1   | Luca  | 22  | Matematica  |
| 2   | Anna  | 19  | Informatica |
| 3   | Marco | 24  | Fisica      |

**Query**:

``` SQL
UPDATE Studenti 
SET corso = 'Informatica', età = 10
WHERE ID = 1;
```

**Risultato**:

| id  | nome  | età | corso       |
| --- | ----- | --- | ----------- |
| 1   | Luca  | 10  | Informatica |
| 2   | Anna  | 19  | Informatica |
| 3   | Marco | 24  | Fisica      |

**Spiegazione**:
- `Set`: Specifica il parametro a cui ci va ad apportare la modifica
___
# Delete

**Descrizione**:
Si usa per **rimuovere** una o più righe dalla tabella, Se non si specifica quale riga eliminare, si cancella tutta la tabella (senza il where).

**Esempio**: Tabella Studenti

| id  | nome  | età | corso       |
| --- | ----- | --- | ----------- |
| 1   | Luca  | 22  | Matematica  |
| 2   | Anna  | 19  | Informatica |
| 3   | Marco | 24  | Fisica      |

**Query**:

``` SQL
DELETE FROM Studenti WHERE ID = 3;
```

**Risultato**:

| id  | nome | età | corso       |
| --- | ---- | --- | ----------- |
| 1   | Luca | 22  | Informatica |
| 2   | Anna | 19  | Informatica |

___