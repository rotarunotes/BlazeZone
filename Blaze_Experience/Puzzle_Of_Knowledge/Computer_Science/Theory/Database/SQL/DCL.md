Data: 2025-10-29
[SQL](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Database/SQL
___
# Data Control Language

Il **DQL (Data Query Language)** è la parte di SQL che si occupa del recupero e della visualizzazione dei dati.  
Le principali operazioni derivate dall’**algebra relazionale** sono:

| [[#Selezione]]           | SELECT * FROM Studenti WHERE Età > 20;                                                                                       |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------------------- |
| [[#Proiezione]]          | SELECT Nome, Corso FROM Studenti;                                                                                            |
| [[#Unione]]              | SELECT  FROM Studenti1 UNION SELECT  FROM Studenti2;<br>                                                                     |
| [[#Sottrazione]]         | SELECT  FROM Studenti1 EXCEPT SELECT  FROM Studenti2;                                                                        |
| [[#Intersezione]]        | SELECT  FROM Studenti1 INTERSECT SELECT  FROM Studenti2;                                                                     |
| [[#Prodotto cartesiano]] | SELECT * FROM Studenti, Corsi;                                                                                               |
| [[#Natural Join]]        | SELECT Studenti.Nome,<br>Corsi.NomeCorso FROM Studenti JOIN Corsi ON Studenti.IDCorso = Corsi.IDCorso;                       |
| [[#Theta Join]]          | SELECT Studenti.Nome,<br>       Corsi.NomeCorso<br>FROM Studenti<br>JOIN Corsi<br>ON Studenti.IDCorso > Corsi.IDCorso;       |
| [[#Equi Join]]           | SELECT Studenti.Nome,        <br>		Corsi.NomeCorso <br>FROM Studenti <br>JOIN Corsi <br>ON Studenti.IDCorso = Corsi.IDCorso; |

---

# Selezione

**Descrizione:**  
Filtra le righe in base a una condizione.

**Esempio:** Tabella Studenti

| ID  | Nome  | Età | Corso       |
| --- | ----- | --- | ----------- |
| 1   | Luca  | 22  | Matematica  |
| 2   | Anna  | 19  | Informatica |
| 3   | Marco | 24  | Fisica      |

**Query:**

``` SQL
SELECT * FROM Studenti WHERE Età > 20;
```

**Risultato:**

|ID|Nome|Età|Corso|
|---|---|---|---|
|1|Luca|22|Matematica|
|3|Marco|24|Fisica|

 **Spiegazione:**

- `SELECT`  serve per scegliere **quali colonne** visualizzare nel risultato.
- `*` è un **metacarattere** che rappresenta **tutte le colonne** della tabella.
- `FROM Studenti` indica **da quale tabella** prendere i dati.
- `WHERE Età > 20`  applica una **condizione di filtro**: mostra solo le righe dove l’età è maggiore di 20.
---

# Proiezione
**Scopo:**  
Scegliere le colonne (attributi) da visualizzare, eliminando i duplicati se necessario.

**Esempio:** Tabella Studenti

|ID|Nome|Età|Corso|
|---|---|---|---|
|1|Luca|22|Matematica|
|2|Anna|19|Informatica|
|3|Marco|24|Fisica|

**Query:**

```  SQL
SELECT Nome, Corso FROM Studenti;
```

**Risultato:**

|Nome|Corso|
|---|---|
|Luca|Matematica|
|Anna|Informatica|
|Marco|Fisica|

- `SELECT` è il comando SQL che serve per **scegliere quali colonne** (campi) vuoi visualizzare nel risultato della query.
- `Nome, Corso` sono i **nomi delle colonne** che vuoi mostrare
- `FROM Studenti` indica **da quale tabella** prendere i dati.

---

# Unione

**Descrizione:**  
Combina le righe di **due tabelle** con **lo stesso numero di colonne e tipi compatibili**, **eliminando i duplicati** (a meno che non si usi `UNION ALL`).

**Esempio:** Tabelle Studenti1 e Studenti2

**Studenti1**

|ID|Nome|Corso|
|---|---|---|
|1|Luca|Matematica|
|2|Anna|Informatica|

**Studenti2**

|ID|Nome|Corso|
|---|---|---|
|3|Marco|Fisica|
|4|Anna|Informatica|

**Query:**

``` SQL
SELECT * FROM Studenti1 UNION SELECT * FROM Studenti2;
```


**Risultato:**

| ID  | Nome  | Corso       |
| --- | ----- | ----------- |
| 1   | Luca  | Matematica  |
| 2   | Anna  | Informatica |
| 3   | Marco | Fisica      |
| 4   | Anna  | Informatica |

**Spiegazione:**
- `UNION` combina i risultati di due query.
- Le query devono avere **lo stesso numero di colonne** e **tipi di dato compatibili**.
- `UNION ALL` mantiene anche i **duplicati**.

---

# Sottrazione

**Descrizione:**  
Restituisce le righe presenti nella **prima tabella** ma **non nella seconda**.

**Esempio:** Tabelle Studenti1 e Studenti2

**Studenti1**

|Nome|Corso|
|---|---|
|Luca|Matematica|
|Anna|Informatica|
|Marco|Fisica|

**Studenti2**

|Nome|Corso|
|---|---|
|Anna|Informatica|
|Marco|Fisica|

**Query:**

``` SQL
SELECT * FROM Studenti1 EXCEPT SELECT * FROM Studenti2;
```

**Risultato:**

|Nome|Corso|
|---|---|
|Luca|Matematica|

**Spiegazione:**

- `EXCEPT`  restituisce le righe **che appaiono solo nella prima query**.

---

# Intersezione

**Descrizione:**  
Restituisce solo le righe **presenti in entrambe le tabelle**.

**Esempio:** Tabelle Studenti1 e Studenti2

**Studenti1**

|Nome|Corso|
|---|---|
|Luca|Matematica|
|Anna|Informatica|
|Marco|Fisica|

**Studenti2**

|Nome|Corso|
|---|---|
|Anna|Informatica|
|Marco|Fisica|
|Giulia|Chimica|

**Query:**

``` SQL
SELECT * FROM Studenti1 INTERSECT SELECT * FROM Studenti2;
```

**Risultato:**

|Nome|Corso|
|---|---|
|Anna|Informatica|
|Marco|Fisica|

**Spiegazione:**

- `INTERSECT` mostra solo le righe **comuni** a entrambe le query.
- Elimina automaticamente i **duplicati**.

---

# Prodotto cartesiano

**Descrizione:**  
Combina **ogni riga della prima tabella** con **ogni riga della seconda**, generando **tutte le possibili combinazioni**.

**Esempio:** Tabelle Studenti e Corsi

**Studenti**

|Nome|
|---|
|Luca|
|Anna|

**Corsi**

|Corso|
|---|
|Matematica|
|Fisica|

**Query:**

``` SQL
SELECT * FROM Studenti, Corsi;
```

**Risultato:**

| Nome | Corso      |
| ---- | ---------- |
| Luca | Matematica |
| Luca | Fisica     |
| Anna | Matematica |
| Anna | Fisica     |

**Spiegazione:**

- Il **prodotto cartesiano** è la base di tutte le **giunzioni**

---

# Natural Join

**Descrizione:**  
Combina i dati di **due o più tabelle** basandosi su una **condizione di collegamento (join condition)**.

**Esempio:** Tabelle Studenti e Corsi

**Studenti**

| ID  | Nome  | IDCorso |
| --- | ----- | ------- |
| 1   | Luca  | 101     |
| 2   | Anna  | 102     |
| 3   | Marco | 103     |

**Corsi**

|IDCorso|NomeCorso|
|---|---|
|101|Matematica|
|102|Informatica|
|103|Fisica|

**Query:**

``` SQL
SELECT Studenti.Nome,
Corsi.NomeCorso FROM Studenti JOIN Corsi ON Studenti.IDCorso = Corsi.IDCorso;
```

**Risultato:**

|Nome|NomeCorso|
|---|---|
|Luca|Matematica|
|Anna|Informatica|
|Marco|Fisica|

**Spiegazione:**

- `JOIN` unisce righe da più tabelle in base a una **condizione di uguaglianza** tra chiavi (es. `IDCorso`).

---

# Theta Join
**Descrizione:**
$R_a$ ⋈θ $R_b$
La **theta join** è una **giunzione** tra due tabelle che usa **una condizione qualsiasi (θ)**, non solo l’uguaglianza.  

Il simbolo **θ** rappresenta un operatore di confronto come `=`, `<`, `>`, `<=`, `>=`, `<>`.

**Studenti**

| ID  | Nome  | IDCorso |
| --- | ----- | ------- |
| 1   | Luca  | 101     |
| 2   | Anna  | 102     |
| 3   | Marco | 103     |

**Corsi**

| IDCorso | NomeCorso   |
| ------- | ----------- |
| 101     | Matematica  |
| 102     | Informatica |
| 103     | Fisica      |

**Query:**

``` SQL
SELECT Studenti.Nome,
       Corsi.NomeCorso
FROM Studenti
JOIN Corsi
ON Studenti.IDCorso > Corsi.IDCorso;
```

**Risultato:**

|Nome|NomeCorso|
|---|---|
|Anna|Matematica|
|Marco|Matematica|
|Marco|Informatica|

**Spiegazione:**
- La condizione della join è **`Corsi.IDCorso > Studenti.id`**, non una semplice uguaglianza.
- Questo significa che ogni studente viene abbinato a tutti i corsi con `IDCorso` **minore** del suo.
- È quindi una **θ-join** (theta join), perché la condizione di collegamento usa un **operatore θ generico**, non solo `=`.

___

# Equi Join
**Descrizione:**  
L’**Equi Join** è un tipo di **giunzione (JOIN)** in cui le righe di due tabelle vengono combinate usando una **condizione di uguaglianza (`=`)** tra colonne corrispondenti.

**Studenti**

|ID|Nome|IDCorso|
|---|---|---|
|1|Luca|101|
|2|Anna|102|
|3|Marco|103|

**Corsi**

|IDCorso|NomeCorso|
|---|---|
|101|Matematica|
|102|Informatica|
|103|Fisica|

**Query:**
``` SQL
SELECT Studenti.Nome,        
		Corsi.NomeCorso 
FROM Studenti 
JOIN Corsi 
ON Studenti.IDCorso = Corsi.IDCorso;
```

**Risultato:**

|Nome|NomeCorso|
|---|---|
|Luca|Matematica|
|Anna|Informatica|
|Marco|Fisica|

**Spiegazione:**
- La condizione `Studenti.IDCorso = Corsi.IDCorso` è una **condizione di uguaglianza**, quindi è una **Equi Join**.
- È la forma più comune di join ed è la base anche per la **INNER JOIN** in SQL.
