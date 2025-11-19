Data: 2025-10-29
[SQL](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Database/SQL
___
# Data Control Language

Il **DQL (Data Query Language)** è la parte di SQL che si occupa del recupero e della visualizzazione dei dati.  
Le principali operazioni derivate dall’**algebra relazionale** sono:

| [[#Selezione]]           | SELECT * FROM Studenti WHERE età > 20;                                                                                      |
| ------------------------ | --------------------------------------------------------------------------------------------------------------------------- |
| [[#Proiezione]]          | SELECT nome, corso FROM Studenti;                                                                                           |
| [[#Unione]]              | SELECT  FROM Studenti1 UNION SELECT  FROM Studenti2;<br>                                                                    |
| [[#Sottrazione]]         | SELECT  FROM Studenti1 EXCEPT SELECT  FROM Studenti2;                                                                       |
| [[#Intersezione]]        | SELECT  FROM Studenti1 INTERSECT SELECT  FROM Studenti2;                                                                    |
| [[#Prodotto cartesiano]] | SELECT * FROM Studenti, Corsi;                                                                                              |
| [[#Natural Join]]        | SELECT impiegati2.`*`,dipartimenti.`*`<br>FROM impiegati2, dipartimenti<br>WHERE impiegati2.codice=dipartimenti.codice;     |
| [[#Theta Join]]          | SELECT impiegati.`*`,dipartimenti.`*`<br>FROM impiegati, dipartimenti<br>WHERE impiegati.dipartimento<>dipartimenti.codice; |
| [[#Equi Join]]           | SELECT impiegati.`*`,dipartimenti.`*`<br>FROM impiegati,dipartimenti<br>WHERE impiegati.dipartimento=dipartimenti.codice;   |

---
# Selezione

**Descrizione:**  
Filtra le righe in base a una condizione.

**Esempio:** Tabella Studenti

| id  | nome  | età | corso       |
| --- | ----- | --- | ----------- |
| 1   | Luca  | 22  | Matematica  |
| 2   | Anna  | 19  | Informatica |
| 3   | Marco | 24  | Fisica      |

**Query:**

``` SQL
SELECT * FROM Studenti WHERE età > 20;
```

**Risultato:**

| id  | nome  | età | corso      |
| --- | ----- | --- | ---------- |
| 1   | Luca  | 22  | Matematica |
| 3   | Marco | 24  | Fisica     |

 **Spiegazione:**

- `SELECT`  serve per scegliere **quali colonne** visualizzare nel risultato.
- `*` è un **metacarattere** che rappresenta **tutte le colonne** della tabella.
- `FROM Studenti` indica **da quale tabella** prendere i dati.
- `WHERE età > 20`  applica una **condizione di filtro**: mostra solo le righe dove l’età è maggiore di 20.
---
# Proiezione
**Scopo:**  
Scegliere le colonne (attributi) da visualizzare, eliminando i duplicati se necessario.

**Esempio:** Tabella Studenti

| id  | nome  | età | corso       |
| --- | ----- | --- | ----------- |
| 1   | Luca  | 22  | Matematica  |
| 2   | Anna  | 19  | Informatica |
| 3   | Marco | 24  | Fisica      |

**Query:**

```  SQL
SELECT nome, corso FROM Studenti;
```

**Risultato:**

| nome  | corso       |
| ----- | ----------- |
| Luca  | Matematica  |
| Anna  | Informatica |
| Marco | Fisica      |

- `SELECT` è il comando SQL che serve per **scegliere quali colonne** (campi) vuoi visualizzare nel risultato della query.
- `nome, corso` sono i **nomi delle colonne** che vuoi mostrare
- `FROM Studenti` indica **da quale tabella** prendere i dati.

---
# Unione

**Descrizione:**  
Combina le righe di **due tabelle** con **lo stesso numero di colonne e tipi compatibili**, **eliminando i duplicati** (a meno che non si usi `UNION ALL`).

**Esempio:** Tabelle Studenti1 e Studenti2

**Studenti1**

| id  | nome | corso       |
| --- | ---- | ----------- |
| 1   | Luca | Matematica  |
| 2   | Anna | Informatica |

**Studenti2**

| id  | nome  | corso       |
| --- | ----- | ----------- |
| 3   | Marco | Fisica      |
| 4   | Anna  | Informatica |

**Query:**

``` SQL
SELECT * FROM Studenti1 UNION SELECT * FROM Studenti2;
```


**Risultato:**

| id  | nome  | corso       |
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

| nome  | corso       |
| ----- | ----------- |
| Luca  | Matematica  |
| Anna  | Informatica |
| Marco | Fisica      |

**Studenti2**

| nome  | corso       |
| ----- | ----------- |
| Anna  | Informatica |
| Marco | Fisica      |

**Query:**

``` SQL
SELECT * FROM Studenti1 EXCEPT SELECT * FROM Studenti2;
```

**Risultato:**

| nome | corso      |
| ---- | ---------- |
| Luca | Matematica |

**Spiegazione:**

- `EXCEPT`  restituisce le righe **che appaiono solo nella prima query**.

---
# Intersezione

**Descrizione:**  
Restituisce solo le righe **presenti in entrambe le tabelle**.

**Esempio:** Tabelle Studenti1 e Studenti2

**Studenti1**

| nome  | corso       |
| ----- | ----------- |
| Luca  | Matematica  |
| Anna  | Informatica |
| Marco | Fisica      |

**Studenti2**

| nome   | corso       |
| ------ | ----------- |
| Anna   | Informatica |
| Marco  | Fisica      |
| Giulia | Chimica     |

**Query:**

``` SQL
SELECT * FROM Studenti1 INTERSECT SELECT * FROM Studenti2;
```

**Risultato:**

| nome  | corso       |
| ----- | ----------- |
| Anna  | Informatica |
| Marco | Fisica      |

**Spiegazione:**

- `INTERSECT` mostra solo le righe **comuni** a entrambe le query.
- Elimina automaticamente i **duplicati**.

---
# Prodotto cartesiano

**Descrizione:**  
Combina **ogni riga della prima tabella** con **ogni riga della seconda**, generando **tutte le possibili combinazioni**.

**Esempio:** Tabelle Studenti e Corsi

**Studenti**

| nome |
| ---- |
| Luca |
| Anna |

**Corsi**

| corso      |
| ---------- |
| Matematica |
| Fisica     |

**Query:**

``` SQL
SELECT * FROM Studenti, Corsi;
```

**Risultato:**

| nome | corso      |
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

| id  | nome  | id_corso |
| --- | ----- | -------- |
| 1   | Luca  | 101      |
| 2   | Anna  | 102      |
| 3   | Marco | 103      |

**Corsi**

| id_corsi_materie | nome_corso  |
| ---------------- | ----------- |
| 101              | Matematica  |
| 102              | Informatica |
| 103              | Fisica      |

**Query:**

``` SQL
SELECT Studenti.*,Corsi.*
FROM Studenti, Corsi
WHERE Studenti.id_corso = Corsi.id_corsi_materie;
```

**Risultato:**

| id  | nome  | id_corso | id_corsi_materie | nome_corso  |
| --- | ----- | -------- | ---------------- | ----------- |
| 1   | Luca  | 101      | 101              | Matematica  |
| 2   | Anna  | 102      | 102              | Informatica |
| 3   | Marco | 103      | 103              | Fisica      |

---
# Theta Join
**Descrizione:**
$R_a$ ⋈θ $R_b$
La **theta join** è una **giunzione** tra due tabelle che usa **una condizione qualsiasi (θ)**, non solo l’uguaglianza.  

Il simbolo **θ** rappresenta un operatore di confronto come `=`, `<`, `>`, `<=`, `>=`, `<>`.

**Studenti**

| id  | nome  | id_corso |
| --- | ----- | -------- |
| 1   | Luca  | 101      |
| 2   | Anna  | 102      |
| 3   | Marco | 103      |

**Corsi**

| id_corsi_materie | nome_corso  |
| ---------------- | ----------- |
| 101              | Matematica  |
| 102              | Informatica |
| 103              | Fisica      |

**Query:**

``` SQL
SELECT Studenti.*,Corsi.*
FROM Studenti, Corsi
WHERE Studenti.id_corso <= Corsi.id_corsi_materie;
```

**Risultato:**

| id  | nome  | id_corso | id_corsi_materie | nome_corso  |
| --- | ----- | -------- | ---------------- | ----------- |
| 1   | Luca  | 101      | 101              | Matematica  |
| 1   | Luca  | 101      | 102              | Informatica |
| 1   | Luca  | 101      | 103              | Fisica      |
| 2   | Anna  | 102      | 102              | Informatica |
| 2   | Anna  | 102      | 103              | Fisica      |
| 3   | Marco | 103      | 103              | Fisica      |

___
# Equi Join
**Descrizione:**  
L’**Equi Join** è un tipo di **giunzione (JOIN)** in cui le righe di due tabelle vengono combinate usando una **condizione di uguaglianza (`=`)** tra colonne corrispondenti.

**Studenti**

| id  | nome  | id_corso |
| --- | ----- | -------- |
| 1   | Luca  | 101      |
| 2   | Anna  | 102      |
| 3   | Marco | 103      |

**Corsi**

| id_corsi_materie | nome_corso  |
| ---------------- | ----------- |
| 101              | Matematica  |
| 102              | Informatica |
| 103              | Fisica      |

**Query:**

``` SQL
SELECT Studenti.*,Corsi.*
FROM Studenti,Corsi
WHERE Studenti.id_corsi_materie=Corsi.id_corso;
```

**Risultato:**

| id  | nome  | id_corso | id_corsi_materie | nome_corso  |
| --- | ----- | -------- | ---------------- | ----------- |
| 1   | Luca  | 101      | 101              | Matematica  |
| 2   | Anna  | 102      | 102              | Informatica |
| 3   | Marco | 103      | 103              | Fisica      |

