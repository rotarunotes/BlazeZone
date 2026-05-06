---
date: 2026-05-06
tags: [source, networking, design, subnetting]
source_count: 1
---

# Documento 1: Fondamenti di Reti e Architetture (Teoria e Progettazione)

**Fonte Originale:** `raw/Documento 1 - Fondamenti di Reti e Architetture.pdf`
**Tipo:** Dispensa strutturata (5 pagine)

## Takeaway Chiave

### 1. Metodologia di Progettazione
- **Analisi dei Requisiti:** Divisi in Funzionali (cosa deve fare la rete: VoIP, VPN, Web Server pubblico) e Non Funzionali (banda minima, latenza, privacy, scalabilità, budget).
- **[[Approccio Top-Down vs Bottom-Up]]:**
  - **Top-Down (consigliato all'esame):** Si parte dai livelli alti OSI (applicazioni), si stima la banda, si progetta l'architettura logica (IP/VLAN) e solo alla fine si sceglie l'hardware. Alta scalabilità ma richiede lunga analisi iniziale.
  - **Bottom-Up:** Si parte dal Livello Fisico (comprare switch, cablare). Veloce ma rischioso: colli di bottiglia e incompatibilità.

### 2. Infrastrutture Fisiche e Cablaggio Strutturato
- Conferma e integra [[Cablaggio Strutturato]]: BD (cuore, locale tecnico sicuro con UPS), FD (armadio rack per piano), TO (prese RJ45).
- **[[Mezzi Trasmissivi]]:**

| Mezzo | Quando Usarlo | Pro | Contro |
|---|---|---|---|
| Doppino Rame (Cat 6/6A) | Cablaggio orizzontale FD→PC, AP, telecamere IP (PoE) | Economico, facile, PoE | Max 100m, soggetto a EMI |
| Fibra Ottica | Dorsali verticali BD↔FD, dorsali campus tra edifici | Immune EMI, 10-100 Gbps, km di distanza | Costosa, fragile, giuntatrici |
| Wi-Fi 6 (802.11ax) | Dispositivi mobili, sale riunioni, BYOD | Flessibilità, zero cablaggio | Mezzo condiviso, ostacoli, richiede WPA3/RADIUS |

### 3. Indirizzamento IP e Subnetting
- **IP Privati (RFC 1918):** `192.168.x.x`, `10.x.x.x`. Non routabili su Internet → necessitano [[NAT e PAT]].
- **DHCP:** Assegna automaticamente IP/Mask/GW/DNS ai client. Stampanti e server → IP statico escluso dal pool.
- **[[Subnetting e VLSM]]:** Esempio pratico completo con rete `192.168.10.0/24` divisa per 3 reparti:
  - Produzione (100 host) → /25 (128 IP, range .1-.126)
  - Amministrazione (50 host) → /26 (64 IP, range .129-.190)
  - Direzione (20 host) → /27 (32 IP, range .193-.222)
  - Blocco .224-.255 libero per espansioni o link P2P (/30).

## Entità/Concetti Collegati
- [[Cablaggio Strutturato]]
- [[Subnetting e VLSM]]
- [[VLAN]]
- [[NAT e PAT]]
