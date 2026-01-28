Data: 2025-10-29
[SQL](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Database/SQL
___
# Data Manipulation Language
Il DML  è la parte del linguaggio SQL utilizzata per **gestire e manipolare i dati** memorizzati all'interno delle tabelle di un database.

| **Tipo**    | **Esempio**                                                                        |
| ----------- | ---------------------------------------------------------------------------------- |
| [[#Select]] | `SELECT Nome, Corso FROM Studenti WHERE Età < 23;`                                 |
| [[#Insert]] | `INSERT INTO Studenti (ID, Nome, Età, Corso) VALUES (4, 'Giulia', 21, 'Chimica');` |
| [[#Update]] | `UPDATE Studenti SET Corso = 'Informatica' WHERE ID = 1;`<br>                      |
| [[#Delete]] | `DELETE FROM Studenti WHERE ID = 3;`                                               |

___

# Select

**Descrizione:**  
Filtra le righe in base a una condizione.

**Studenti**

| id  | nome  | età | corso       |
| --- | ----- | --- | ----------- |
| 1   | Luca  | 22  | Matematica  |
| 2   | Anna  | 19  | Informatica |
| 3   | Marco | 24  | Fisica      |

**Query:**

``` SQL
SELECT nome, corso FROM Studenti WHERE età < 23;
```

**Risultato:**

| nome  | corso       |
| ----- | ----------- |
| Luca  | Matematica  |
| Anna  | Informatica |
| Marco | Fisica      |

___
# Insert
**Descrizione:**
Si usa per **aggiungere** una nuova riga alla tabella


**Studenti**

| id  | nome  | età | corso       |
| --- | ----- | --- | ----------- |
| 1   | Luca  | 22  | Matematica  |
| 2   | Anna  | 19  | Informatica |
| 3   | Marco | 24  | Fisica      |

**Query:**
``` SQL
INSERT INTO Studenti (id, nome, età, corso) VALUES (4, 'Giulia', 21, 'Chimica');
```

**Risultato:**

| id  | nome   | età | corso       |
| --- | ------ | --- | ----------- |
| 1   | Luca   | 22  | Matematica  |
| 2   | Anna   | 19  | Informatica |
| 3   | Marco  | 24  | Fisica      |
| 4   | Giulia | 21  | Chimica     |

___
# Update
**Descrizione:**
Si usa per **modificare** i dati in una riga che esiste già.

**Studenti**

| id  | nome  | età | corso       |
| --- | ----- | --- | ----------- |
| 1   | Luca  | 22  | Matematica  |
| 2   | Anna  | 19  | Informatica |
| 3   | Marco | 24  | Fisica      |

**Query:**
``` SQL
UPDATE Studenti 
SET corso = 'Informatica' 
WHERE ID = 1;
```

**Risultato:**

| id  | nome  | età | corso       |
| --- | ----- | --- | ----------- |
| 1   | Luca  | 22  | Informatica |
| 2   | Anna  | 19  | Informatica |
| 3   | Marco | 24  | Fisica      |

___
# Delete
**Descrizione:**
Si usa per **rimuovere** una o più righe dalla tabella

**Studenti**

| id  | nome  | età | corso       |
| --- | ----- | --- | ----------- |
| 1   | Luca  | 22  | Matematica  |
| 2   | Anna  | 19  | Informatica |
| 3   | Marco | 24  | Fisica      |

**Query:**
``` SQL
DELETE FROM Studenti WHERE ID = 3;
```

**Risultato:**

| id  | nome | età | corso       |
| --- | ---- | --- | ----------- |
| 1   | Luca | 22  | Informatica |
| 2   | Anna | 19  | Informatica |

___