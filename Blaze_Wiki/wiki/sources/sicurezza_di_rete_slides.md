---
date: 2026-05-06
tags: [source, slides, security, firewall, nat]
source_count: 1
author: Zanardelli Alessio
---

# Slide: Sicurezza di Rete (sicurezza_di_rete.pdf)

**Fonte Originale:** `raw/sicurezza_di_rete.pdf`
**Tipo:** Presentazione didattica (18 slide)

## Takeaway Chiave
- **[[Firewall]]:** Componente di difesa perimetrale (HW o SW). Filtra pacchetti in/out secondo policy. Necessario ricondurre la sicurezza a un solo nodo verso l'esterno. Esistono anche firewall personali (per singolo PC).
- **Categorie Firewall:** Packet Filter (ACL, L3/L4), Stateful Inspection (traccia stato connessione), Application Level (proxy, DNS criptato, VPN — nota: "non proprio dei firewall" secondo le slide).
- **[[DMZ]]:** Zona con meno regole, delimita LAN da WAN. Servizi tipici: Web, Mail, FTP, VoIP. Anche i proxy server vengono installati in DMZ. Accesso da DMZ verso DB interni → controllato da Application Firewall. Architettura a singolo o doppio firewall.
- **[[NAT e PAT]]:**
  - **Static NAT:** 1:1 bidirezionale, non conserva indirizzi.
  - **Static PAT:** Port Forwarding, bidirezionale, più host su un unico IP pubblico grazie a combinazione IP+porta.
  - **Dynamic NAT:** Più IP privati → più IP pubblici, bidirezionale finché la connessione è attiva.
  - **Dynamic PAT:** Porta random, **unidirezionale** (l'esterno non può iniziare la connessione).
  - **Policy NAT:** Traduce sorgente in base a sorgente E destinazione.
  - **Twice NAT:** Traduce sia sorgente che destinazione.

## Integrazione con Fonti Precedenti
Le slide confermano e rafforzano tutto il contenuto di [[Sicurezza_Appunti]]. Il dettaglio aggiuntivo principale è la nota che Application Level Firewall "non sono propriamente firewall" (sono proxy), e il chiarimento completo sulle 6 varianti NAT/PAT con direzionalità.

## Entità/Concetti Collegati
- [[Firewall]]
- [[DMZ]]
- [[NAT e PAT]]
