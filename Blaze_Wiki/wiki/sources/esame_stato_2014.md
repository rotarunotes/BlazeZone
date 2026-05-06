---
date: 2026-05-06
tags: [source, exam, 2014, case-study]
source_count: 1
---

# Esame di Stato 2014 — Gare Automobilistiche (Traccia + Soluzione)

**Fonte Originale:** `raw/NB_sistemi teoria-laboratorio_SV esame e simulazione_15-04-26.pdf` (pp. 38-43)

## Traccia
Un gruppo amatoriale di appassionati di gare automobilistiche organizza una competizione su strada con **6 prove speciali**. Su ogni tratta: 5 sensori (FP partenza, FV1/FV2/FV3 intermedi, FA arrivo). I dati devono essere inviati **in tempo reale** al sistema gestionale del gruppo. A fine competizione, la classifica completa va inviata al sistema informativo della **FIA (Federazione Italiana Automobilismo)**.

### Richieste della Traccia
1. Analizzare il problema e descrivere le soluzioni per l'acquisizione dati in tempo reale.
2. Rappresentare graficamente l'architettura di rete.
3. Progettare il sistema di archiviazione con modello **E/R**.
4. Descrivere la logica del software di controllo.
5. Garantire la **continuità del servizio** in caso di interruzione del collegamento.

## Soluzione Proposta (dal libro di testo)

### Architettura di Rete
- **Stazioni sul percorso:** Ogni sensore (fotocellula) è collegato a un **microcontrollore** (MCU con Wi-Fi/3G integrato) che acquisisce i dati e li invia al server del gruppo.
- **Server del Gruppo:** Ospita l'applicazione Web per gestione gara, database risultati e classifica. Raggiungibile via **Internet** dalle stazioni remote.
- **Collegamento FIA:** A fine gara, invio dati al server FIA tramite file **XML** o form web.
- **Tecnologie trasmissive:** Wi-Fi per le stazioni vicine, **3G/4G** per le stazioni su tratti stradali distanti.

### [[Modello ER e Progettazione DB]]
Entità principali: Concorrente, Autoveicolo, Prova, Rilevazione, Sensore.
- Ogni Rilevazione è associata a un Concorrente, una Prova e un Sensore.
- Attributi chiave: tempi parziali, velocità istantanee, penalità, posizione classifica.

### [[Architettura Client-Server Web]]
- **Stack LAMP:** Linux + Apache + MySQL + PHP sul server del gruppo.
- **Lato Client:** HTML5 + CSS + JavaScript per interfaccia di convalida dati.
- **Lato Server:** PHP per logica applicativa, query MySQL per classifica e gestione.

### [[Continuità del Servizio]]
- I dati vengono salvati **localmente** su ogni stazione (file XML su memoria a stato solido del microcontrollore).
- In caso di interruzione Internet, i dati vengono **re-inviati** automaticamente quando la connessione viene ristabilita.
- Garantisce recupero dati anche in **tempo differito**.

## Concetti Chiave Emersi (Gap Analysis)
Argomenti richiesti dalla traccia **non ancora nel wiki** prima di questa ingestion:
- Modello ER / Progettazione Database
- Architettura Client-Server / LAMP Stack
- Continuità del Servizio / Disaster Recovery
- Protocolli Applicativi Web (HTTP, XML)

## Entità/Concetti Collegati
- [[Modello ER e Progettazione DB]]
- [[Architettura Client-Server Web]]
- [[Continuita del Servizio]]
- [[IoT]]
- [[VPN]]
- [[Cablaggio Strutturato]]
