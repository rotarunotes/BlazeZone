---
date: 2026-05-06
tags: [source, vpn, networking]
source_count: 1
---

# Appunti: Reti VPN (VPN-1.pdf)

**Fonte Originale:** `raw/VPN-1.pdf`

## Takeaway Chiave
- **Architetture [[VPN]]:** Remote-Access (per utenti mobili/smart worker verso la LAN aziendale) e Site-to-Site (LAN-to-LAN, per collegare Sedi centrali a filiali).
- **Sicurezza e AAA:** Authentication, Authorization, Accounting. Fondamentale per i Remote-Access.
- **Protocolli:** 
  - **IPsec:** Lavora al Livello 3 (Network). Usa AH (autenticazione/integrità), ESP (aggiunge la cifratura/confidenzialità), e IKE (negoziazione delle Security Association). Due modalità: Trasporto (Remote) e Tunneling (Site-to-Site, aggiunge nuovo header IP).
  - **SSL/TLS:** Lavora al Livello 5 (Session). Modello Client/Server, protegge il traffico TCP, ideale per Remote-Access per via dell'assenza di configurazioni client complesse.

## Sintesi dell'LLM
La traccia tipica della maturità richiede di interconnettere una Sede HQ, una Filiale, e agenti commerciali. La soluzione di design ottima è un approccio ibrido: Site-to-Site VPN con protocollo IPsec (Modalità Tunneling + ESP) tra i due Security Gateway per le sedi fisse; Remote-Access VPN con protocollo SSL/TLS (e autenticazione forte AAA/MFA) per gli agenti mobili, in modo da evitare overhead di configurazione sui dispositivi degli agenti.

## Entità/Concetti Collegati
- [[VPN]]
- [[IPsec vs SSL]]
