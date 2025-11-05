Data: 2025-10-29
[SQL](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Database/SQL
___
# Data Manipulation Language
Il DML  è la parte del linguaggio SQL utilizzata per **gestire e manipolare i dati** memorizzati all'interno delle tabelle di un database.

| [[#Select]] | `SELECT Nome, Corso FROM Studenti WHERE Età < 23;`                                 |
| ----------- | ---------------------------------------------------------------------------------- |
| [[#Insert]] | `INSERT INTO Studenti (ID, Nome, Età, Corso) VALUES (4, 'Giulia', 21, 'Chimica');` |
| [[#Update]] | `UPDATE Studenti SET Corso = 'Informatica' WHERE ID = 1;`<br>                      |
| [[#Delete]] | `DELETE FROM Studenti WHERE ID = 3;`                                               |

___

# Select

**Descrizione:**  
Filtra le righe in base a una condizione.

**Studenti**

| ID  | Nome  | Età | Corso       |
| --- | ----- | --- | ----------- |
| 1   | Luca  | 22  | Matematica  |
| 2   | Anna  | 19  | Informatica |
| 3   | Marco | 24  | Fisica      |

**Query:**

``` SQL
SELECT Nome, Corso FROM Studenti WHERE Età < 23;
```

**Risultato:**

| Nome  | Corso       |
| ----- | ----------- |
| Luca  | Matematica  |
| Anna  | Informatica |
| Marco | Fisica      |

___
# Insert
**Descrizione:**
Si usa per **aggiungere** una nuova riga alla tabella


**Studenti**

| ID  | Nome  | Età | Corso       |
| --- | ----- | --- | ----------- |
| 1   | Luca  | 22  | Matematica  |
| 2   | Anna  | 19  | Informatica |
| 3   | Marco | 24  | Fisica      |

**Query:**
``` SQL
INSERT INTO Studenti (ID, Nome, Età, Corso) VALUES (4, 'Giulia', 21, 'Chimica');
```

**Risultato:**

| ID  | Nome   | Età | Corso       |
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

| ID  | Nome  | Età | Corso       |
| --- | ----- | --- | ----------- |
| 1   | Luca  | 22  | Matematica  |
| 2   | Anna  | 19  | Informatica |
| 3   | Marco | 24  | Fisica      |

**Query:**
``` SQL
UPDATE Studenti SET Corso = 'Informatica' WHERE ID = 1;
```

**Risultato:**

| ID  | Nome  | Età | Corso       |
| --- | ----- | --- | ----------- |
| 1   | Luca  | 22  | Informatica |
| 2   | Anna  | 19  | Informatica |
| 3   | Marco | 24  | Fisica      |

___
# Delete
**Descrizione:**
Si usa per **rimuovere** una o più righe dalla tabella

**Studenti**

| ID  | Nome  | Età | Corso       |
| --- | ----- | --- | ----------- |
| 1   | Luca  | 22  | Matematica  |
| 2   | Anna  | 19  | Informatica |
| 3   | Marco | 24  | Fisica      |

**Query:**
``` SQL
DELETE FROM Studenti WHERE ID = 3;
```

**Risultato:**

| ID  | Nome  | Età | Corso       |
| --- | ----- | --- | ----------- |
| 1   | Luca  | 22  | Informatica |
| 2   | Anna  | 19  | Informatica |

___