---
date: 2026-05-06
tags: [concept, networking, security]
source_count: 2
---

# NAT e PAT

Il **Network Address Translation (NAT)** e il **Port Address Translation (PAT)** sono meccanismi di traduzione degli indirizzi IP che permettono di mappare IP privati su IP pubblici (e viceversa), indispensabili per connettere una LAN privata a Internet.

## Differenza Fondamentale
- **NAT:** Modifica solo l'header del livello **Network** (IP).
- **PAT:** Modifica l'header del livello **Network** (IP) E del livello **Transport** (porta TCP/UDP).

## Le 6 Varianti (da sapere per l'esame)

| Variante | Direzione | Traduzione | Uso Tipico |
|---|---|---|---|
| **Static NAT** | Bidirezionale | 1 IP privato ↔ 1 IP pubblico (fisso) | Server con IP dedicato |
| **Static PAT** | Bidirezionale | IP+porta privati ↔ IP+porta pubblici (fisso) | **Port Forwarding** per esporre servizi in [[DMZ]] |
| **Dynamic NAT** | Bidirezionale (finché attiva) | Pool IP privati → Pool IP pubblici (dinamico) | Reti con molti IP pubblici disponibili |
| **Dynamic PAT** | **Unidirezionale** | Molti IP privati → 1 IP pubblico + porta random | **Navigazione dipendenti** (l'esterno NON può iniziare) |
| **Policy NAT** | Variabile | Traduce sorgente in base a sorgente E destinazione | Routing avanzato multi-path |
| **Twice NAT** | Variabile | Traduce sia sorgente che destinazione | Scenari di sovrapposizione IP |

## Regola d'Oro per l'Esame
> **Dynamic PAT** per far navigare i dipendenti (unidirezionale = sicuro).
> **Static PAT** per esporre il Web Server in DMZ (bidirezionale, Port Forwarding).

## Fonti Collegate
- [[Sicurezza_Appunti]]
- [[sicurezza_di_rete_slides]]
