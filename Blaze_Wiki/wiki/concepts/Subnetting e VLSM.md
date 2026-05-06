---
date: 2026-05-06
tags: [concept, networking, subnetting]
source_count: 1
---

# Subnetting e VLSM

Il **Subnetting** è la suddivisione di una rete IP in sottoreti più piccole. Il **VLSM (Variable Length Subnet Mask)** permette di assegnare sottoreti di dimensioni diverse, ottimizzando l'uso degli indirizzi IP.

## Perché fare Subnetting?
- **Ridurre i domini di broadcast** → miglioramento delle performance.
- **Isolare i reparti** → sicurezza (es. Amministrazione non vede i PC degli Studenti).
- **Gestione ottimale degli IP** → meno sprechi rispetto a subnet di dimensioni fisse.

## Procedura VLSM (da sapere a memoria per l'esame)

1. **Elenca i reparti** in ordine **decrescente** di host richiesti.
2. Per ogni reparto, trova la **potenza di 2** che copre il numero di host (+2 per indirizzo di rete e broadcast).
3. Calcola i bit host e i bit rete: `bit rete = 32 - bit host`.
4. Assegna la subnet partendo dall'IP successivo a quello occupato dalla subnet precedente.

## Esempio Pratico (Scenario d'Esame)

**Rete assegnata:** `192.168.10.0/24` (256 indirizzi)

| Reparto | Host | Potenza 2 | Bit Host | Prefix | Subnet | Range Utilizzabile | Broadcast |
|---|---|---|---|---|---|---|---|
| Produzione | 100 | 2⁷ = 128 | 7 | /25 | 192.168.10.0/25 | .1 – .126 | .127 |
| Amministrazione | 50 | 2⁶ = 64 | 6 | /26 | 192.168.10.128/26 | .129 – .190 | .191 |
| Direzione | 20 | 2⁵ = 32 | 5 | /27 | 192.168.10.192/27 | .193 – .222 | .223 |
| *Libero* | — | — | — | — | 192.168.10.224/27 | — | — |

> 💡 **Tip Esame:** Il blocco rimanente (.224-.255) va riservato per espansioni future o link Point-to-Point (/30 tra router). Citare sempre la scalabilità.

## Subnet Mask Comuni (Cheat Sheet)

| CIDR | Mask | Host Utilizzabili |
|---|---|---|
| /24 | 255.255.255.0 | 254 |
| /25 | 255.255.255.128 | 126 |
| /26 | 255.255.255.192 | 62 |
| /27 | 255.255.255.224 | 30 |
| /28 | 255.255.255.240 | 14 |
| /30 | 255.255.255.252 | 2 (link P2P) |

## Fonti Collegate
- [[doc1_fondamenti_reti]]
