---
date: 2026-05-06
tags: [concept, security]
source_count: 3
---

# Firewall

Un **Firewall** è un dispositivo hardware o software posto al perimetro di una rete (o tra segmenti di rete interni) per ispezionare, filtrare e controllare il traffico dati in base a regole (Security Policy).

## Tipologie e Livelli OSI
1. **Packet Filter (L3 / L4):** Applica regole (ACL) esaminando solo gli IP e le Porte sorgente/destinazione. È veloce, ma stateless.
2. **Stateful Inspection (L3 / L4):** Mantiene traccia dello "stato" della connessione TCP. Riconosce i pacchetti appartenenti a sessioni già avviate (es. risposte dal web server), permettendo policy più intelligenti.
3. **Application Level (L7):** Analizza il payload applicativo (HTTP, FTP). Un proxy o NGFW (Next-Generation Firewall). Massimo livello di sicurezza, previene attacchi web complessi, ma ha un alto impatto computazionale.

> ⚠️ **Nota dalle slide:** Gli Application Level Firewall "non sono propriamente dei firewall" ma proxy. A questa categoria appartengono anche DNS criptato e VPN gateway. In sede d'esame, è corretto citarli come "firewall applicativi" ma dimostrare consapevolezza della distinzione è un plus.

## Design Tipico per Esame di Stato
In una progettazione per la Maturità:
- Il **Firewall Esterno (Border Router)** deve implementare NAT (solitamente un *Dynamic PAT* per nascondere la LAN privata e permettere ai dipendenti di navigare su Internet) e bloccare tutto il traffico non sollecitato.
- Il **Firewall Interno** (o un set di policy severe inter-VLAN sul Core Switch) dovrebbe essere di tipo Application Level se si tratta di permettere ad un Web Server nella [[DMZ]] di interrogare il Database della LAN interna, per scongiurare attacchi come le SQL Injection passanti dalla DMZ.

## Fonti Collegate
- [[Sicurezza_Appunti]]
- [[sicurezza_di_rete_slides]]
- [[doc2_sicurezza_cloud_iot]]
