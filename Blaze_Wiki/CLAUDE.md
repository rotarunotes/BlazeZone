# LLM Wiki Schema

Questo file definisce le convenzioni, l'architettura e i flussi di lavoro per mantenere questo Wiki (Second Brain). L'LLM che opera in questo vault deve seguire scrupolosamente queste istruzioni.

## 1. Architettura
- **`raw/`**: Fonti originali fornite dall'utente. I file in questa cartella sono IMMUTABILI. L'LLM deve leggerli, non scriverci mai o modificarli.
- **`raw/assets/`**: Immagini scaricate localmente e allegati.
- **`wiki/`**: File markdown generati e gestiti dall'LLM.
  - **`wiki/entities/`**: Pagine specifiche di persone, organizzazioni o luoghi.
  - **`wiki/concepts/`**: Pagine tematiche, idee o modelli mentali.
  - **`wiki/sources/`**: Pagine di riassunto generate per ogni fonte analizzata in `raw/`.
  - **`wiki/syntheses/`**: Pagine di sintesi trasversali o confronti tra più fonti/concetti.
- **`index.md`**: Catalogo del Wiki, aggiornato automaticamente.
- **`log.md`**: Registro cronologico append-only di tutte le operazioni dell'LLM.

## 2. Flussi di lavoro dell'LLM

### Ingest (Acquisizione di una Fonte)
Quando l'utente inserisce un nuovo file in `raw/` e chiede di acquisirlo (ingest):
1. **Lettura**: Leggi attentamente il contenuto del file.
2. **Riassunto**: Crea una pagina in `wiki/sources/` contenente i takeaway chiave, il riassunto conciso e la valutazione della fonte.
3. **Integrazione**: Identifica enti o concetti citati. Crea nuove pagine in `wiki/entities/` o `wiki/concepts/` se non esistono. Se esistono, AGGIORNA le pagine esistenti con le nuove informazioni (rafforzando punti o evidenziando contraddizioni).
4. **Cross-Reference**: Inserisci link wiki (es. `[[Nome Concetto]]`) per connettere la nuova pagina fonte e le pagine entità/concetto.
5. **Indice**: Aggiungi le nuove pagine create a `index.md`.
6. **Log**: Aggiungi una voce a `log.md` usando il formato: `## [YYYY-MM-DD] ingest | Nome Fonte`.

### Query (Interrogazione)
Quando l'utente fa una domanda:
1. Consulta prima `index.md` per individuare le pagine rilevanti in `wiki/`.
2. Leggi le pagine rilevanti per sintetizzare una risposta, usando sempre le citazioni (link wiki).
3. Se l'utente approva la risposta per il mantenimento, trasformala in una nuova pagina in `wiki/concepts/` (o altro modulo come tabella, documento di sintesi).

### Lint (Pulizia e Manutenzione)
Se l'utente chiede un'operazione di `lint`:
1. Cerca pagine orfane (non linkate da altre pagine).
2. Cerca contraddizioni non risolte.
3. Suggerisci concetti frequentemente menzionati che meriterebbero una pagina propria.

## 3. Regole e Convenzioni Generali
- Tutte le pagine in `wiki/` dovrebbero avere un Frontmatter YAML (es. `tags`, `date`, `source_count`).
- Assicurati che l'utente non debba mai fare lavori di contabilità, linkaggio o mantenimento. È responsabilità dell'LLM.
- **Autonomia**: A partire dal 06/05/2026, l'LLM opererà in completa autonomia per le operazioni di ingest, lint e query, applicando direttamente le modifiche senza la necessità di richiedere preventiva approvazione per i piani di implementazione.
