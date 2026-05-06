---
date: 2026-05-06
tags: [source, server, data-center]
source_count: 1
---

# Appunti: Architetture Fisiche e Gestione Server (SERVER.pdf)

**Fonte Originale:** `raw/SERVER.pdf`

## Takeaway Chiave
- **Cablaggio Strutturato e Topologia:** La topologia a stella estesa (gerarchica) è dominante, divisa in CD (Campus Distributor), BD (Building Distributor) e FD (Floor Distributor).
- **Make or Buy (CED vs Server Farm):** Decisione strategica. CED interno offre controllo privacy totale e intervento fisico, ma altissimi costi CAPEX/OPEX. Server Farm esterna (Housing/Hosting) riduce i costi, garantisce continuità elettrica e riduce la superficie d'attacco sulla LAN aziendale.
- **Virtualizzazione:** Approccio per ottimizzare le risorse fisiche di un server (es. Hypervisor ESXi/Proxmox), riducendo costi e consumi e migliorando i tempi di provisioning.
- **Design VLAN:** Segmentazione logica necessaria per il controllo dei domini di broadcast e per la sicurezza.

## Sintesi dell'LLM
Questi appunti forniscono la base per la progettazione del "Livello 1" e l'allocazione dei servizi. La traccia d'esame tipica richiede di giustificare la scelta di allocazione dei server. Il "trucco" suggerito è inserire i DB/Gestionali in un CED interno (VLAN dedicata e sicura) e i Web Server / E-Commerce in Hosting presso una Server Farm Esterna, oppure in una [[DMZ]] locale se proprio necessario, per limitare i rischi di intrusione diretta.

## Entità/Concetti Collegati
- [[VLAN]]
- [[DMZ]]
