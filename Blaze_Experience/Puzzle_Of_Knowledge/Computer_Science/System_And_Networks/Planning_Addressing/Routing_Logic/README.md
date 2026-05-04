Data: 2026-05-04
[Planning_Addressing](../README.md)
#Puzzle_Of_Knowledge/Computer_Science/System_And_Networks/Planning_Addressing/Routing_Logic
___
# Routing_Logic
___
# Indice
- [Forwarding_Decisions](./Forwarding_Decisions.md)
- [Static_Routing](./Static_Routing.md)
- [Dynamic_Routing](./Dynamic_Routing.md)
- [First_Hop_Redundancy](./First_Hop_Redundancy.md)
___

``` JAVA
# PROMPT DI GENERAZIONE DOCUMENTAZIONE TECNICA: ROUTING LOGIC

### CONTEXT
Agisci in qualità di Docente Esperto in Sistemi e Reti. Il tuo compito è redigere del materiale didattico di alto livello per studenti di un Istituto Tecnico Superiore (ITS). L'obiettivo è creare una documentazione tecnica in formato Markdown, focalizzata sulla "Routing Logic", che sia sintetica, precisa e pronta per essere integrata in un repository di studio professionale.

### OBJECTIVE
Genera quattro sezioni distinte in formato Markdown, coprendo i seguenti macro-argomenti:
1. **Forwarding Decisions**: Il processo decisionale interno del router.
2. **Static Routing**: Tipologie, configurazione e scenari d'uso.
3. **Dynamic Routing**: Classificazione, algoritmi e metriche.
4. **First Hop Redundancy (FHRP)**: Logica dell'alta affidabilità del gateway.

### STYLE & AUDIENCE
- **Stile**: Tecnico-Schematico. Usa un linguaggio professionale ma diretto.
- **Audience**: Studenti avanzati (livello post-diploma/universitario).
- **Regole Mandatorie**:
    - Evita paragrafi prolissi; prediligi elenchi puntati.
    - Usa il **grassetto** per i termini tecnici chiave.
    - Utilizza **TABELLE COMPARATIVE** per ogni sezione per confrontare parametri o tecnologie (es. RIB vs FIB, Statico vs Dinamico, Distance Vector vs Link State).
    - Inserisci la dicitura `####metti un immagine qua` dove uno schema logico è fondamentale.

### RESPONSE STRUCTURE (MARKDOWN)
Per ogni argomento, rispetta questa gerarchia:
1. **Titolo H1**.
2. **Introduzione**: Massimo 3 righe per definire il concetto.
3. **Tabella Tecnica Riassuntiva**: Sintesi dei parametri chiave.
4. **Corpo Centrale**: Spiegazione schematica basata sulla scaletta fornita sotto.

### OPERATIONAL PROCEDURE (THINK STEP-BY-STEP)
Per garantire la massima precisione, elabora la risposta seguendo questi passaggi:
1. **Fase di Analisi**: Definisci i criteri di priorità (LPM, AD, Metrica) per il forwarding.
2. **Fase di Sviluppo - Statico**: Distingui le rotte per tipologia (Default, Floating, Summary).
3. **Fase di Sviluppo - Dinamico**: Categorizza i protocolli focalizzandoti su IGP/EGP e sulla logica degli algoritmi (Bellman-Ford vs Dijkstra).
4. **Fase di Sviluppo - FHRP**: Spiega il concetto di astrazione (Virtual IP/MAC) e i meccanismi di Failover (Hello/Hold timers).
5. **Verifica**: Assicurati che ogni sezione contenga almeno una tabella e i placeholder per le immagini.

### DETAILED OUTLINE (FOLLOW THIS)
Segui fedelmente questa scaletta per i contenuti:
- **Forwarding Decisions**: Analisi Frame L2, Decapsulamento, RIB vs FIB (CEF), Longest Prefix Match, Process vs Fast Switching.
- **Static Routing**: Vantaggi/Svantaggi, Stub networks, Standard/Default/Summary/Floating routes (AD), Next-hop vs Exit Interface.
- **Dynamic Routing**: Strutture dati, Classificazioni (IGP/EGP, DV/LS), Metriche (Hop Count, Costo, Bandwidth), Concetto di Convergenza.
- **FHRP**: Single Point of Failure, logica Virtual Router, differenze sintetiche tra HSRP, VRRP e GLBP, meccanismi di Preemption e Object Tracking.

### TONE
Professionale, didattico, orientato all'efficienza informativa e rigoroso.
```