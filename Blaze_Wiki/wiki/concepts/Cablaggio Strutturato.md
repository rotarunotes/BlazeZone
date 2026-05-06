---
date: 2026-05-06
tags: [concept, server, architecture]
source_count: 3
---

# Cablaggio Strutturato

Il **Cablaggio Strutturato** è l'insieme delle regole (standard **EN-50173** / **TIA-EIA-568**) che definiscono dove posizionare e collegare tra loro i nodi di una rete LAN, garantendo ordine, manutenibilità ed espandibilità.

## Topologia Prevalente: Stella Estesa (Gerarchica)
Più topologie a stella interconnesse tra loro.
- **Pro:** Fault-tolerance, Flessibilità, Espandibilità.
- **Contro:** Maggiore cablaggio, vulnerabilità in caso di guasto del centro stella (Single Point of Failure).

## I Tre Livelli Gerarchici

| Livello | Sigla | Ruolo |
|---|---|---|
| 1° livello | **CD** (Campus Distributor) | Centro stella di comprensorio. Ospita il CED e il Core Switch L3. |
| 2° livello | **BD** (Building Distributor) | Centro stella di edificio. Collegato al CD tramite dorsale in Fibra Ottica. |
| 3° livello | **FD** (Floor Distributor) | Centro stella di piano. Switch Access L2 con PoE per AP Wi-Fi e VoIP. |

## Tipi di Cablaggio
- **Verticale (VCC - Vertical Cross-Connect):** Dorsale tra CD e BD, tipicamente in **Fibra Ottica** (immunità a EMI).
- **Orizzontale (HCC - Horizontal Cross-Connect):** Dai FD alle prese utente (TO - Telecommunications Outlet), tipicamente in **Rame Cat 6a/7** per Gigabit Ethernet.

## Dettaglio Pratico (dal Documento 1)
- **BD (Centro Stella d'Edificio):** Il "cuore". Ospita Router, [[Firewall]], Server principali e Core Switch. Va posizionato in locale tecnico sicuro, climatizzato, con **UPS** e controllo accessi.
- **FD (Armadio di Piano):** Un armadio rack per ogni piano, ospita gli switch di accesso.
- **TO (Telecommunications Outlet):** Le prese RJ45 al muro, da cui partono i cavi patch verso i PC.

## Scelta dei Mezzi Trasmissivi

| Mezzo | Quando Usarlo | Pro | Contro |
|---|---|---|---|
| **Doppino Rame** (Cat 6/6A) | Cablaggio orizzontale FD→PC, AP, telecamere IP (PoE) | Economico, facile, porta dati+alimentazione (PoE) | Max 100m, soggetto a EMI |
| **Fibra Ottica** | Dorsali verticali BD↔FD, dorsali campus tra edifici | Immune EMI, 10-100 Gbps, copre km | Costosa, fragile, giuntatrici ottiche |
| **Wi-Fi 6** (802.11ax) | Dispositivi mobili, sale riunioni, BYOD | Flessibilità, zero cablaggio postazioni | Mezzo condiviso, ostacoli, richiede WPA3/RADIUS |

## Fonti Collegate
- [[SERVER_Appunti]]
- [[server_1_slides]]
- [[doc1_fondamenti_reti]]
