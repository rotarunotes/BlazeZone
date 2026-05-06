---
date: 2026-05-06
tags: [concept, networking, security]
source_count: 1
---

# VLAN (Virtual Local Area Network)

Le **VLAN** permettono di creare reti locali logicamente separate sullo stesso switch fisico, isolando i domini di broadcast.

## Perché usare le VLAN?
- **Sicurezza:** Isolare il traffico tra reparti (es. VLAN Ospiti non può vedere VLAN Amministrazione).
- **Performance:** Ridurre il traffico broadcast confinandolo alla sola VLAN di appartenenza.
- **Flessibilità:** Spostare logicamente un utente da un reparto all'altro senza cambiare il cablaggio fisico.

## Requisiti Tecnici
- Switch **Managed** (gestiti) — più costosi dei non-managed ma indispensabili.
- Protocollo **IEEE 802.1Q (Trunking):** Aggiunge un tag di 4 byte all'header Ethernet per identificare la VLAN di appartenenza del frame. I link tra switch (trunk) trasportano frame di più VLAN contemporaneamente.

## Inter-VLAN Routing
Per far comunicare host su VLAN diverse serve un dispositivo di **Livello 3**:
- **Router-on-a-Stick:** Un singolo router con sub-interfacce (una per VLAN) collegato allo switch via un trunk 802.1Q. Economico ma collo di bottiglia su reti grandi.
- **Switch Layer 3:** Il Core Switch esegue direttamente il routing inter-VLAN con performance molto superiori. **Scelta consigliata all'esame.**

## Design Tipico per Esame di Stato

| VLAN ID | Dipartimento | Rete / Subnet | Default Gateway |
|---|---|---|---|
| VLAN 10 | Management | 10.1.10.0/24 | 10.1.10.254 |
| VLAN 20 | Produzione (IoT) | 10.1.20.0/24 | 10.1.20.254 |
| VLAN 30 | CED Interno (Dati) | 10.1.30.0/24 | 10.1.30.254 |
| VLAN 99 | Management Devices | 10.1.99.0/24 | 10.1.99.254 |

## Fonti Collegate
- [[doc2_sicurezza_cloud_iot]]
- [[SERVER_Appunti]]
