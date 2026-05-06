---
date: 2026-05-06
tags: [concept, database, design]
source_count: 1
---

# Modello ER e Progettazione DB

Il **Modello Entità-Relazione (E/R)** è lo strumento fondamentale per la progettazione concettuale di un database relazionale. All'esame di Stato viene quasi sempre richiesto.

## Fasi della Progettazione

### 1. Progettazione Concettuale (Modello E/R)
- Identifica le **Entità** (es. Cliente, Ordine, Prodotto).
- Definisci gli **Attributi** per ogni entità (chiave primaria sottolineata).
- Stabilisci le **Relazioni** tra entità con le **cardinalità** (1:1, 1:N, N:N).

### 2. Progettazione Logica (Modello Relazionale)
- Trasforma il modello E/R in **tabelle** (relazioni).
- Le relazioni 1:N → chiave esterna nella tabella lato "N".
- Le relazioni N:N → tabella ponte (associativa) con le chiavi delle due entità.
- **Normalizzazione:** Almeno fino alla 3FN (Terza Forma Normale).
  - 1FN: Attributi atomici (es. "Indirizzo" → Via, Città, CAP separati).
  - 2FN: Ogni attributo non-chiave dipende dall'intera chiave primaria.
  - 3FN: Nessuna dipendenza transitiva.

### 3. Progettazione Fisica
- Scelta del DBMS (MySQL, PostgreSQL, SQL Server).
- Indici sulle colonne usate nei filtri e JOIN.
- [[RAID]] per la sicurezza dei dati.

## Esempio d'Esame (Esame 2014 — Gare Auto)

```
CONCORRENTE (CodConcorrente, Nominativo, Indirizzo)
AUTOVEICOLO (Targa, Marca, Modello, CodConcorrente*)
PROVA (CodProva, Descrizione, DataProva)
SENSORE (CodSensore, Tipo, Posizione, CodProva*)
RILEVAZIONE (CodRilevazione, Tempo, Velocita, CodSensore*, Targa*)
CLASSIFICA (Posizione, TempoTotale, Penalita, CodConcorrente*, CodProva*)
```

## Tips per l'Esame
- **Disegna SEMPRE il diagramma E/R** prima di scrivere le tabelle.
- Indica le cardinalità sulle linee di relazione.
- Specifica i tipi di dato (VARCHAR, INT, DATETIME, DECIMAL).
- Menziona la normalizzazione almeno fino alla 1FN.

## Fonti Collegate
- [[esame_stato_2014]]
