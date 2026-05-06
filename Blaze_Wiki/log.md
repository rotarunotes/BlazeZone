# Registro delle Operazioni (Log)

Questo registro traccia cronologicamente tutte le attività di manutenzione eseguite sul wiki.

## [2026-05-06] init | Inizializzazione Struttura
L'infrastruttura del wiki è stata creata, definendo file di configurazione, indice e log iniziali.

## [2026-05-06] ingest | raw/articolo_memex.md
Acquisizione completata per l'articolo "As We May Think". Create le pagine: wiki/sources/memex_bush_1945, wiki/entities/Vannevar Bush, wiki/concepts/Memex. Indice aggiornato.

## [2026-05-06] update | Aggiunta cartella syntheses
Aggiunta la cartella `wiki/syntheses/` all'architettura in CLAUDE.md e all'indice, per contenere sintesi trasversali e confronti.

## [2026-05-06] ingest | PDF Maturità (SERVER, Sicurezza, VPN)
Eseguito il batch ingest dei documenti PDF. Estrazione testo. Create le pagine fonte (SERVER_Appunti, Sicurezza_Appunti, VPN_Appunti). Creati i concetti (Firewall, DMZ, VPN). Creata la sintesi per l'esame di stato (sintesi_maturita_seconda_prova). Indice aggiornato.

## [2026-05-06] ingest | Slide Didattiche (server 1, sicurezza_di_rete, vpn)
Acquisite 3 nuove fonti slide del docente Zanardelli Alessio. Create pagine fonte: server_1_slides, sicurezza_di_rete_slides, vpn_slides. Creati 5 nuovi concetti: NAT e PAT, IPsec, SSL-TLS, Cablaggio Strutturato, Virtualizzazione. Aggiornate pagine esistenti (Firewall +nota slide, DMZ +servizi/architettura, VPN +classificazione sicurezza/AAA). Indice aggiornato.

## [2026-05-06] ingest | Documento 1 (Fondamenti di Reti) + Documento 2 (Sicurezza, Cloud, IoT)
Acquisite 2 nuove dispense. Create pagine fonte: doc1_fondamenti_reti, doc2_sicurezza_cloud_iot. Creati 5 nuovi concetti: Subnetting e VLSM, VLAN, RAID, Cloud Computing, IoT. Aggiornate pagine esistenti: Cablaggio Strutturato (+mezzi trasmissivi, standard EN-50173), Firewall (+doc2), DMZ (+doc2). Aggiornata sintesi_maturita_seconda_prova con Metodologia Top-Down, VLSM, RAID, Cloud, IoT e Checklist per l'Esame. Indice aggiornato.

## [2026-05-06] ingest | Esame di Stato 2014 (Traccia + Soluzione)
Analizzata la traccia dell'Esame di Stato 2014 (gare automobilistiche con sensori) dal PDF NB_sistemi (pp. 38-43). Gap Analysis: identificati 3 argomenti chiave mancanti nel wiki. Creata pagina fonte: esame_stato_2014. Creati 3 nuovi concetti: Modello ER e Progettazione DB, Architettura Client-Server Web, Continuità del Servizio. Aggiornata sintesi_maturita_seconda_prova con sezioni DB/Web App/Continuità e checklist estesa a 10 punti. Indice aggiornato.

## [2026-05-06] update | Espansione Checklist Operativa Esame di Stato
La checklist sintetica in 10 punti è stata espansa in un prontuario operativo dettagliato (~280 righe). Ogni STEP ora include: cosa fare, cosa scrivere, tabelle d'esempio, diagrammi ASCII, snippet di codice (ACL, SQL, PHP), giustificazioni tecniche e tips per il commissario. Integrati tutti i concetti del wiki in un flusso logico sequenziale.

## [2026-05-06] create | Scaletta Bigliettino
Creata versione ultra-compatta della checklist in 10 step (scaletta.md) per uso come bigliettino. Solo parole chiave, sigle e formule essenziali. Indice aggiornato.

## [2026-05-06] create | Scaletta 3 — Template Professionale
Creato template di progetto di rete professionale (scaletta_3.md) con placeholder compilabili, diagrammi ASCII dell'architettura, configurazioni Cisco IOS (VLAN, DHCP, Crypto Map IPsec, ACL), schema E/R, codice SQL (CREATE TABLE + JOIN), codice PHP (autenticazione + API JSON), tabella RPO/RTO e tabella "Giustificazione Scelte Tecnologiche" con 11 confronti motivati. Indice aggiornato.
