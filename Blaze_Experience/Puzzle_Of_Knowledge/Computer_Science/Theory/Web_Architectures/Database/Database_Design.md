Data: 2026-02-11
[Database](Puzzle_Of_Knowledge/Computer_Science/Theory/Web_Architectures/Database/README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Database
___
# Index
- [[#Introduzione]]
    - [[#Progettazione Basi Di Dati MVC]]
- [[#Progettazione Concettuale]]
    - [[#Obiettivi]]
    - [[#Schema E-R (Entità-Relazione)]]
	    - [[#Generalizzazioni (IS A)]]
    - [[#Cardinalità]]
- [[#Progettazione Logica]]
    - [[#Obiettivi]]
    - [[#Regole di Traduzione E-R → Relazionale]]
    - [[#Cardinalità in Tabelle]]
	    - [[#Relazioni 1 N]]
	    - [[#Relazioni 1 1]]
	    - [[#Relazioni N M]]
    - [[#Dipendenza funzionale]]
    - [[#Definizioni di Chiave]]
    - [[#Normalizzazione]]
	    - [[#Prima Forma Normale]]
	    - [[#Seconda Forma Normale]]
	    - [[#Terza Forma Normale]]
    - [[#Esempio Completo di Progettazione Logica]]
- [[#Progettazione Fisica (SAPERE FINO A OBIETTIVI)]]

___
# Introduzione

La **progettazione di database** è il processo sistematico attraverso il quale si definisce la **struttura**, l'**organizzazione** e **relazioni** dei dati all'interno di un sistema informativo. 

Un database ben progettato **garantisce**:
1) Efficienza.
2) Integrità dei dati.
3) Facilità di manutenzione.
4) Scalabilità del sistema.
## Progettazione Basi Di Dati MVC

![Progettazione_Dati_Logica_Esempio.jpg](Progettazione_Dati_Logica_Esempio.jpg)

---
# Progettazione Concettuale

La **progettazione concettuale** è la prima fase della progettazione di database. 
L'obiettivo è comprendere **cosa** deve essere rappresentato nel database, senza preoccuparsi di **come** verrà implementato. 

In questa fase si identificano:
## Obiettivi
- **Entità**, oggetti o concetti rilevanti per il sistema (es. Cliente, Prodotto, Ordine);
- **Attributi**, caratteristiche che descrivono ogni entità (es. nome, cognome, email);
- **Relazioni**, come le entità sono collegate tra loro (es. Cliente effettua Ordini);
## Schema E-R (Entità-Relazione)
Lo **Schema E-R (Entity-Relationship)** è un modello grafico utilizzato nella progettazione concettuale per rappresentare visivamente entità, attributi e relazioni.

### Generalizzazioni (IS A):
- **totale**: per ogni A esiste almeno un B o un C (una persona è per forza o maggiorenne o minorenne);
- **parziale**: esiste almeno un A che non ha la controparte (non tutti i film sono drama, non tutte le persone sono maggiorenni);
- **esclusive**: (è solo B o C);
- **sovrapposte**: (può essere sia B che C);

![Schema_E-R_Esempio.jpg](Schema_E-R_Esempio.jpg)

## Cardinalità
La **cardinalità** definisce quante volte un'entità può essere collegata a un'altra entità in una relazione

| Tipo | Esempio reale                            |
| ---- | ---------------------------------------- |
| 1:1  | Persona — Passaporto (uno ha uno)        |
| 1:N  | Dipartimento — Dipendenti (uno ha molti) |
| N:N  | Studente — Corso (molti seguono molti)   |

Là cardinalità può anche specificare:
- **Numero minimo** di occorrenze (cardinalità minima): 0 o 1
- **Numero massimo** di occorrenze (cardinalità massima): 1 o N (molti)
Si esprime con la notazione **(min, max)** su entrambi i lati della relazione.

**Notazione (min, max)**:
- (0,1): opzionale, al massimo uno
- (1,1): obbligatorio, esattamente uno
- (0,N): opzionale, può essere molti
- (1,N): almeno uno
___
# Progettazione Logica

Nella progettazione logica lo **schema E-R** viene trasformato in uno **schema logico**, mantenendo le proprietà e i vincoli definiti nella fase concettuale.
## Obiettivi
- **Tradurre** lo schema E-R in tabelle relazionali
- Eliminare **anomalie** (una relazione con molti attributi)
	- **Inserimento**: Se manca un parametro, non puoi aggiungere una riga 
	- **Aggiornamento**: Se vuoi aggiornare un parametro, devi aggiornare tutte le righe con quel parametro (SPOT, Single Point Of Truth)
	- **Cancellazione**: Elimina più riga anche quelle non desiderate
- **Normalizzare** i dati (eliminare la ridondanza)
- Definire chiavi **primarie** ed **esterne**
## Regole di Traduzione E-R → Relazionale
Ogni ENTITÀ diventa una TABELLA

```
Entità CLIENTE → Tabella CLIENTE
Attributi: id, nome, cognome, email
```

## Cardinalità in Tabelle
### Relazioni 1:N
La chiave primaria del lato "1" diventa chiave esterna nel lato "N"
```
DIPARTIMENTO (1) ──── (N) DIPENDENTE

Tabella DIPARTIMENTO (id_dipartimento, nome_dipartimento)
Tabella DIPENDENTE (id, nome, cognome, id_dipartimento (chiave esterna))
```

### Relazioni 1:1
Si possono incorporare **entrambe** le entità in una unica tabella.
```
PERSONA (1) ──── (1) PASSAPORTO

PASSAPORTO (id, numero, data_scadenza, id_persona (chaive esterna))
```
### Relazioni N:M
Si crea una **tabella di associazione** con le chiavi di entrambe le entità.
```
STUDENTE (N) ──── (M) CORSO

Tabella STUDENTE (id_studente, nome, cognome)
Tabella CORSO (id_corso, titolo, crediti)
Tabella ISCRIZIONE (id_studente(chiave esterna), id_corso(chiave esterna), data_iscrizione)
```

## Dipendenza funzionale

Si ha dipendenza **funzionale** tra attributi quando il valore di un insieme di attributi $A$ determina un singolo valore dell'**attributo** $B$, e si indica con $A \rightarrow B$. Si dice anche che $B$ dipende da $A$, o che $A$ è un determinante per $B$.

**Esempi pratici:**
- Se vivi a Vicenza $\rightarrow$ Vivi in Veneto $\rightarrow$ Italia $\rightarrow$ Europa.
- Nome scuola $\rightarrow$ Indirizzo fisico.
## Definizioni di Chiave
- **primary key (PK):** sottolineato nello schema E-R (es. `id_cliente`);
	- **Chiave Primaria**: Insieme di uno o più attributi che identificano in modo univoco una tupla.
	- **Chiave Candidata**: Insieme minimale di uno o più attributi che possono essere potenzialmente una chiave primaria.
	- **Chiave Non Primaria**: Attributi che non fanno parte della chiave primaria.
- **foreign key (FK):** indicata con un asterisco (es. `*id_fornitore`);
- **chiave semplice:** tupla contenente un'unica chiave primaria;
- **chiave composta:** tupla contenente più chiavi primarie;
- **attributo multivalore:** attributo rappresentato come una lista (es. `colori_preferiti`,  si può avere più colori preferiti).
## Normalizzazione
La **normalizzazione** è il processo di organizzazione delle tabelle per:
- Eliminare ridondanze
- Prevenire anomalie di inserimento, aggiornamento e cancellazione
- Garantire coerenza dei dati

### Prima Forma Normale
No tuple ripetute
- Di solito già si eliminano con la definizione di relazione
No liste di attributi

- **Esempio:**

| Persona | nome  | colori_preferiti  |
| ------- | ----- | ----------------- |
|         | Mario | rosso, blu, viola |
|         | Luca  | blu, arancione    |

Diventa:

| Persona | nome  |
| ------- | ----- |
|         | Mario |

| Colori | nome_colore |
| ------ | ----------- |
|        | blu         |
|        | arancione   |

| colori_preferiti | nome  | colore_preferito |
| ---------------- | ----- | ---------------- |
|                  | Mario | rosso            |
|                  | Luca  | viola            |
|                  | Mario | marrone          |
### Seconda Forma Normale
Soddisfa 1NF
- Bon
Non ci devono essere dipendenze parziali dalla chiave, devono essere solo totali, tutti gli attributi non chiave dipendono dalla completa chiave
- **Esempio:**

| Persona | nome  | cognome | IBAN           | soldi |
| ------- | ----- | ------- | -------------- | ----- |
|         | Mario | Blaze   | IT 405234382N3 | 42    |

Soldi dipende dalla chiave: IBAN

| Persona | nome  | cognome | IBAN           |
| ------- | ----- | ------- | -------------- |
|         | Mario | Blaze   | IT 405234382N3 |

| Conto | IBAN           | soldi |
| ----- | -------------- | ----- |
|       | IT 405234382N3 | 42    |
### Terza Forma Normale
Soddisfa 2NF
- Bon
Nessuna dipendenza transitiva
- $A \to B \to C$, si scompone in 2 tabelle:  $A \to B \bowtie B\to C$

## Esempio Completo di Progettazione Logica

**Schema non normalizzato:** 
**ASCOLTI**: 
(**ID-ASCOLTO**, EMAIL, DATA-ASCOLTO, TITOLO_CANZONE, ARTISTA, NAZIONALITA_ARTISTA, GENERE_ARTISTA, ALBUM, ANNO_ALBUM, ETICHETTA, USERNAME, DURATA)

### 1 Forma Normale
Scorporare GENERE-ARTISTA, perché è una lista di attributi.

**ASCOLTI**: (**ID-ASCOLTO**, EMAIL, DATA-ASCOLTO, TITOLO_CANZONE, **ARTISTA**, NAZIONALITA_ARTISTA, ALBUM, ANNO_ALBUM, ETICHETTA, USERNAME, DURATA)
**GENERE_ARTISTA**: (**ARTISTA**, **GENERE**)

### 2 Forma Normale
Dipendenze parziali

**ASCOLTI** (**ID-ASCOLTO**, USERNAME, DATA-ASCOLTO, TITOLO_CANZONE)
**INDIVIDUO** (**USERNAME**, EMAIL)
**ARTISTI** (**ARTISTA**, NAZIONALITA_ARTISTA)
**CANZONE** (**TITOLO_CANZONE**, ALBUM, DURATA)
**GENERI** (**GENERE**)
**GENERE_ARTISTA** (**ARTISTA**, **GENERE**)
**ALBUM** (**ALBUM**, ANNO_ALBUM, ETICHETTA, ARTISTA)

### 3 Forma Normale
È già in 3 forma normale

**ASCOLTI** (**ID-ASCOLTO**, USERNAME, DATA-ASCOLTO, TITOLO_CANZONE)
**INDIVIDUO** (**USERNAME**, EMAIL)
**ARTISTI** (**ARTISTA**, NAZIONALITA_ARTISTA)
**CANZONE** (**TITOLO_CANZONE**, ALBUM, DURATA)
**GENERI** (**GENERE**)
**GENERE_ARTISTA** (**ARTISTA**, **GENERE**)
**ALBUM** (**ALBUM**, ANNO_ALBUM, ETICHETTA, ARTISTA)

___
# Progettazione Fisica (SAPERE FINO A OBIETTIVI)

## Introduzione

La **progettazione fisica** è l'ultima fase della progettazione di database, in cui lo schema logico viene implementato concretamente su un **DBMS specifico** (Database Management System come MySQL, PostgreSQL, Oracle, SQL Server). In questa fase si prendono decisioni tecniche per ottimizzare **performance**, **sicurezza** e **storage**, considerando le caratteristiche hardware e software del sistema.

### Obiettivi

- **Implementare lo schema logico** sul DBMS scelto
- **Ottimizzare le performance** attraverso indici, partizioni, clustering
- **Definire lo storage fisico** (tipi di dato, dimensioni, compressione)
- **Configurare la sicurezza** (permessi, ruoli, crittografia)
- **Pianificare backup e recovery**
- **Stimare i volumi di dati** e la crescita futura

### Decisioni Tecniche Principali

**1. Scelta dei Tipi di Dato**

```sql
-- Progettazione logica: "nome" è una stringa
-- Progettazione fisica: decisione specifica

nome VARCHAR(100)        -- MySQL/PostgreSQL
nome NVARCHAR2(100)      -- Oracle
nome VARCHAR(100) COLLATE utf8mb4_unicode_ci  -- MySQL con collation
```

Considerazioni:

- Dimensione ottimale per ridurre spreco di spazio
- Supporto internazionale (UTF-8 vs ASCII)
- Performance di ricerca e ordinamento

**2. Creazione di Indici**

Gli **indici** accelerano le query ma rallentano inserimenti/aggiornamenti.

```sql
-- Indice su chiave primaria (creato automaticamente)
PRIMARY KEY (id)

-- Indice su colonne frequentemente cercate
CREATE INDEX idx_cliente_email ON CLIENTE(email);

-- Indice composto per query multi-campo
CREATE INDEX idx_ordine_cliente_data ON ORDINE(cliente_id, data_ordine);

-- Indice UNIQUE per vincoli di unicità
CREATE UNIQUE INDEX idx_prodotto_codice ON PRODOTTO(codice_prodotto);

-- Full-text index per ricerche testuali
CREATE FULLTEXT INDEX idx_prodotto_descrizione ON PRODOTTO(descrizione);
```

**Quando creare indici**:

- ✅ Chiavi esterne (per JOIN veloci)
- ✅ Campi usati in WHERE, ORDER BY, GROUP BY
- ✅ Campi con alta cardinalità (molti valori distinti)
- ❌ Tabelle piccole (overhead maggiore del beneficio)
- ❌ Campi aggiornati frequentemente

**3. Partizionamento**

Dividere tabelle molto grandi in partizioni per migliorare performance e manutenibilità.

```sql
-- Partizionamento per range (es. ordini per anno)
CREATE TABLE ORDINE (
  id INT,
  data_ordine DATE,
  ...
) PARTITION BY RANGE (YEAR(data_ordine)) (
  PARTITION p2023 VALUES LESS THAN (2024),
  PARTITION p2024 VALUES LESS THAN (2025),
  PARTITION p2025 VALUES LESS THAN (2026)
);

-- Partizionamento per hash (distribuzione uniforme)
PARTITION BY HASH(cliente_id) PARTITIONS 4;
```

**4. Denormalizzazione Strategica**

A volte si **violano le forme normali** per migliorare le performance:

```sql
-- Invece di JOIN tra ORDINE e CLIENTE ogni volta
-- Si può duplicare il nome cliente nella tabella ORDINE

ORDINE (
  id,
  cliente_id FK,
  cliente_nome VARCHAR(100),  -- ⚠️ Denormalizzato!
  totale
)
```

**Quando denormalizzare**:

- Query molto frequenti che fanno JOIN costosi
- Dati che cambiano raramente
- Trade-off accettabile tra spazio e velocità

**5. Viste Materializzate**

Salvano il risultato di query complesse per accesso rapido:

```sql
CREATE MATERIALIZED VIEW v_vendite_mensili AS
SELECT 
  YEAR(data_ordine) AS anno,
  MONTH(data_ordine) AS mese,
  SUM(totale) AS vendite_totali
FROM ORDINE
GROUP BY YEAR(data_ordine), MONTH(data_ordine);

-- Aggiornamento periodico
REFRESH MATERIALIZED VIEW v_vendite_mensili;
```

**6. Configurazione Storage**

```sql
-- Scelta del motore di storage (MySQL)
CREATE TABLE PRODOTTO (...) ENGINE=InnoDB;  -- Transazioni ACID
CREATE TABLE LOG (...) ENGINE=MyISAM;       -- Veloce per letture

-- Compressione per risparmiare spazio
CREATE TABLE ARCHIVIO (...) ROW_FORMAT=COMPRESSED;

-- Tablespace personalizzati
CREATE TABLE ORDINE (...) TABLESPACE ts_ordini;
```

**7. Sicurezza e Permessi**

```sql
-- Creazione utenti e ruoli
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'password';
CREATE ROLE 'vendite';

-- Assegnazione permessi
GRANT SELECT, INSERT ON database.ORDINE TO 'vendite';
GRANT SELECT ON database.CLIENTE TO 'vendite';

-- Revoca permessi
REVOKE DELETE ON database.PRODOTTO FROM 'app_user';

-- Crittografia a livello di colonna (dati sensibili)
CREATE TABLE UTENTE (
  id INT,
  email VARCHAR(100),
  password_hash BINARY(64),  -- Hash sicuro, non testo in chiaro
  carta_credito VARBINARY(256) ENCRYPTED  -- Crittografata
);
```

**8. Backup e Recovery**

```sql
-- Backup completo (esempio MySQL)
mysqldump -u root -p database > backup_20260211.sql

-- Backup incrementale
mysqlbinlog mysql-bin.000001 > incremental_backup.sql

-- Point-in-time recovery
-- Ripristino al database alle 14:30 di ieri
```

**9. Monitoraggio e Tuning**

```sql
-- Analisi query lente
EXPLAIN SELECT * FROM ORDINE WHERE cliente_id = 123;

-- Statistiche tabelle
ANALYZE TABLE ORDINE;

-- Cache delle query
SET GLOBAL query_cache_size = 268435456;  -- 256MB
```

### Esempio Completo: Da Logico a Fisico

**Schema Logico**:

```
CLIENTE (id, nome, email, telefono)
ORDINE (id, data, totale, cliente_id FK)
```

**Implementazione Fisica (PostgreSQL)**:

```sql
-- Tabella CLIENTE con ottimizzazioni
CREATE TABLE CLIENTE (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  cognome VARCHAR(100) NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  telefono VARCHAR(20),
  data_registrazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  attivo BOOLEAN DEFAULT TRUE
);

-- Indici per ricerche frequenti
CREATE INDEX idx_cliente_cognome ON CLIENTE(cognome);
CREATE INDEX idx_cliente_email ON CLIENTE(email);

-- Tabella ORDINE con partizionamento
CREATE TABLE ORDINE (
  id SERIAL,
  data_ordine DATE NOT NULL,
  totale NUMERIC(12,2) NOT NULL CHECK (totale >= 0),
  stato VARCHAR(20) DEFAULT 'in_lavorazione',
  cliente_id INT NOT NULL,
  CONSTRAINT fk_cliente FOREIGN KEY (cliente_id) 
    REFERENCES CLIENTE(id) ON DELETE RESTRICT
) PARTITION BY RANGE (data_ordine);

-- Partizioni per anno
CREATE TABLE ORDINE_2024 PARTITION OF ORDINE
  FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
  
CREATE TABLE ORDINE_2025 PARTITION OF ORDINE
  FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Indice sulla chiave esterna
CREATE INDEX idx_ordine_cliente ON ORDINE(cliente_id);
CREATE INDEX idx_ordine_data ON ORDINE(data_ordine DESC);

-- Vista per report comuni
CREATE VIEW v_ordini_recenti AS
SELECT 
  o.id,
  o.data_ordine,
  o.totale,
  c.nome || ' ' || c.cognome AS cliente
FROM ORDINE o
JOIN CLIENTE c ON o.cliente_id = c.id
WHERE o.data_ordine >= CURRENT_DATE - INTERVAL '30 days';
```

### Considerazioni Finali

La progettazione fisica richiede conoscenza di:

- Caratteristiche specifiche del DBMS
- Volumi di dati attesi
- Pattern di accesso (letture vs scritture)
- Requisiti di performance
- Budget hardware
- Requisiti di alta disponibilità

È un processo **iterativo**: si monitora, si misura e si ottimizza continuamente in base ai carichi reali.

---

## Riepilogo del Processo Completo

```
REQUISITI AZIENDALI
        ↓
PROGETTAZIONE CONCETTUALE (Schema E-R)
  - Entità, Attributi, Relazioni, Cardinalità
        ↓
PROGETTAZIONE LOGICA (Schema Relazionale)
  - Tabelle, Chiavi, Normalizzazione
        ↓
PROGETTAZIONE FISICA (Implementazione DBMS)
  - Indici, Partizioni, Ottimizzazioni
        ↓
DATABASE FUNZIONANTE E OTTIMIZZATO
```