Data: 2025-10-29
[SQL](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Database/SQL
___
# Data Control Language

Il **DQL (Data Query Language)** è la parte di SQL che si occupa del recupero e della visualizzazione dei dati.  
Le principali operazioni derivate dall’**algebra relazionale** sono:

| **Tipo**                 | **Esempio**                                                                                                                                                                                                                           |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [[#Selezione]]           | SELECT * FROM Studenti WHERE età > 20;                                                                                                                                                                                                |
| [[#Distinct]]            | SELECT DISTINCT citta FROM Sede;                                                                                                                                                                                                      |
| [[#Proiezione]]          | SELECT nome, corso FROM Studenti;                                                                                                                                                                                                     |
| [[#Unione]]              | SELECT  FROM Studenti1 UNION SELECT  FROM Studenti2;<br>                                                                                                                                                                              |
| [[#Sottrazione]]         | SELECT  FROM Studenti1 EXCEPT SELECT  FROM Studenti2;                                                                                                                                                                                 |
| [[#Intersezione]]        | SELECT  FROM Studenti1 INTERSECT SELECT  FROM Studenti2;                                                                                                                                                                              |
| [[#Prodotto cartesiano]] | SELECT * FROM Studenti, Corsi;                                                                                                                                                                                                        |
| [[#Natural Join]]        | SELECT impiegati2.`*`,dipartimenti.`*`<br>FROM impiegati2, dipartimenti<br>WHERE impiegati2.codice=dipartimenti.codice;                                                                                                               |
| [[#Theta Join]]          | SELECT impiegati.`*`,dipartimenti.`*`<br>FROM impiegati, dipartimenti<br>WHERE impiegati.dipartimento<>dipartimenti.codice;                                                                                                           |
| [[#Equi Join]]           | SELECT impiegati.`*`,dipartimenti.`*`<br>FROM impiegati,dipartimenti<br>WHERE impiegati.dipartimento=dipartimenti.codice;                                                                                                             |
| [[#ORDER BY]]            | SELECT Titolo, Pagine <br>FROM Libri<br>ORDER BY Titolo ASC;                                                                                                                                                                          |
| [[#Like]]                | SELECT nome, cognome<br>FROM Docenti<br>WHERE nome LIKE 'L%';                                                                                                                                                                         |
| [[#GROUP BY]]            | SELECT -- Attributi che vuoi visualizzare<br>FROM -- Tabella<br>WHERE -- Pre Filtro<br>GROUP BY -- Attributo per cui vuole fare un gruppo<br>HAVING --Opertato di aggregazione, filtro sul gruppo<br>ORDER BY -- Ordina poi il gruppo |

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
SELECT * 
FROM Studenti 
WHERE età > 20;
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
# Distinct
**Descrizione:**
È usata per **eliminare i duplicati** dal set di risultati di una query, garantendo che ogni riga o combinazione di valori restituita sia **unica**.

**Sede**

| citta  |
| ------ |
| Roma   |
| Milano |
| Roma   |
| Milano |
| Roma   |

**Query:**

``` SQL
SELECT DISTINCT citta 
FROM Sede;
```

**Risultato:**

| citta  |
| ------ |
| Roma   |
| Milano |
___

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
SELECT nome, corso 
FROM Studenti;
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
SELECT * 
FROM Studenti1 UNION 
SELECT * 
FROM Studenti2;
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
SELECT * 
FROM Studenti1 EXCEPT 
SELECT * FROM Studenti2;
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
SELECT * 
FROM Studenti1 INTERSECT 
SELECT * 
FROM Studenti2;
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
SELECT * 
FROM Studenti, Corsi;
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

| id  | nome | id_corso | id_corsi_materie | nome_corso  |
| --- | ---- | -------- | ---------------- | ----------- |
| 1   | Luca | 101      | 101              | Matematica  |
| 2   | Anna | 102      | 102              | Informatica |
| 3   | Marco | 103      | 103              | Fisica      |

___
# ORDER BY

**Descrizione:**
Il comando ORDER BY in SQL serve per mettere in ordine i risultati che ottieni da una tabella. Immagina di avere un elenco di dati e vuoi che siano disposti in un certo modo, ad esempio in ordine alfabetico, per data, o dal valore più piccolo al più grande.

Questo comando viene sempre aggiunto **alla fine** della tua query `SELECT`.

## Tabella Esempio: "Libri"

|**ID**|**Titolo**|**Pagine**|**Autore**|
|---|---|---|---|
|1|Il Signore degli Anelli|1216|Tolkien|
|2|1984|328|Orwell|
|3|Moby Dick|585|Melville|

---

## Ordine Crescente

L'ordine predefinito è **crescente** (`ASC`, Ascending). Se ordini dei numeri, vanno dal piccolo al grande (1, 2, 3...). Se ordini del testo, va in ordine alfabetico (A, B, C...).
`ASC` è impostato di default

**Query:**

Ordiniamo i libri in base al Titolo in ordine alfabetico (crescente).

``` SQL
SELECT Titolo, Pagine 
FROM Libri
ORDER BY Titolo ASC;
```

**Risultato:**

|**Titolo**|**Pagine**|
|---|---|
|**1984**|328|
|Il Signore degli Anelli|1216|
|Moby Dick|585|

---

## Ordine Discendente

Se vuoi l'ordine inverso, devi specificare **`DESC`** (Descending). Per i numeri, va dal grande al piccolo (10, 9, 8...). Per il testo, va dalla Z alla A.

**Query:**

Ordiniamo i libri in base al numero di Pagine dal più grande al più piccolo.

``` SQL
SELECT Titolo, Pagine 
FROM Libri
ORDER BY Pagine DESC;
```

**Risultato:**

|**Titolo**|**Pagine**|
|---|---|
|Il Signore degli Anelli|**1216**|
|Moby Dick|**585**|
|1984|**328**|

---

## Ordine Multiplo

Puoi ordinare per **più colonne**. Il database ordinerà prima in base alla prima colonna specificata e, in caso di valori uguali, userà la seconda colonna per risolvere l'ordine.

Aggiungiamo un libro alla nostra tabella:

|**ID**|**Titolo**|**Pagine**|**Autore**|
|---|---|---|---|
|4|Lo Hobbit|310|Tolkien|

**Query:**

Ordiniamo prima per Autore (ASC) e, se gli autori sono uguali (come i due libri di Tolkien), ordiniamo per Pagine (DESC).

``` SQL
SELECT Titolo, Autore, Pagine 
FROM Libri
ORDER BY Autore ASC, Pagine DESC;
```

**Risultato:**

| **Titolo**                  | **Autore**  | **Pagine** |
| --------------------------- | ----------- | ---------- |
| Moby Dick                   | Melville    | 585        |
| 1984                        | Orwell      | 328        |
| **Il Signore degli Anelli** | **Tolkien** | **1216**   |
| **Lo Hobbit**               | **Tolkien** | **310**    |
___
# Like

L'operatore `LIKE` viene utilizzato nella clausola `WHERE` per eseguire ricerche che corrispondano a un modello (pattern) specifico. È fondamentale quando devi trovare righe in base a corrispondenze parziali di stringhe, come trovare tutti i nomi che iniziano con una certa lettera.

Caratteri jolly (wildcard):

|**Carattere Jolly**|**Significato**|**Esempio**|**Descrizione**|
|---|---|---|---|
|**`%`** (Percentuale)|Corrisponde a **zero o più** caratteri qualsiasi.|`P%`|Trova qualsiasi stringa che inizia con 'P'|
|**`\_`** (Sottolinea)|Corrisponde a un **singolo** carattere qualsiasi.|`_tto`|Trova qualsiasi stringa di 4 lettere che termina con 'tto' (es. `atto`, `otto`)|

---

**Esempio:** Trovare tutti i docenti il cui nome inizia con la lettera 'L'.

``` sql
SELECT nome, cognome
FROM Docenti
WHERE nome LIKE 'L%';
```

**Risultato (usando i dati del database `ScuolaDB`):**

|**nome**|**cognome**|
|---|---|
|Laura|Bianchi|
|Luca|Gialli|
|Luca|Esposito|

**Esempio:** Trovare tutti gli studenti il cui cognome termina con la sequenza 'o'.

``` SQL
SELECT nome, cognome
FROM Studenti
WHERE cognome LIKE '%o';
```

**Risultato:**

|**nome**|**cognome**|
|---|---|
|Simone|Gallo|
|Marco|Rizzo|
|Luca|Esposito|
___

# GROUP BY

``` SQL
SELECT -- Attributi che vuoi visualizzare
FROM -- Tabella
WHERE -- Pre Filtro
GROUP BY -- Attributo per cui vuole fare un gruppo
HAVING --Opertato di aggregazione, filtro sul gruppo
ORDER BY -- Ordina poi il gruppo
```

Si usa per suddividere la tabella in gruppi, ogni gruppo presenta le righe che hanno uno stesso valore dell'attributo indicato nel **GROUP BY**

- **Esempio:** vendite (id, prodotto_id, quantità, importo, data);
Trovare l'importo totale delle vendite per ogni prodotto mostrando solo i prodotti con vendite superiori a 1000

``` SQL
SELECT prodotto_id, SUM(importo * quantità) as totale
FROM vendite
GROUP BY prodotto
HAVING totale > 1000
```
