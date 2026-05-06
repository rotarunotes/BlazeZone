---
date: 2026-05-06
tags: [source, security, firewall, nat]
source_count: 1
---

# Appunti: Sicurezza Perimetrale (Sicurezza.pdf)

**Fonte Originale:** `raw/Sicurezza.pdf`

## Takeaway Chiave
- **Difesa Perimetrale ([[Firewall]]):** Il nodo centrale che separa LAN e Internet. Si divide in Packet Filter (L3/L4), Stateful Inspection (L3/L4 con tracciamento stato connessione), e Application Level (L7).
- **[[DMZ]] (Demilitarized Zone):** Area logica per i servizi esposti al pubblico (Web Server, Mail Server), essenziale per evitare accessi diretti dall'esterno alla LAN sensibile.
- **NAT / PAT:** Traduzione degli indirizzi per mappare IP privati su IP pubblici. Dynamic PAT (Port Forwarding inverso) per far navigare gli host privati; Static PAT (Port Forwarding diretto) per esporre servizi in DMZ in modo bidirezionale ma controllato.

## Sintesi dell'LLM
Il focus di questi appunti è la progettazione sicura delle reti LAN/WAN per la Seconda Prova. Il commissario cerca la motivazione delle scelte tecniche: l'uso di un doppio firewall per creare una DMZ fisica, l'applicazione corretta del NAT (specificando Dynamic PAT o Static PAT), e la configurazione delle ACL per il traffico intra-VLAN (es. il Web Server in DMZ che deve accedere al DB interno solo tramite porta specifica su Application Firewall).

## Entità/Concetti Collegati
- [[Firewall]]
- [[DMZ]]
