Data: 2026-02-11
[Database](./README.md)
#Puzzle_Of_Knowledge/Computer_Science/Theory/Database
___
# Index
 

___

# Progettazione Basi Di Dati MVC

![[Progettazione_Dati_Logica_Esempio|300]]

# Progettazione Concettuale

Individuo tute le entità che vanno a interferire nel mio software
## Schema E-R




## Cardinalità

La **cardinalità** definisce quante volte un'entità può essere collegata a un'altra entità in una relazione, specificando il numero minimo e massimo di associazioni possibili.

Tipi di cardinalità:
- $1:1$
- $1:N$
- $N:M$ 

# Progettazione Logica

# Progettazione fisica

___
# Introduzione

La **progettazione di database** è il processo sistematico attraverso il quale si definisce la **struttura**, l'**organizzazione** e **relazioni** dei dati all'interno di un sistema informativo. 

Un database ben progettato **garantisce**:
1) Efficienza.
2) Integrità dei dati.
3) Facilità di manutenzione.
4) Scalabilità del sistema.

La progettazione si articola in diverse fasi, ognuna con obiettivi specifici
- dalla comprensione dei requisiti alla realizzazione fisica del database. 

---

# Progettazione Concettuale

La **progettazione concettuale** è la prima fase della progettazione di database. 
L'obiettivo è comprendere **cosa** deve essere rappresentato nel database, senza preoccuparsi di **come** verrà implementato. 
In questa fase si identificano le **entità** principali, i loro **attributi** e le **relazioni** che intercorrono tra di esse.

## Obiettivi della progettazione concettuale
- **Identificare le entità**: Oggetti o concetti rilevanti per il sistema (es. Cliente, Prodotto, Ordine)-
- **Definire gli attributi**: Caratteristiche che descrivono ogni entità (es. nome, cognome, email).
- **Stabilire le relazioni**: Come le entità sono collegate tra loro (es. Cliente effettua Ordini)-
- **Rappresentare i vincoli**: Le cardinalità, definire quante istanze sono coinvolte nelle relazioni (es. un ordine deve avere almeno un prodotto).
  
## Cardinalità
La **cardinalità** definisce le regole quantitative delle relazioni tra entità. 
La cardinalità stabilisce:
- **Numero minimo** di occorrenze (cardinalità minima): 0 o 1
- **Numero massimo** di occorrenze (cardinalità massima): 1 o N (molti)
Si esprime con la notazione **(min, max)** su entrambi i lati della relazione.

**Notazione (min, max)**:

- (0,1): opzionale, al massimo uno
- (1,1): obbligatorio, esattamente uno
- (0,N): opzionale, può essere molti
- (1,N): obbligatorio, almeno uno


## Schema E-R (Entità-Relazione)
Lo **Schema E-R (Entity-Relationship)** è un modello grafico utilizzato nella progettazione concettuale per rappresentare visivamente entità, attributi e relazioni.

![[Schema_E-R_Esempio|1000]]

---

## Progettazione Logica

### Introduzione

La **progettazione logica** è la seconda fase della progettazione di database, in cui lo schema concettuale (E-R) viene trasformato in uno **schema logico** compatibile con il modello di database scelto, tipicamente il **modello relazionale**. In questa fase si decide come rappresentare entità, attributi e relazioni attraverso **tabelle**, mantenendo le proprietà e i vincoli definiti nella fase concettuale.

### Obiettivi

- **Tradurre lo schema E-R in tabelle relazionali**
- **Eliminare ridondanze** e anomalie
- **Normalizzare** i dati (applicare le forme normali)
- **Definire chiavi primarie ed esterne**
- **Garantire l'integrità referenziale**
- Ottimizzare per performance e scalabilità

### Regole di Traduzione E-R → Relazionale

**1. Ogni ENTITÀ diventa una TABELLA**

```
Entità CLIENTE → Tabella CLIENTE
Attributi: id, nome, cognome, email
```

**2. Relazioni 1:N**

- La chiave primaria del lato "1" diventa chiave esterna nel lato "N"

```
DIPARTIMENTO (1) ──── (N) DIPENDENTE

Tabella DIPARTIMENTO (id, nome)
Tabella DIPENDENTE (id, nome, cognome, dipartimento_id FK)
```

**3. Relazioni N:M**

- Si crea una **tabella di associazione** con le chiavi di entrambe le entità

```
STUDENTE (N) ──── (M) CORSO

Tabella STUDENTE (id, nome, cognome)
Tabella CORSO (id, titolo, crediti)
Tabella ISCRIZIONE (id_studente FK, id_corso FK, data_iscrizione)
```

**4. Relazioni 1:1**

- Si può includere la FK in una delle due tabelle
- Oppure creare una tabella separata (meno comune)

```
PERSONA (1) ──── (1) PASSAPORTO

Opzione 1: PASSAPORTO (id, numero, data_scadenza, persona_id FK UNIQUE)
Opzione 2: Tabella separata POSSESSO (persona_id FK, passaporto_id FK)
```

### Normalizzazione

La **normalizzazione** è il processo di organizzazione delle tabelle per:

- Eliminare ridondanze
- Prevenire anomalie di inserimento, aggiornamento e cancellazione
- Garantire coerenza dei dati

**Forme Normali Principali**:

**1NF (Prima Forma Normale)**:

- Ogni campo contiene valori atomici (non ripetuti)
- Niente gruppi ripetuti

**2NF (Seconda Forma Normale)**:

- Soddisfa 1NF
- Ogni attributo non chiave dipende completamente dalla chiave primaria

**3NF (Terza Forma Normale)**:

- Soddisfa 2NF
- Nessuna dipendenza transitiva (attributi non chiave non dipendono da altri attributi non chiave)

### Esempio Completo di Progettazione Logica

**Schema E-R di partenza**:

```
CLIENTE (1) ──── EFFETTUA ──── (N) ORDINE (N) ──── CONTIENE ──── (M) PRODOTTO
```

**Schema Logico (Tabelle)**:

```sql
CLIENTE (
  id INT PRIMARY KEY,
  nome VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  data_registrazione DATE
)

ORDINE (
  id INT PRIMARY KEY,
  data_ordine DATE,
  totale DECIMAL(10,2),
  cliente_id INT,
  FOREIGN KEY (cliente_id) REFERENCES CLIENTE(id)
)

PRODOTTO (
  id INT PRIMARY KEY,
  nome VARCHAR(100),
  prezzo DECIMAL(10,2),
  quantita_magazzino INT
)

RIGA_ORDINE ( -- Tabella di associazione N:M
  ordine_id INT,
  prodotto_id INT,
  quantita INT,
  prezzo_unitario DECIMAL(10,2),
  PRIMARY KEY (ordine_id, prodotto_id),
  FOREIGN KEY (ordine_id) REFERENCES ORDINE(id),
  FOREIGN KEY (prodotto_id) REFERENCES PRODOTTO(id)
)
```

### Vincoli di Integrità

Durante la progettazione logica si definiscono:

- **Integrità di entità**: ogni tabella deve avere una chiave primaria
- **Integrità referenziale**: le chiavi esterne devono riferirsi a chiavi primarie esistenti
- **Integrità di dominio**: vincoli sui valori (NOT NULL, CHECK, UNIQUE)
- **Integrità aziendale**: regole di business specifiche

---

## Progettazione Fisica

### Introduzione

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